import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/identity_entity.dart';
import '../entities/private_identity_entity.dart';
import '../exceptions/identity_exceptions.dart';
import '../repositories/identity_repository.dart';

class ReplaceIdentityUseCase extends FutureUseCase<String?, IdentityEntity> {
  final IdentityRepository _identityRepository;

  ReplaceIdentityUseCase(this._identityRepository);

  @override
  Future<PrivateIdentityEntity> execute({required String? param}) async {
    // Create the [PrivateIdentityEntity] with the secret
    return _identityRepository
        .createIdentity(secret: param)
        // And store it
        .then((privateIdentity) => _identityRepository
                .storeIdentity(
                    identity: privateIdentity,
                    privateKey: privateIdentity.privateKey)
                .then((_) {
              logger().i(
                  "[ReplaceIdentityUseCase] Identity created and saved with identifier: ${privateIdentity.identifier}, for key $param");

              return privateIdentity;
            }))
        .catchError((error) {
      logger().e("[ReplaceUseCase] Error: $error");

      throw error;
    });
  }
}
