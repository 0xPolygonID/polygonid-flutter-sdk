import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../credential/domain/repositories/credential_repository.dart';
import '../../../identity/domain/repositories/identity_repository.dart';
import '../../../proof_generation/domain/entities/circuit_data_entity.dart';
import '../../../proof_generation/domain/repositories/proof_repository.dart';
import '../repositories/iden3comm_repository.dart';

class GetAuthTokenParam {
  final String identifier;
  final String privateKey;
  final String message;

  GetAuthTokenParam(
    this.identifier,
    this.privateKey,
    this.message,
  );
}

class GetAuthTokenUseCase extends FutureUseCase<GetAuthTokenParam, String> {
  final Iden3commRepository _iden3commRepository;
  final CredentialRepository _credentialRepository;
  final ProofRepository _proofRepository;
  final IdentityRepository _identityRepository;

  GetAuthTokenUseCase(this._iden3commRepository, this._proofRepository,
      this._credentialRepository, this._identityRepository);

  @override
  Future<String> execute({required GetAuthTokenParam param}) async {
    var identityEntity = await _identityRepository.getPrivateIdentity(
        identifier: param.identifier, privateKey: param.privateKey);
    CircuitDataEntity authData =
        await _proofRepository.loadCircuitFiles("auth");
    String authClaim =
        await _credentialRepository.getAuthClaim(identity: identityEntity);
    return _iden3commRepository
        .getAuthToken(
            identity: identityEntity,
            message: param.message,
            authData: authData,
            authClaim: authClaim)
        .then((token) {
      logger().i("[GetAuthTokenUseCase] Auth token: $token");

      return token;
    }).catchError((error) {
      logger().e("[GetAuthTokenUseCase] Error: $error");

      throw error;
    });
  }
}
