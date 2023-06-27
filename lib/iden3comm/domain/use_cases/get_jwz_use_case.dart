import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
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

  GetJWZUseCase(this._iden3commRepository);

  @override
  Future<String> execute({required GetJWZParam param}) {
    return Future.value(JWZEntity(
            header: JWZHeader(
                circuitId: "authV2",
                crit: ["circuitId"],
                typ: "application/iden3-zkp-json",
                alg: "groth16"),
            payload: JWZPayload(payload: param.message),
            proof: param.proof))
        .then((jwz) => _iden3commRepository.encodeJWZ(jwz: jwz))
        .then((encoded) {
      logger().i("[GetJWZUseCase] JWZ: $encoded");

      return encoded;
    }).catchError((error) {
      logger().e("[GetJWZUseCase] Error: $error");

      throw error;
    });
  }
}
