import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../exceptions/identity_exceptions.dart';
import '../repositories/identity_repository.dart';

class CreateIdentityUseCase extends FutureUseCase<String?, String> {
  final IdentityRepository _identityRepository;

  CreateIdentityUseCase(this._identityRepository);

  @override
  Future<String> execute({String? param}) async {
    // Get the identifier associated with the privateKey
    String identifier =
        await _identityRepository.getIdentifier(privateKey: param);

    try {
      // Get the known [Identity] associated with the identifier
      await _identityRepository.getIdentity(identifier: identifier);
    } on UnknownIdentityException {
      // If it doesn't exist save the identity
      await _identityRepository.createIdentity(privateKey: param);
    } catch (error) {
      logger().e("[CreateIdentityUseCase] Error: $error");

      rethrow;
    }

    // Finally return the identifier
    logger().i(
        "[CreateIdentityUseCase] Identity created with identifier: $identifier, for key $param");

    return identifier;
  }
}
