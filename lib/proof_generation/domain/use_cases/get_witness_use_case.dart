import 'dart:typed_data';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/circuit_data_entity.dart';
import '../repositories/proof_repository.dart';

class GetWitnessParam {
  final CircuitDataEntity circuitData;
  final Uint8List atomicQueryInputs;

  GetWitnessParam(this.circuitData, this.atomicQueryInputs);
}

class GetWitnessUseCase extends FutureUseCase<GetWitnessParam, Uint8List?> {
  final ProofRepository _proofRepository;

  GetWitnessUseCase(this._proofRepository);

  @override
  Future<Uint8List?> execute({required GetWitnessParam param}) {
    return _proofRepository
        .calculateWitness(
      param.circuitData,
      param.atomicQueryInputs,
    )
        .then((wtns) {
      logger().i("[GetWitnessUseCase] witness: $wtns");

      return wtns;
    }).catchError((error) {
      logger().e("[GetWitnessUseCase] Error: $error");

      throw error;
    });
  }
}
