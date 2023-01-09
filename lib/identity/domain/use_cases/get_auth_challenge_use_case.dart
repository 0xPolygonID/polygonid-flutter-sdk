import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../repositories/identity_repository.dart';

class GetAuthChallengeUseCase extends FutureUseCase<String, String> {
  final IdentityRepository _identityRepository;

  GetAuthChallengeUseCase(this._identityRepository);

  @override
  Future<String> execute({required String param}) {
    return _identityRepository.getChallenge(message: param).then((challenge) {
      logger()
          .i("[GetAuthChallengeUseCase] Message $param challenge: $challenge");

      return challenge;
    }).catchError((error) {
      logger().e("[GetAuthChallengeUseCase] Error: $error");

      throw error;
    });
  }
}
