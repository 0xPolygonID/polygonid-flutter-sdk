import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../credential/domain/repositories/credential_repository.dart';
import '../../../identity/domain/use_cases/get_auth_token_use_case.dart';
import '../entities/claim_entity.dart';
import '../entities/credential_request_entity.dart';

class FetchAndSaveClaimsUseCase
    extends FutureUseCase<List<CredentialRequestEntity>, List<ClaimEntity>> {
  final GetAuthTokenUseCase _getAuthTokenUseCase;
  final CredentialRepository _credentialRepository;

  FetchAndSaveClaimsUseCase(
      this._getAuthTokenUseCase, this._credentialRepository);

  @override
  Future<List<ClaimEntity>> execute(
      {required List<CredentialRequestEntity> param}) async {
    /// For each [CredentialRequestEntity]
    /// Get the corresponding message
    /// With the message, get the auth token
    /// With the auth token, fetch the [ClaimEntity]
    /// Then save the list of [ClaimEntity]
    return Future.wait(param
            .map((request) => _credentialRepository
                .getFetchMessage(credentialRequest: request)
                .then((message) => _getAuthTokenUseCase
                    .execute(
                        param: GetAuthTokenParam(
                            request.identifier, message))
                    .then((token) => _credentialRepository.fetchClaim(
                        identifier: request.identifier,
                        token: token,
                        credentialRequest: request))))
            .toList())
        .then((claims) =>
            _credentialRepository.saveClaims(claims: claims).then((_) {
              logger().i(
                  "[FetchAndSaveCredentialUseCase] All claims have been saved: $claims");

              return claims;
            }))
        .catchError((error) {
      logger().e("[FetchAndSaveCredentialUseCase] Error: $error");
      throw error;
    });
  }
}
