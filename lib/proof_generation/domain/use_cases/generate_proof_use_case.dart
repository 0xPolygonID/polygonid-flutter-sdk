import 'dart:typed_data';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../credential/data/dtos/credential_dto.dart';
import '../entities/circuit_data_entity.dart';
import '../exceptions/proof_generation_exceptions.dart';
import '../repositories/proof_repository.dart';

class GenerateProofParam {
  final String challenge;
  final String signatureString;
  final CredentialDTO credential;
  final CircuitDataEntity circuitData;
  final List<String> bjjPublicKey;
  final Map<String, dynamic> queryParams;

  GenerateProofParam(this.challenge, this.signatureString, this.credential,
      this.circuitData, this.bjjPublicKey, this.queryParams);
}

class GenerateProofUseCase
    extends FutureUseCase<GenerateProofParam, Map<String, dynamic>?> {
  final ProofRepository _proofRepository;

  GenerateProofUseCase(this._proofRepository);

  @override
  Future<Map<String, dynamic>?> execute(
      {required GenerateProofParam param}) async {
    // 1. Prepare atomic query inputs
    Uint8List? atomicQueryInputs =
        await _proofRepository.calculateAtomicQueryInputs(
            param.challenge,
            param.credential,
            param.circuitData.circuitId,
            param.queryParams['field'],
            param.queryParams['values'],
            param.queryParams['operator'],
            param.bjjPublicKey[0],
            param.bjjPublicKey[1],
            param.signatureString);

    if (atomicQueryInputs == null) {
      throw NullAtomicQueryInputsException(param.circuitData.circuitId);
    }

    // 2. Calculate witness
    Uint8List? wtnsBytes = await _proofRepository.calculateWitness(
        param.circuitData, atomicQueryInputs);

    if (wtnsBytes == null) {
      throw NullWitnessException(param.circuitData.circuitId);
    }

    // 3. generate proof
    return _proofRepository.prove(param.circuitData, wtnsBytes).then((proof) {
      logger().i("[GenerateProofUseCase] proof: $proof");

      return proof;
    }).catchError((error) {
      logger().e("[GenerateProofUseCase] Error: $error");

      throw error;
    });
  }
}
