import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../repositories/identity_repository.dart';

class GetPublicKeysUseCase extends FutureUseCase<String, List<String>> {
  final IdentityRepository _identityRepository;

  GetPublicKeysUseCase(this._identityRepository);

  @override
  Future<List<String>> execute({required String param}) {
    return Future.value(
        _identityRepository.getPublicKeys(privateKey: param).then((publicKeys) {
      logger()
          .i("[GetPublicKeysUseCase] Message $param publicKeys: $publicKeys");

      return publicKeys;
    }).catchError((error) {
      logger().e("[GetPublicKeysUseCase] Error: $error");

      throw error;
    }));
  }
}
