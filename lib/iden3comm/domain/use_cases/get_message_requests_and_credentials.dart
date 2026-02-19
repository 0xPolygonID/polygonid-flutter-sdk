import 'package:collection/collection.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/utils/credential_sort_order.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_query_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_credential_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_requests_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';
import 'package:polygonid_flutter_sdk/proof/domain/exceptions/proof_generation_exceptions.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart';

typedef RequestAndCredentials = ({
  ProofScopeRequest request,
  List<CredentialEntity> credentials,
});

class GetMessageRequestsAndCredsParam {
  final Iden3Message? message;
  final String genesisDid;
  final BigInt profileNonce;
  final String encryptionKey;
  final List<ProofScopeRequest>? proofRequests;
  List<CredentialSortOrder> credentialSortOrderList;

  GetMessageRequestsAndCredsParam({
    this.message,
    this.proofRequests,
    required this.genesisDid,
    required this.profileNonce,
    required this.encryptionKey,
    this.credentialSortOrderList = const [],
  });
}

class GetMessageRequestsAndCredsUseCase
    extends
        FutureUseCase<
          GetMessageRequestsAndCredsParam,
          List<RequestAndCredentials>
        > {
  final Iden3commCredentialRepository _iden3commCredentialRepository;
  final GetClaimsUseCase _getClaimsUseCase;
  final IsProofCircuitSupportedUseCase _isProofCircuitSupported;
  final GetProofRequestsUseCase _getProofRequestsUseCase;
  final StacktraceManager _stacktraceManager;

  GetMessageRequestsAndCredsUseCase(
    this._iden3commCredentialRepository,
    this._getClaimsUseCase,
    this._isProofCircuitSupported,
    this._getProofRequestsUseCase,
    this._stacktraceManager,
  );

  @override
  Future<List<RequestAndCredentials>> execute({
    required GetMessageRequestsAndCredsParam param,
  }) async {
    final requestCredentialPairs = <RequestAndCredentials>[];

    List<ProofRequestEntity> requests;
    if (param.proofRequests != null) {
      // Simplified: map each scope to a future producing its ProofRequestEntity, preserving order
      requests = await Future.wait(
        param.proofRequests!.map((scope) async {
          try {
            final context = await _iden3commCredentialRepository.fetchSchema(
              url: scope.query.context,
            );
            return ProofRequestEntity(scope, context);
          } catch (_) {
            return ProofRequestEntity(scope, {});
          }
        }),
      );
    } else if (param.message != null) {
      requests = await _getProofRequestsUseCase.execute(param: param.message!);
    } else {
      throw ArgumentError("Either proofRequests or message must be provided.");
    }

    _stacktraceManager.addTrace(
      "[GetMessageRequestsAndCredsUseCase] requests: $requests",
    );

    var groupedByGroupId = groupBy(requests, (req) => req.scope.query.groupId);

    Map<int, List<CredentialEntity>> claimsByGroupId = {};

    for (final group in groupedByGroupId.entries) {
      int? groupId = group.key;
      if (groupId == null) {
        continue;
      }
      List<ProofRequestEntity> groupRequests = group.value;
      List<FilterEntity> filtersForQueryClaimDb = [];
      for (ProofRequestEntity request in groupRequests) {
        bool supportedCircuit = await _isProofCircuitSupported.execute(
          param: request.scope.circuitId,
        );
        if (!supportedCircuit) {
          continue;
        }
        List<FilterEntity> filterForSingleRequest =
            await _iden3commCredentialRepository.getFilters(request: request);
        filtersForQueryClaimDb.addAll(filterForSingleRequest);
        filtersForQueryClaimDb = filtersForQueryClaimDb.toSet().toList();
      }

      List<CredentialEntity> claimsFiltered = await _getClaimsUseCase.execute(
        param: GetClaimsParam(
          filters: filtersForQueryClaimDb,
          genesisDid: param.genesisDid,
          profileNonce: param.profileNonce,
          encryptionKey: param.encryptionKey,
          credentialSortOrderList: param.credentialSortOrderList,
        ),
      );
      claimsByGroupId[groupId] = claimsFiltered;
    }

    /// We got [ProofRequestEntity], let's find the associated [ClaimEntity]
    for (ProofRequestEntity request in requests) {
      // we check if circuit from the request is supported
      bool supportedCircuit = await _isProofCircuitSupported.execute(
        param: request.scope.circuitId,
      );
      if (!supportedCircuit) {
        requestCredentialPairs.add((request: request.scope, credentials: []));
        continue;
      }

      List<CredentialEntity> validCreds = [];

      int? requestGroupId = request.scope.query.groupId;
      if (requestGroupId != null &&
          claimsByGroupId.containsKey(requestGroupId)) {
        validCreds = claimsByGroupId[requestGroupId] ?? [];
      } else {
        List<FilterEntity> filters = await _iden3commCredentialRepository
            .getFilters(request: request);
        _stacktraceManager.addTrace(
          "[GetMessageRequestsAndCredsUseCase] filters: $filters",
        );

        List<CredentialEntity> claimsFiltered = await _getClaimsUseCase.execute(
          param: GetClaimsParam(
            filters: filters,
            genesisDid: param.genesisDid,
            profileNonce: param.profileNonce,
            encryptionKey: param.encryptionKey,
          ),
        );
        validCreds = claimsFiltered;
      }

      // filter manually positive integer
      validCreds = _filterManuallyIfPositiveInteger(
        request: request,
        claimsFiltered: validCreds,
      );

      //filter manually proof type
      validCreds = _filterManuallyIfQueryContainsProofType(
        proofType: request.scope.query.proofType,
        credsFiltered: validCreds,
      );

      if (!request.isOptional && validCreds.isEmpty) {
        _stacktraceManager.addTrace(
          "[GetMessageRequestsAndCredsUseCase] claims is empty",
        );
        requestCredentialPairs.add((request: request.scope, credentials: []));
        continue;
      }

      /// check that credential has proof type supported by request
      validCreds = validCreds.where((cred) {
        List<Map<String, dynamic>> proofs = cred.info["proof"];
        List<String> proofTypes = proofs
            .map((e) => e["type"] as String)
            .toList();

        final rawCircuitId = request.scope.circuitId;
        // TODO (moria): remove this with v3 circuit release
        if (rawCircuitId.startsWith(CircuitId.v3CircuitPrefix) &&
            !rawCircuitId.endsWith(CircuitId.currentCircuitBetaPostfix)) {
          _stacktraceManager.addTrace(
            "V3 circuit beta version mismatch $rawCircuitId is not supported, current is ${CircuitId.currentCircuitBetaPostfix}",
          );
          throw CircuitNotDownloadedException(
            circuit: rawCircuitId,
            errorMessage:
                "V3 circuit beta version mismatch $rawCircuitId is not supported, current is ${CircuitId.currentCircuitBetaPostfix}",
          );
        }

        CircuitId circuitId = CircuitId.fromId(rawCircuitId);

        return circuitId.isAnyProofTypeSupported(proofTypes);
      }).toList();

      if (!request.isOptional && validCreds.isEmpty) {
        _stacktraceManager.addTrace(
          "[GetMessageRequestsAndCredsUseCase] claims has no valid proof type",
        );
        requestCredentialPairs.add((request: request.scope, credentials: []));
        continue;
      }

      requestCredentialPairs.add((
        request: request.scope,
        credentials: validCreds,
      ));
    }

    return requestCredentialPairs;
  }

  /// The positiveInteger type is not supported by the filter 'cause this type
  /// is stored as a string in the database. So we need to filter manually
  List<CredentialEntity> _filterManuallyIfPositiveInteger({
    required ProofRequestEntity request,
    required List<CredentialEntity> claimsFiltered,
  }) {
    try {
      if (request.scope.query.credentialSubject == null) return claimsFiltered;

      ZeroKnowledgeProofQuery query = request.scope.query;
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

  String _getTypeFromNestedObject(
    Map<String, dynamic> contextMap,
    String nestedKey,
  ) {
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

  void _processMap(
    dynamic map,
    String key,
    List<CredentialEntity> claimsFiltered,
  ) {
    map.forEach((operator, needle) {
      _filterClaims(operator, needle, key, claimsFiltered);
    });
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

  void _filterClaims(
    String operator,
    dynamic needle,
    String key,
    List<CredentialEntity> claimsFiltered,
  ) {
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
            List<String> stringList = values.map((e) => e.toString()).toList();
            return !stringList.contains(value);
          case '\$nin':
            List<dynamic> values = List.from(needle);
            List<String> stringList = values.map((e) => e.toString()).toList();
            return stringList.contains(value);
        }
      }
      return false;
    });
  }

  List<CredentialEntity> _filterManuallyIfQueryContainsProofType({
    required String? proofType,
    required List<CredentialEntity> credsFiltered,
  }) {
    try {
      if (proofType == null || proofType.isEmpty) {
        return credsFiltered;
      }

      credsFiltered.removeWhere((cred) {
        List<Map<String, dynamic>> proofs = cred.info["proof"];
        List<String> proofTypes = proofs
            .map((e) => e["type"] as String)
            .toList();
        return !proofTypes.contains(proofType);
      });
    } catch (ignored) {
      // Consider logging the exception
    }
    return credsFiltered;
  }
}
