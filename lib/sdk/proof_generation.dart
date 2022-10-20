import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/use_cases/get_atomic_query_inputs_use_case.dart';

import '../credential/data/dtos/credential_dto.dart';
import '../proof_generation/domain/entities/circuit_data_entity.dart';
import '../proof_generation/domain/use_cases/get_witness_use_case.dart';
import '../proof_generation/domain/use_cases/prove_use_case.dart';

@injectable
class ProofGeneration {
  final GetAtomicQueryInputsUseCase _getAtomicQueryInputsUseCase;
  final GetWitnessUseCase _getWitnessUseCase;
  final ProveUseCase _proveUseCase;
  //final GenerateProofUseCase _generateProofUseCase;

  ProofGeneration(
    this._getAtomicQueryInputsUseCase,
    this._getWitnessUseCase,
    this._proveUseCase,
    //this._generateProofUseCase,
  );

  Future<Uint8List?> getAtomicQueryInputs(
      {required String challenge,
      required CredentialDTO credential,
      required String circuitId,
      required String key,
      required List<int> values,
      required int operator,
      required String pubX,
      required String pubY,
      String? signature}) {
    return _getAtomicQueryInputsUseCase.execute(
        param: GetAtomicQueryInputsParam(challenge, credential, circuitId, key,
            values, operator, pubX, pubY, signature));
  }

  Future<Uint8List?> calculateWitness(
    CircuitDataEntity circuitData,
    Uint8List inputsJsonBytes,
  ) {
    return _getWitnessUseCase.execute(
        param: GetWitnessParam(circuitData, inputsJsonBytes));
  }

  Future<Map<String, dynamic>?> prove(
    CircuitDataEntity circuitData,
    Uint8List wtnsBytes,
  ) {
    return _proveUseCase.execute(param: ProveParam(circuitData, wtnsBytes));
  }

  /*Future<void> generateProof(
      String challenge,
      String signature,
      ClaimEntity claim,
      CircuitDataEntity circuitDataEntity,
      List<String> bjjPublicKey,
      Map<String, dynamic> queryParams) {
    return _generateProofUseCase.execute(
        param: GenerateProofParam(challenge, signature, claim,
            circuitDataEntity, bjjPublicKey, queryParams));
  }*/
}
