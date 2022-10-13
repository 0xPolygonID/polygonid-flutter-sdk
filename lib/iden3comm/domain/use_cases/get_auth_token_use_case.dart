import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../identity/domain/entities/identity_entity.dart';
import '../../../identity/domain/repositories/identity_repository.dart';
import '../../../proof_generation/domain/entities/circuit_data_entity.dart';
import '../../../proof_generation/domain/repositories/proof_repository.dart';
import '../repositories/iden3comm_repository.dart';

class GetAuthTokenParam {
  final String identifier;
  final String message;

  GetAuthTokenParam(this.identifier, this.message);
}

class GetAuthTokenUseCase extends FutureUseCase<GetAuthTokenParam, String> {
  final Iden3commRepository _iden3commRepository;
  final ProofRepository _proofRepository;
  final IdentityRepository _identityRepository;

  GetAuthTokenUseCase(this._iden3commRepository, this._proofRepository,
      this._identityRepository);

  @override
  Future<String> execute({required GetAuthTokenParam param}) async {
    CircuitDataEntity authData =
        await _proofRepository.loadCircuitFiles("auth");
    IdentityEntity identityEntity =
        await _identityRepository.getIdentity(identifier: param.identifier);
    return _iden3commRepository
        .getAuthToken(
            identityEntity: identityEntity,
            message: param.message,
            authData: authData)
        .then((token) {
      logger().i("[GetAuthTokenUseCase] Auth token: $token");

      return token;
    }).catchError((error) {
      logger().e("[GetAuthTokenUseCase] Error: $error");

      throw error;
    });
  }
}
