import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/did_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../credential/domain/entities/claim_entity.dart';
import '../../../credential/domain/use_cases/get_claim_revocation_status_use_case.dart';
import '../../../credential/domain/use_cases/update_claim_use_case.dart';
import '../../../identity/domain/repositories/identity_repository.dart';
import '../../../proof/domain/entities/circuit_data_entity.dart';
import '../../../proof/domain/repositories/proof_repository.dart';
import '../../../proof/domain/use_cases/generate_proof_use_case.dart';
import 'get_proof_requests_use_case.dart';

class GetIden3commClaimsParam {
  final Iden3MessageEntity message;
  final String did;
  final int profileNonce;
  final String privateKey;

  GetIden3commClaimsParam(
      {required this.message,
      required this.did,
      required this.profileNonce,
      required this.privateKey});
}

class GetIden3commClaimsUseCase
    extends FutureUseCase<GetIden3commClaimsParam, List<ClaimEntity>> {
  final Iden3commRepository _iden3commRepository;
  final GetClaimsUseCase _getClaimsUseCase;
  final GetClaimRevocationStatusUseCase _getClaimRevocationStatusUseCase;
  final UpdateClaimUseCase _updateClaimUseCase;
  final IsProofCircuitSupportedUseCase _isProofCircuitSupported;
  final GetProofRequestsUseCase _getProofRequestsUseCase;

  GetIden3commClaimsUseCase(
    this._iden3commRepository,
    this._getClaimsUseCase,
    this._getClaimRevocationStatusUseCase,
    this._updateClaimUseCase,
    this._isProofCircuitSupported,
    this._getProofRequestsUseCase,
  );

  @override
  Future<List<ClaimEntity>> execute(
      {required GetIden3commClaimsParam param}) async {
    List<ClaimEntity> claims = [];

    List<ProofRequestEntity> requests =
        await _getProofRequestsUseCase.execute(param: param.message);

    /// We got [ProofRequestEntity], let's find the associated [ClaimEntity]
    for (ProofRequestEntity request in requests) {
      if (await _isProofCircuitSupported.execute(
          param: request.scope.circuitId)) {
        // Claims
        claims = await _iden3commRepository
            .getFilters(request: request)
            .then((filters) => _getClaimsUseCase.execute(
                    param: GetClaimsParam(
                  filters: filters,
                  did: param.did,
                  privateKey: param.privateKey,
                )))
            .then((claims) async {
          if (request.scope.query.skipClaimRevocationCheck == null ||
              request.scope.query.skipClaimRevocationCheck == false) {
            for (int i = 0; i < claims.length; i++) {
              Map<String, dynamic> revStatus =
                  await _getClaimRevocationStatusUseCase
                      .execute(param: claims[i])
                      .catchError((_) => <String, dynamic>{});
              if (revStatus.isNotEmpty &&
                  revStatus["mtp"] != null &&
                  revStatus["mtp"]["existence"] != null &&
                  revStatus["mtp"]["existence"] == true) {
                claims[i] = await _updateClaimUseCase.execute(
                    param: UpdateClaimParam(
                        id: claims[i].id,
                        state: ClaimState.revoked,
                        did: param.did,
                        privateKey: param.privateKey));
              }
            }
            return claims
                .where((claim) => claim.state != ClaimState.revoked)
                .toList();
          } else {
            return claims;
          }
        });
      }
    }

    return claims;
  }
}
