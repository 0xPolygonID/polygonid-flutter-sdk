import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/identity/libs/jwz/jwz_proof.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/circuit_data_entity.dart';
import '../exceptions/proof_generation_exceptions.dart';
import '../repositories/proof_repository.dart';

class GenerateProofParam {
  final String challenge;
  final String signatureString;
  final ClaimEntity authClaim;
  final CircuitDataEntity circuitData;
  final List<String> bjjPublicKey;
  final ProofQueryParamEntity queryParam;

  GenerateProofParam(this.challenge, this.signatureString, this.authClaim,
      this.circuitData, this.bjjPublicKey, this.queryParam);
}

class GenerateProofUseCase extends FutureUseCase<GenerateProofParam, JWZProof> {
  final ProofRepository _proofRepository;

  GenerateProofUseCase(this._proofRepository);

  @override
  Future<JWZProof> execute({required GenerateProofParam param}) async {
    // 1. Prepare atomic query inputs
    Uint8List? atomicQueryInputs =
        await _proofRepository.calculateAtomicQueryInputs(
            param.challenge,
            param.authClaim,
            param.circuitData.circuitId,
            param.queryParam,
            param.bjjPublicKey[0],
            param.bjjPublicKey[1],
            param.signatureString);

    if (atomicQueryInputs == null) {
      throw NullAtomicQueryInputsException(param.circuitData.circuitId);
    }

    // 2. Calculate witness
    Uint8List wtnsBytes = await _proofRepository.calculateWitness(
        param.circuitData, atomicQueryInputs);

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
