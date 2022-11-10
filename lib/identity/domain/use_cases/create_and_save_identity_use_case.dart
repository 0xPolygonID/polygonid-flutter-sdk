import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/identity_entity.dart';
import '../entities/private_identity_entity.dart';
import '../exceptions/identity_exceptions.dart';
import '../repositories/identity_repository.dart';

class CreateAndSaveIdentityUseCase
    extends FutureUseCase<String?, IdentityEntity> {
  final IdentityRepository _identityRepository;

  CreateAndSaveIdentityUseCase(this._identityRepository);

  @override
  Future<PrivateIdentityEntity> execute({required String? param}) async {
    // Create the [PrivateIdentityEntity] with the secret
    PrivateIdentityEntity privateIdentity =
        await _identityRepository.createIdentity(secret: param);

    // Check if identity is already stored (already created)
    try {
      IdentityEntity identity = await _identityRepository.getIdentity(
          identifier: privateIdentity.identifier);

      // If there is already one, we throw
      throw IdentityAlreadyExistsException(identity.identifier);
    } on UnknownIdentityException {
      // If it doesn't exist, we save it
      _identityRepository.storeIdentity(
          identity: privateIdentity, privateKey: privateIdentity.privateKey);
    } catch (error) {
      logger().e("[CreateAndSaveIdentityUseCase] Error: $error");

      rethrow;
    }

    logger().i(
        "[CreateAndSaveIdentityUseCase] Identity created and saved with identifier: ${privateIdentity.identifier}, for key $param");
    return privateIdentity;
  }
}
