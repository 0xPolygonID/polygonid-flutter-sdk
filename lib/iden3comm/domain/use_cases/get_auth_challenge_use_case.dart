import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';

class GetAuthChallengeUseCase extends FutureUseCase<String, String> {
  final Iden3commRepository _iden3commRepository;
  final StacktraceManager _stacktraceManager;

  GetAuthChallengeUseCase(
    this._iden3commRepository,
    this._stacktraceManager,
  );

  @override
  Future<String> execute({required String param}) {
    return _iden3commRepository.getChallenge(message: param).then((challenge) {
      logger()
          .i("[GetAuthChallengeUseCase] Message $param challenge: $challenge");
      _stacktraceManager.addTrace(
          "[GetAuthChallengeUseCase] Message $param challenge: $challenge");
      return challenge;
    }).catchError((error) {
      logger().e("[GetAuthChallengeUseCase] Error: $error");
      _stacktraceManager.addTrace("[GetAuthChallengeUseCase] Error: $error");
      _stacktraceManager.addError("[GetAuthChallengeUseCase] Error: $error");
      throw error;
    });
  }
}
