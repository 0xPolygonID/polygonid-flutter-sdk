import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../credential/domain/entities/claim_entity.dart';
import '../../../credential/domain/repositories/credential_repository.dart';
import '../../../credential/domain/use_cases/save_claims_use_case.dart';
import '../../../iden3comm/domain/entities/request/offer/offer_iden3_message_entity.dart';
import '../../../iden3comm/domain/use_cases/get_auth_token_use_case.dart';
import 'get_fetch_requests_use_case.dart';

class FetchAndSaveClaimsParam {
  final OfferIden3MessageEntity message;
  final String did;
  final int profileNonce;
  final String privateKey;

  FetchAndSaveClaimsParam({
    required this.message,
    required this.did,
    this.profileNonce = 0,
    required this.privateKey,
  });
}

class FetchAndSaveClaimsUseCase
    extends FutureUseCase<FetchAndSaveClaimsParam, List<ClaimEntity>> {
  final Iden3commRepository _iden3commRepository;
  final GetFetchRequestsUseCase _getFetchRequestsUseCase;
  final GetAuthTokenUseCase _getAuthTokenUseCase;
  final SaveClaimsUseCase _saveClaimsUseCase;

  FetchAndSaveClaimsUseCase(
    this._iden3commRepository,
    this._getFetchRequestsUseCase,
    this._getAuthTokenUseCase,
    this._saveClaimsUseCase,
  );

  @override
  Future<List<ClaimEntity>> execute({required FetchAndSaveClaimsParam param}) {
    /// Get the corresponding fetch request from [OfferIden3MessageEntity]
    /// For each, get the auth token
    /// With the auth token, fetch the [ClaimEntity]
    /// Then save the list of [ClaimEntity]
    return _getFetchRequestsUseCase
        .execute(param: GetFetchRequestsParam(param.message, param.did))
        .then((requests) async {
          List<ClaimEntity> claims = [];

          for (String request in requests) {
            await _getAuthTokenUseCase
                .execute(
                    param: GetAuthTokenParam(
                  did: param.did,
                  profileNonce: param.profileNonce,
                  privateKey: param.privateKey,
                  message: request,
                ))
                .then((authToken) => _iden3commRepository.fetchClaim(
                    did: param.did,
                    authToken: authToken,
                    message: param.message))
                .then((claim) => claims.add(claim));
          }

          return claims;
        })
        .then((claims) => _saveClaimsUseCase
                .execute(
                    param: SaveClaimsParam(
              claims: claims,
              did: param.did,
              privateKey: param.privateKey,
            ))
                .then((_) {
              logger().i(
                  "[FetchAndSaveClaimsUseCase] All claims have been saved: $claims");

              return claims;
            }))
        .catchError((error) {
          logger().e("[FetchAndSaveClaimsUseCase] Error: $error");
          throw error;
        });
  }
}
