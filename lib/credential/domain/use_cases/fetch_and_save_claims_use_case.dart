import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../credential/domain/repositories/credential_repository.dart';
import '../../../iden3comm/domain/use_cases/get_auth_token_use_case.dart';
import '../entities/claim_entity.dart';
import '../entities/credential_request_entity.dart';
import '../exceptions/credential_exceptions.dart';

class FetchAndSaveClaimsParam {
  final List<CredentialRequestEntity> requests;
  final String identifier;
  final String privateKey;

  FetchAndSaveClaimsParam({
    required this.requests,
    required this.identifier,
    required this.privateKey,
  });
}

class FetchAndSaveClaimsUseCase
    extends FutureUseCase<FetchAndSaveClaimsParam, List<ClaimEntity>> {
  final GetAuthTokenUseCase _getAuthTokenUseCase;
  final CredentialRepository _credentialRepository;

  FetchAndSaveClaimsUseCase(
      this._getAuthTokenUseCase, this._credentialRepository);

  @override
  Future<List<ClaimEntity>> execute(
      {required FetchAndSaveClaimsParam param}) async {
    /// For each [CredentialRequestEntity]
    /// Get the corresponding message
    /// With the message, get the auth token
    /// With the auth token, fetch the [ClaimEntity]
    /// Then save the list of [ClaimEntity]
    return Future.wait(param.requests.map((request) {
      if (request.identifier == param.identifier) {
        return _credentialRepository
            .getFetchMessage(credentialRequest: request)
            .then((message) => _getAuthTokenUseCase
                .execute(
                    param: GetAuthTokenParam(
                  param.identifier,
                  param.privateKey,
                  message,
                ))
                .then((token) => _credentialRepository.fetchClaim(
                    identifier: request.identifier,
                    token: token,
                    credentialRequest: request)));
      } else {
        throw ClaimWrongIdentityException(request.identifier);
      }
    }).toList())
        .then((claims) => _credentialRepository
                .saveClaims(
              claims: claims,
              identifier: param.identifier,
              privateKey: param.privateKey,
            )
                .then((_) {
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
