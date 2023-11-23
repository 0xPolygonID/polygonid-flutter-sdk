import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claim_revocation_nonce_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claim_revocation_status_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/update_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_query_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_credential_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_requests_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/data/mappers/circuit_type_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart';

class GetIden3commClaimsParam {
  final Iden3MessageEntity message;
  final String genesisDid;
  final BigInt profileNonce;
  final String privateKey;
  final Map<int, Map<String, dynamic>> nonRevocationProofs;

  GetIden3commClaimsParam(
      {required this.message,
      required this.genesisDid,
      required this.profileNonce,
      required this.privateKey,
      required this.nonRevocationProofs});
}

class GetIden3commClaimsUseCase
    extends FutureUseCase<GetIden3commClaimsParam, List<ClaimEntity?>> {
  final Iden3commCredentialRepository _iden3commCredentialRepository;
  final GetClaimsUseCase _getClaimsUseCase;
  final GetClaimRevocationStatusUseCase _getClaimRevocationStatusUseCase;
  final GetClaimRevocationNonceUseCase _getClaimRevocationNonceUseCase;
  final UpdateClaimUseCase _updateClaimUseCase;
  final IsProofCircuitSupportedUseCase _isProofCircuitSupported;
  final GetProofRequestsUseCase _getProofRequestsUseCase;
  final CircuitTypeMapper _circuitTypeMapper;
  final StacktraceManager _stacktraceManager;

  GetIden3commClaimsUseCase(
    this._iden3commCredentialRepository,
    this._getClaimsUseCase,
    this._getClaimRevocationStatusUseCase,
    this._getClaimRevocationNonceUseCase,
    this._updateClaimUseCase,
    this._isProofCircuitSupported,
    this._getProofRequestsUseCase,
    this._circuitTypeMapper,
    this._stacktraceManager,
  );

  @override
  Future<List<ClaimEntity?>> execute(
      {required GetIden3commClaimsParam param}) async {
    List<ClaimEntity?> claims = [];

    List<ProofRequestEntity> requests =
        await _getProofRequestsUseCase.execute(param: param.message);
    _stacktraceManager
        .addTrace("[GetIden3commClaimsUseCase] requests: $requests");

    /// We got [ProofRequestEntity], let's find the associated [ClaimEntity]
    for (ProofRequestEntity request in requests) {
      if (await _isProofCircuitSupported.execute(
          param: request.scope.circuitId)) {

        List<FilterEntity> filters =
            await _iden3commCredentialRepository.getFilters(request: request);
        _stacktraceManager
            .addTrace("[GetIden3commClaimsUseCase] filters: $filters");

        List<ClaimEntity> claimsFiltered = await _getClaimsUseCase.execute(
          param: GetClaimsParam(
            filters: filters,
            genesisDid: param.genesisDid,
            profileNonce: param.profileNonce,
            privateKey: param.privateKey,
            ),
          );

        // filter manually positive integer
        claimsFiltered = _filterManuallyIfPositiveInteger(
          request: request,
          claimsFiltered: claimsFiltered,
        );

        if (claimsFiltered.isEmpty) {
          _stacktraceManager
              .addTrace("[GetIden3commClaimsUseCase] claims is empty");
          continue;
        }

        bool hasValidProofType = claimsFiltered.any((element) {
          List<Map<String, dynamic>> proofs = element.info["proof"];
          List<String> proofTypes =
              proofs.map((e) => e["type"] as String).toList();

          CircuitType circuitType =
              _circuitTypeMapper.mapTo(request.scope.circuitId);

          switch (circuitType) {
            case CircuitType.mtp:
            case CircuitType.mtponchain:
              bool success = [
                'Iden3SparseMerkleProof',
                'Iden3SparseMerkleTreeProof'
              ].any((element) => proofTypes.contains(element));
              return success;
            case CircuitType.sig:
            case CircuitType.sigonchain:
              bool success = proofTypes.contains('BJJSignature2021');
              return success;
            case CircuitType.auth:
            case CircuitType.unknown:
              break;
          }
          return false;
        });

        if (!hasValidProofType) {
          _stacktraceManager.addTrace(
              "[GetIden3commClaimsUseCase] claims has no valid proof type");
          continue;
        }

        claims.add(claimsFiltered.first);
      }
    }

    /// If we have requests but didn't get any proofs, we throw
    /// as it could be we didn't find any associated [ClaimEntity]
    if (requests.isNotEmpty && claims.isEmpty ||
        claims.length != requests.length) {
      _stacktraceManager.addTrace(
          "[GetIden3commClaimsUseCase] error getting claims for requests: $requests");
      _stacktraceManager.addError(
          "[GetIden3commClaimsUseCase] error getting claims for requests: $requests");
      throw CredentialsNotFoundException(requests);
    }

    return claims;
  }

  String _getTypeFromNestedObject(
      Map<String, dynamic> contextMap, String nestedKey) {
    List<String> keys = nestedKey.split('.');
    dynamic value = contextMap;
    for (String key in keys) {
      if (value is Map<String, dynamic> && value[key].containsKey("@context")) {
        value = value[key]["@context"];
      } else if (value is Map<String, dynamic> &&
          value[key].containsKey("@type")) {
        value = value[key]["@type"];
        break;
      } else {
        break;
      }
    }
    return value;
  }

  ///
  dynamic _getNestedValue(Map<String, dynamic> map, String key) {
    List<String> keys = key.split('.');
    dynamic value = map;
    for (String key in keys) {
      if (value is Map<String, dynamic> && value.containsKey(key)) {
        value = value[key];
      } else {
        break;
      }
    }
    return value;
  }

  /// The positiveInteger type is not supported by the filter 'cause this type
  /// is stored as a string in the database. So we need to filter manually
  List<ClaimEntity> _filterManuallyIfPositiveInteger({
    required ProofRequestEntity request,
    required List<ClaimEntity> claimsFiltered,
  }) {
    try {
      if (request.scope.query.credentialSubject == null) return claimsFiltered;

      ProofScopeQueryRequest query = request.scope.query;
      Map<String, dynamic>? context =
      request.context["@context"][0][query.type]["@context"];
      if (context == null) return claimsFiltered;

      Map<String, dynamic> requestMap = request.scope.query.credentialSubject!;
      requestMap.forEach((key, map) {
        if (map == null || map is! Map || map.isEmpty) return;

        String type = _getTypeFromNestedObject(context, key);
        if (!type.contains("positiveInteger")) return;

        _processMap(map, key, claimsFiltered);
      });
    } catch (ignored) {
      // Consider logging the exception
    }
    return claimsFiltered;
  }

  void _processMap(dynamic map, String key, List<ClaimEntity> claimsFiltered) {
    map.forEach((operator, needle) {
      _filterClaims(operator, needle, key, claimsFiltered);
    });
  }

  void _filterClaims(String operator, dynamic needle, String key, List<ClaimEntity> claimsFiltered) {
    // Implement the filtering logic here, similar to what you have in your switch case
    claimsFiltered.removeWhere((element) {
      Map<String, dynamic> credentialSubject =
      element.info["credentialSubject"];
      dynamic value = _getNestedValue(credentialSubject, key);
      if (value != null) {
        BigInt valueBigInt = BigInt.parse(value);
        switch (operator) {
          case '\$gt':
            return valueBigInt <= BigInt.from(needle);
          case '\$gte':
            return valueBigInt < BigInt.from(needle);
          case '\$lt':
            return valueBigInt >= BigInt.from(needle);
          case '\$lte':
            return valueBigInt > BigInt.from(needle);
          case '\$eq':
            return valueBigInt != BigInt.from(needle);
          case '\$neq':
            return valueBigInt == BigInt.from(needle);
          case '\$in':
            List<dynamic> values = List.from(needle);
            List<String> stringList =
            values.map((e) => e.toString()).toList();
            return !stringList.contains(value);
          case '\$nin':
            List<dynamic> values = List.from(needle);
            List<String> stringList =
            values.map((e) => e.toString()).toList();
            return stringList.contains(value);
        }
      }
      return false;
    });
  }
}
