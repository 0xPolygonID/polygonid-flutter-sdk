import 'dart:convert';
import 'dart:typed_data';

import 'package:country_code/country_code.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/credential_credential.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/credential_data.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/auth_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/proof_scope_rules_query_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_body_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/proof_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/zk_proof.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/privadoid_sdk.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/entities/circuit_data_entity.dart';

import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:uuid/uuid.dart';

class LocalIdentityDataSource {
  static const _supportedCircuits = ["credentialAtomicQueryMTP", "credentialAtomicQuerySig"];
  static const Map<String, int> _queryOperators = {
    "\$noop": 0,
    "\$eq": 1,
    "\$lt": 2,
    "\$gt": 3,
    "\$in": 4,
    "\$nin": 5,
  };

  ///
  Future<AuthResponse> getAuthResponse({
    required String identifier,
    required String privateKey,
    required AuthRequest authRequest,
  }) async {
    List<ProofResponse> scope = [];
    if (authRequest.body!.scope != null) {
      for (ProofScopeRequest proofReq in authRequest.body!.scope!.where((scope) => scope.rules?.query != null && _circuitIsSupported(scope))) {
        scope.add(await _loadCircuitFiles(proofReq.circuit_id!).then((circuit) async {
          List<FilterEntity> filters = _getFilters(proofReq.rules!.query!);
          List<ClaimEntity> claims = await PolygonIdSdk.I.credential.getClaims(filters: filters);
          ClaimEntity? authClaim = claims.isNotEmpty ? claims.first : null;

          // FIXME: what if authClaim is null?
          return _getProofResponse(proofReq, privateKey, circuit, authClaim!);
        }));
      }
    }

    return Future.value(AuthResponse(
        id: const Uuid().v4(),
        thid: authRequest.thid,
        to: authRequest.from!,
        from: identifier,
        typ: "application/iden3comm-plain-json",
        type: "https://iden3-communication.io/authorization/1.0/response",
        body: AuthBodyResponse(
          message: authRequest.body?.message,
          scope: scope,
          did_doc: null,//TODO is it right, here we don't have pushToken here?
        )));
  }

  ///
  bool _circuitIsSupported(ProofScopeRequest scopeRequest) {
    return _supportedCircuits.contains(scopeRequest.circuit_id) && (scopeRequest.optional == null || !scopeRequest.optional!);
  }

  ///
  Future<CircuitDataEntity> _loadCircuitFiles(String circuitId) async {
    final circuitDatPath = 'assets/auth/$circuitId.dat';
    final circuitProvingKeyPath = 'assets/auth/$circuitId.zkey';
    ByteData datFile = await rootBundle.load(circuitDatPath);
    ByteData zKeyFile = await rootBundle.load(circuitProvingKeyPath);

    return CircuitDataEntity(circuitId, datFile.buffer.asUint8List(), zKeyFile.buffer.asUint8List());
  }

  List<FilterEntity> _getFilters(ProofScopeRulesQueryRequest proofScopeRulesQueryRequest) {
    List<FilterEntity> filters = [
      FilterEntity(
          name: 'credential.credentialSchema.type',
          value: proofScopeRulesQueryRequest.schema!.type),
    ];
    if (proofScopeRulesQueryRequest.allowedIssuers is List &&
        proofScopeRulesQueryRequest.allowedIssuers!.isNotEmpty) {
      if (proofScopeRulesQueryRequest.allowedIssuers![0] != "*") {
        filters.add(FilterEntity(
            operator: FilterOperator.inList,
            name: 'issuer',
            value: proofScopeRulesQueryRequest.allowedIssuers));
      }
    }

    if (proofScopeRulesQueryRequest.req != null) {
      Map<String, dynamic> request = proofScopeRulesQueryRequest.req!;

      request.forEach((key, map) {
        if (map != null && map is Map) {
          map.forEach((operator, value) {
            filters.addAll(_getFilterByOperator(key, operator, value,
                proofScopeRulesQueryRequest.schema!.type!));
          });
        }
      });
    }

    return filters;
  }

    List<FilterEntity> _getFilterByOperator(field, operator, value, schema) {
      switch (operator) {
        case '\$eq':
          return [
            FilterEntity(
                name: 'credential.credentialSubject.$field', value: value)
          ];
        case '\$lt':
          return [
            FilterEntity(
                operator: FilterOperator.lesser,
                name: 'credential.credentialSubject.$field',
                value: value)
          ];
        case '\$gt':
          return [
            FilterEntity(
                operator: FilterOperator.greater,
                name: 'credential.credentialSubject.$field',
                value: value)
          ];
        case '\$in':
          List<int> values = [];
          List<dynamic> included = value;
          for (int val in included) {
            values.add(val);
          }
          return [
            FilterEntity(
                operator: FilterOperator.inList,
                name: 'credential.credentialSubject.$field',
                value: values)
          ];
        case '\$nin':
          if (schema == "KYCAgeCredential" || schema == "AgeCredential") {
            List<int> excluded = value as List<int>;
            excluded.sort((a, b) => a.compareTo(b));
            FilterEntity lower = FilterEntity(
                operator: FilterOperator.lesser,
                name: 'credential.credentialSubject.$field',
                value: excluded[0]);
            FilterEntity higher = FilterEntity(
                operator: FilterOperator.greater,
                name: 'credential.credentialSubject.$field',
                value: excluded[1]);
            return [
              FilterEntity(
                  operator: FilterOperator.or, name: '', value: [lower, higher])
            ];
          } else if (schema == "KYCCountryOfResidenceCredential" ||
              schema == "CountryOfResidenceCredential") {
            List<int> values = [];
            List<dynamic> excluded = value;
            for (var countryCode in CountryCode.values) {
              int country = countryCode.numeric;
              if (!excluded.contains(country)) {
                values.add(country);
              }
            }
            return [
              FilterEntity(
                  operator: FilterOperator.inList,
                  name: 'credential.credentialSubject.$field',
                  value: values)
            ];
          }
          break;

        default:
          break;
      }

      return [];
    }

  Future<ProofResponse> _getProofResponse(
      ProofScopeRequest proofRequest,
      String privateKey,
      CircuitDataEntity circuit,
      ClaimEntity authClaim) async {
    String field = "";
    List<int> values = [];
    int operator = 0;
    String circuitId = proofRequest.circuit_id!;
    String claimType = proofRequest.rules!.query!.schema!.type!;

    String challenge = proofRequest.id.toString();

    if (proofRequest.rules!.query!.req != null) {
      if (proofRequest.rules!.query!.req!.length > 1) {

      }

      proofRequest.rules!.query!.req!.forEach((key1, val1) {
        field = key1;

        if (val1.length > 1) {

        }

        val1.forEach((key2, val2) {
          operator = _queryOperators[key2]!;
          if (val2 is List<dynamic>) {
            values = val2.cast<int>();
          } else if (val2 is int) {
            values = [val2];
          }
        });
      });
    }

    /// FIXME: remove the usage of [CredentialData]
    CredentialData credentialData = CredentialData(
        issuer: authClaim.issuer,
        identifier: authClaim.identifier,
        credential: CredentialCredential.fromJson(authClaim.credential));

    String? res = await PrivadoIdSdk.prepareAtomicQueryInputs(
      challenge,
      privateKey,
      credentialData,
      circuitId,
      claimType,
      field,
      values,
      operator,
      credentialData.credential!.credentialStatus!.id!,
    );
    Map<String, dynamic>? inputs = json.decode(res!);

    Uint8List inputsJsonBytes =
    Uint8ArrayUtils.uint8ListfromString(json.encode(inputs));

    // 2. Calculate witness
    Uint8List? wtnsBytes = await _calculateWitness(circuit, inputsJsonBytes);

    if (wtnsBytes == null) {
      throw NullWitnessException(circuit.circuitId);
    }

    // 4. generate proof
    Map<String, dynamic>? proofResult =
    await PrivadoIdSdk.prover(circuit.zKeyFile, wtnsBytes);

    // TODO: how does this work ??? proofResult!["proof"];
    Map<String, dynamic> proof = proofResult!["proof"];
    final zkproof = ZKProof.fromJson(proof);
    final zkProofResp = ProofResponse(
        proof: zkproof,
        pubSignals: proofResult["pub_signals"],
        circuitId: proofRequest.circuit_id!,
        id: proofRequest.id!);

    return Future.value(zkProofResp);
  }

  static Future<Uint8List?> _calculateWitness(
      CircuitDataEntity circuitData,
      Uint8List inputsJsonBytes,
      ) async {
    if (circuitData.circuitId == _supportedCircuits[0]) {
      return await PrivadoIdSdk.calculateWitnessMtp(
          circuitData.datFile, inputsJsonBytes);
    }

    if (circuitData.circuitId == _supportedCircuits[1]) {
      return await PrivadoIdSdk.calculateWitnessSig(
          circuitData.datFile, inputsJsonBytes);
    }

    return null;
  }
}
