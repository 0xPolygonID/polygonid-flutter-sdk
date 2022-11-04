import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/identity_entity.dart';
import '../entities/private_identity_entity.dart';
import '../exceptions/identity_exceptions.dart';
import '../repositories/identity_repository.dart';

class CreateIdentityParam {
  final String? secret;
  final bool replaceStored;

  CreateIdentityParam({
    this.secret,
    this.replaceStored = false,
  });
}

class CreateIdentityUseCase
    extends FutureUseCase<CreateIdentityParam, IdentityEntity> {
  final IdentityRepository _identityRepository;

  CreateIdentityUseCase(this._identityRepository);

  @override
  Future<PrivateIdentityEntity> execute(
      {required CreateIdentityParam param}) async {
    PrivateIdentityEntity privateIdentity;
    try {
      // Check if identity already exists
      privateIdentity = await _identityRepository.createIdentity(
          secret: param.secret, isStored: false);
      // Get the known [Identity] associated with the identifier
      IdentityEntity identity = await _identityRepository.getIdentity(
          identifier: privateIdentity.identifier,
          privateKey: privateIdentity.privateKey);

      // Get the list of identities stored in the sdk
      //List<IdentityEntity> storedIdentities =
      //await _identityRepository.getIdentities();

      if (identity is PrivateIdentityEntity) {
        if (param.replaceStored) {
          await _identityRepository.storeIdentity(
              identity: privateIdentity,
              privateKey: privateIdentity.privateKey);
        } else {
          throw IdentityAlreadyExistsException(identity.identifier);
        }
      }
    } on UnknownIdentityException {
      // If it doesn't exist save the identity
      privateIdentity =
          await _identityRepository.createIdentity(secret: param.secret);
    } catch (error) {
      logger().e("[CreateIdentityUseCase] Error: $error");

      rethrow;
    }

    // Finally return the identity
    logger().i(
        "[CreateIdentityUseCase] Identity created with identifier: ${privateIdentity.identifier}, for key ${param.secret}");

    return privateIdentity;
  }
}
