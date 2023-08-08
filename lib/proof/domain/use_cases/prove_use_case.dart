import 'dart:convert';
import 'dart:typed_data';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/zkproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';

class ProveParam {
  final Uint8List inputs;
  final CircuitDataEntity circuitData;

  ProveParam(this.inputs, this.circuitData);
}

class ProveUseCase extends FutureUseCase<ProveParam, ZKProofEntity> {
  final ProofRepository _proofRepository;

  ProveUseCase(this._proofRepository);

  @override
  Future<ZKProofEntity> execute({required ProveParam param}) async {
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
