import 'dart:convert';
import 'dart:typed_data';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../common/utils/uint8_list_utils.dart';
import '../entities/circuit_data_entity.dart';
import '../entities/jwz/jwz_proof.dart';
import '../repositories/proof_repository.dart';

class ProveParam {
  final Uint8List inputs;
  final CircuitDataEntity circuitData;

  ProveParam(this.inputs, this.circuitData);
}

class ProveUseCase extends FutureUseCase<ProveParam, JWZProof> {
  final ProofRepository _proofRepository;

  ProveUseCase(this._proofRepository);

  @override
  Future<JWZProof> execute({required ProveParam param}) async {

    // Calculate witness
    Uint8List wtnsBytes = await _proofRepository.calculateWitness(
        param.circuitData, param.inputs);

    // Generate proof
    return _proofRepository.prove(param.circuitData, wtnsBytes).then((proof) {
      logger().i("[ProveUseCase] proof: $proof");

      return proof;
    }).catchError((error) {
      logger().e("[ProveUseCase] Error: $error");

      throw error;
    });
  }
}
