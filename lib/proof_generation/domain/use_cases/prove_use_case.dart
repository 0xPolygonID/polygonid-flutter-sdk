import 'dart:typed_data';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/circuit_data_entity.dart';
import '../repositories/proof_repository.dart';

class ProveParam {
  final CircuitDataEntity circuitData;
  final Uint8List witnessData;

  ProveParam(this.circuitData, this.witnessData);
}

class ProveUseCase extends FutureUseCase<ProveParam, Map<String, dynamic>?> {
  final ProofRepository _proofRepository;

  ProveUseCase(this._proofRepository);

  @override
  Future<Map<String, dynamic>?> execute({required ProveParam param}) {
    return _proofRepository
        .prove(
      param.circuitData,
      param.witnessData,
    )
        .then((proof) {
      logger().i("[ProveUseCase] proof: $proof");

      return proof;
    }).catchError((error) {
      logger().e("[ProveUseCase] Error: $error");

      throw error;
    });
  }
}
