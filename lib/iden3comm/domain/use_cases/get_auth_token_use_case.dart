import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_inputs_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_challenge_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_jwz_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/load_circuit_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/prove_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../proof/domain/entities/circuit_data_entity.dart';

class GetAuthTokenParam {
  final String genesisDid;
  final BigInt profileNonce;
  final String privateKey;
  final String message;

  GetAuthTokenParam({
    required this.genesisDid,
    required this.profileNonce,
    required this.privateKey,
    required this.message,
  });
}

class GetAuthTokenUseCase extends FutureUseCase<GetAuthTokenParam, String> {
  final LoadCircuitUseCase _loadCircuitUseCase;
  final GetJWZUseCase _getJWZUseCase;
  final GetAuthChallengeUseCase _getAuthChallengeUseCase;
  final GetAuthInputsUseCase _getAuthInputsUseCase;
  final ProveUseCase _proveUseCase;
  final StacktraceStreamManager _stacktraceStreamManager;

  GetAuthTokenUseCase(
    this._loadCircuitUseCase,
    this._getJWZUseCase,
    this._getAuthChallengeUseCase,
    this._getAuthInputsUseCase,
    this._proveUseCase,
    this._stacktraceStreamManager,
  );

  @override
  Future<String> execute({required GetAuthTokenParam param}) {
    return _getJWZUseCase
        .execute(param: GetJWZParam(message: param.message))
        .then((encoded) => _getAuthChallengeUseCase.execute(param: encoded))
        .then((challenge) => Future.wait([
              _getAuthInputsUseCase.execute(
                  param: GetAuthInputsParam(challenge, param.genesisDid,
                      param.profileNonce, param.privateKey)),
              _loadCircuitUseCase.execute(param: "authV2")
            ]))
        .then((values) => _proveUseCase.execute(
            param: ProveParam(
                values[0] as Uint8List, values[1] as CircuitDataEntity)))
        .then((proof) => _getJWZUseCase.execute(
            param: GetJWZParam(message: param.message, proof: proof)))
        .then((token) {
      logger().i("[GetAuthTokenUseCase] Message $param Auth token: $token");
      _stacktraceStreamManager
          .addTrace("[GetAuthTokenUseCase] Message $param Auth token: $token");
      return token;
    }).catchError((error) {
      logger().e("[GetAuthTokenUseCase] Error: $error");
      _stacktraceStreamManager.addTrace("[GetAuthTokenUseCase] Error: $error");
      _stacktraceStreamManager.addError("[GetAuthTokenUseCase] Error: $error");
      throw error;
    });
  }
}
