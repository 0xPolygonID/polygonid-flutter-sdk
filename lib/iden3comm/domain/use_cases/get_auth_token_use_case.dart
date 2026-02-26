import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/generate_auth_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_challenge_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_jwz_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';

const _tag = "getJWZUseCase";

class GetAuthTokenParam {
  final String genesisDid;
  final BigInt profileNonce;
  final String privateKey;
  final String message;
  final CircuitId circuitId;

  GetAuthTokenParam({
    required this.genesisDid,
    required this.profileNonce,
    required this.privateKey,
    required this.message,
    this.circuitId = CircuitId.authV2,
  });
}

class GetAuthTokenUseCase extends FutureUseCase<GetAuthTokenParam, String> {
  final GetJWZUseCase _getJWZUseCase;
  final GetAuthChallengeUseCase _getAuthChallengeUseCase;
  final GenerateAuthProofUseCase _generateAuthProofUseCase;
  final StacktraceManager _stacktraceManager;

  GetAuthTokenUseCase(
    this._getJWZUseCase,
    this._getAuthChallengeUseCase,
    this._generateAuthProofUseCase,
    this._stacktraceManager,
  );

  @override
  Future<String> execute({required GetAuthTokenParam param}) async {
    Stopwatch stopwatch = Stopwatch()..start();
    logger().i('GetAuthTokenUseCase: started');
    try {
      final jwz = await _getJWZUseCase.execute(
        param: GetJWZParam(message: param.message, circuitId: param.circuitId),
      );

      logger().logTimestamp(stopwatch, "getJWZUseCase", tag: _tag);

      final authChallenge = await _getAuthChallengeUseCase.execute(param: jwz);

      logger().logTimestamp(stopwatch, "getAuthChallengeUseCase", tag: _tag);

      final proof = await _generateAuthProofUseCase.execute(
        param: GenerateAuthProofParam(
          genesisDid: param.genesisDid,
          privateKey: param.privateKey,
          profileNonce: param.profileNonce,
          requestId: 0,
          circuitId: param.circuitId.id,
          challenge: authChallenge,
        ),
      );

      logger().logTimestamp(stopwatch, "generateAuthProofUseCase", tag: _tag);

      String authToken = await _getJWZUseCase.execute(
        param: GetJWZParam(
          message: param.message,
          proof: proof,
          circuitId: param.circuitId,
        ),
      );

      logger().logTimestamp(stopwatch, "getJWZUseCase", tag: _tag);

      return authToken;
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      _stacktraceManager.logError("[GetAuthTokenUseCase] Error: $error");
      throw GetAuthTokenException(
        errorMessage: "Error while getting auth token",
        error: error,
      );
    }
  }
}
