import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/response/jwz.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/zkproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';

class GetJWZParam {
  final String message;
  final ZKProofEntity? proof;

  GetJWZParam({required this.message, this.proof});
}

class GetJWZUseCase extends FutureUseCase<GetJWZParam, String> {
  final Iden3commRepository _iden3commRepository;
  final StacktraceManager _stacktraceManager;

  GetJWZUseCase(
    this._iden3commRepository,
    this._stacktraceManager,
  );

  @override
  Future<String> execute({required GetJWZParam param}) async {
    try {
      JWZHeader header = JWZHeader(
        circuitId: "authV2",
        crit: ["circuitId"],
        typ: "application/iden3-zkp-json",
        alg: "groth16",
      );

      JWZPayload payload = JWZPayload(payload: param.message);

      JWZEntity jwz = JWZEntity(
        header: header,
        payload: payload,
        proof: param.proof,
      );

      String encodedJwz = await _iden3commRepository.encodeJWZ(jwz: jwz);

      logger().i("[GetJWZUseCase][MainFlow] JWZ: $encodedJwz");
      _stacktraceManager.addTrace("[GetJWZUseCase][MainFlow] JWZ: $encodedJwz");
      return encodedJwz;
    } catch (error) {
      logger().e("[GetJWZUseCase] Error: $error");
      _stacktraceManager.addTrace("[GetJWZUseCase] Error: $error");
      _stacktraceManager.addError("[GetJWZUseCase] Error: $error");
      rethrow;
    }
  }
}
