import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';

class GetAuthChallengeUseCase extends FutureUseCase<String, String> {
  final Iden3commRepository _iden3commRepository;

  GetAuthChallengeUseCase(this._iden3commRepository);

  @override
  Future<String> execute({required String param}) {
    return _iden3commRepository.getChallenge(message: param).then((challenge) {
      logger()
          .i("[GetAuthChallengeUseCase] Message $param challenge: $challenge");

      return challenge;
    }).catchError((error) {
      logger().e("[GetAuthChallengeUseCase] Error: $error");

      throw error;
    });
  }
}
