import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';

import '../../../common/domain/use_case.dart';
import '../entities/jwz/jwz.dart';
import '../entities/jwz/jwz_header.dart';
import '../entities/jwz/jwz_proof.dart';

class GetJWZParam {
  final String message;
  final JWZProof? proof;
  GetJWZParam({required this.message, this.proof});
}

class GetJWZUseCase extends FutureUseCase<GetJWZParam, String> {
  final ProofRepository _proofRepository;

  GetJWZUseCase(this._proofRepository);

  @override
  Future<String> execute({required GetJWZParam param}) {
    return Future.value(JWZEntity(
            header: JWZHeader(
                circuitId: "authV2",
                crit: const ["circuitId"],
                typ: "application/iden3-zkp-json",
                alg: "groth16"),
            payload: JWZPayload(payload: param.message),
            proof: param.proof))
        .then((jwz) => _proofRepository.encodeJWZ(jwz: jwz))
        .then((encoded) {
      logger().i("[GetJWZUseCase] JWZ: $encoded");

      return encoded;
    }).catchError((error) {
      logger().e("[GetJWZUseCase] Error: $error");

      throw error;
    });
  }
}
