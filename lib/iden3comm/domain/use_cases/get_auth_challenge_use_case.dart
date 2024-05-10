import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';

class GetAuthChallengeUseCase extends FutureUseCase<String, String> {
  final Iden3commRepository _iden3commRepository;
  final StacktraceManager _stacktraceManager;

  GetAuthChallengeUseCase(
    this._iden3commRepository,
    this._stacktraceManager,
  );

  @override
  Future<String> execute({required String param}) async {
    try {
      String authChallenge =
          await _iden3commRepository.getChallenge(message: param);
      logger().i(
          "[GetAuthChallengeUseCase] Message $param challenge: $authChallenge");
      _stacktraceManager.addTrace(
          "[GetAuthChallengeUseCase] Message $param challenge: $authChallenge");
      return authChallenge;
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      logger().e("[GetAuthChallengeUseCase] Error: $error");
      _stacktraceManager.addTrace("[GetAuthChallengeUseCase] Error: $error");
      _stacktraceManager.addError("[GetAuthChallengeUseCase] Error: $error");
      throw GetAuthChallengeException(
        errorMessage: "Error getting auth challenge with error: $error",
        error: error,
      );
    }
  }
}
