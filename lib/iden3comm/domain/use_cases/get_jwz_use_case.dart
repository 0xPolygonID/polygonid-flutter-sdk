import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/response/jwz.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/zkproof_entity.dart';

class GetJWZParam {
  final String message;
  final ZKProofEntity? proof;
  final CircuitType circuitType;

  GetJWZParam({required this.message, this.proof, required this.circuitType});
}

class GetJWZUseCase extends FutureUseCase<GetJWZParam, String> {
  final Iden3commRepository _iden3commRepository;
  final StacktraceManager _stacktraceManager;

  GetJWZUseCase(this._iden3commRepository, this._stacktraceManager);

  @override
  Future<String> execute({required GetJWZParam param}) async {
    try {
      JWZHeader header = JWZHeader(
        circuitId: param.circuitType.id,
        crit: ["circuitId"],
        typ: "application/iden3-zkp-json",
        alg: "groth16",
      );

      JWZEntity jwz = JWZEntity(
        header: header,
        payload: JWZPayload(payload: param.message),
        proof: param.proof,
      );

      String encodedJwz = await _iden3commRepository.encodeJWZ(jwz: jwz);

      logger().i("[GetJWZUseCase][MainFlow] JWZ: $encodedJwz");
      _stacktraceManager.addTrace("[GetJWZUseCase][MainFlow] JWZ: $encodedJwz");
      return encodedJwz;
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      _stacktraceManager.logError("[GetJWZUseCase] Error: $error");
      throw PolygonIdSDKException(
        errorMessage: "Error getting JWZ, error: $error",
        error: error,
      );
    }
  }
}
