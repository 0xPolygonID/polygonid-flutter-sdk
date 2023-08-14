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
        // Claims
        claims.add(
          await _iden3commCredentialRepository
              .getFilters(request: request)
              .then((filters) {
            _stacktraceManager
                .addTrace("[GetIden3commClaimsUseCase] filters: $filters");
            return _getClaimsUseCase.execute(
              param: GetClaimsParam(
                filters: filters,
                genesisDid: param.genesisDid,
                profileNonce: param.profileNonce,
                privateKey: param.privateKey,
              ),
            );
          }).then(
            (claims) async {
              if (claims.isEmpty) {
                _stacktraceManager
                    .addTrace("[GetIden3commClaimsUseCase] claims is empty");
                return null;
              }

              bool hasValidProofType = claims.any((element) {
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
                return null;
              }

              if (request.scope.query.skipClaimRevocationCheck == null ||
                  request.scope.query.skipClaimRevocationCheck == false) {
                _stacktraceManager.addTrace(
                    "[GetIden3commClaimsUseCase] claims has valid proof type, checking revocation status");
                for (int i = 0; i < claims.length; i++) {
                  int revNonce = await _getClaimRevocationNonceUseCase.execute(
                      param: claims[i]);
                  _stacktraceManager
                      .addTrace("[GetIden3commClaimsUseCase] revNonce");
                  Map<String, dynamic>? savedNonRevProof;
                  if (param.nonRevocationProofs.isNotEmpty &&
                      param.nonRevocationProofs.containsKey(revNonce)) {
                    savedNonRevProof = param.nonRevocationProofs[revNonce];
                  }

                  Map<String, dynamic> nonRevProof =
                      await _getClaimRevocationStatusUseCase
                          .execute(
                              param: GetClaimRevocationStatusParam(
                                  claim: claims[i],
                                  nonRevProof: savedNonRevProof))
                          .catchError((_) => <String, dynamic>{});
                  _stacktraceManager
                      .addTrace("[GetIden3commClaimsUseCase] nonRevProof");

                  /// FIXME: define an entity for revocation and use it in repo impl
                  if (nonRevProof.isNotEmpty &&
                      nonRevProof["mtp"] != null &&
                      nonRevProof["mtp"]["existence"] != null &&
                      nonRevProof["mtp"]["existence"] == true) {
                    claims[i] = await _updateClaimUseCase.execute(
                        param: UpdateClaimParam(
                            id: claims[i].id,
                            state: ClaimState.revoked,
                            genesisDid: param.genesisDid,
                            privateKey: param.privateKey));
                  }
                }
                return claims
                    .where((claim) => claim.state != ClaimState.revoked)
                    .toList()
                    .first;
              } else {
                return claims.first;
              }
            },
          ),
        );
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
}
