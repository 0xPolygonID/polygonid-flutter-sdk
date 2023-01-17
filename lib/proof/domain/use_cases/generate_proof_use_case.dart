import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/proof_scope_request.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/circuit_data_entity.dart';
import '../entities/jwz/jwz_proof.dart';
import '../repositories/proof_repository.dart';
import 'prove_use_case.dart';

class GenerateProofParam {
  final String id;
  final int profileNonce;
  final int claimSubjectProfileNonce;
  final ClaimEntity credential;
  final ProofScopeRequest request; //FIXME: this is not from proof
  final CircuitDataEntity circuitData;

  GenerateProofParam(this.id, this.profileNonce, this.claimSubjectProfileNonce,
      this.credential, this.request, this.circuitData);
}

class GenerateProofUseCase extends FutureUseCase<GenerateProofParam, JWZProof> {
  final ProofRepository _proofRepository;
  final ProveUseCase _proveUseCase;

  GenerateProofUseCase(this._proofRepository, this._proveUseCase);

  @override
  Future<JWZProof> execute({required GenerateProofParam param}) async {
    // Prepare atomic query inputs
    Uint8List atomicQueryInputs =
        await _proofRepository.calculateAtomicQueryInputs(
            param.id,
            param.profileNonce,
            param.claimSubjectProfileNonce,
            param.credential,
            param.request);

    // Prove
    return _proveUseCase
        .execute(param: ProveParam(atomicQueryInputs, param.circuitData))
        .then((proof) {
      logger().i("[GenerateProofUseCase] proof: $proof");

      return proof;
    }).catchError((error) {
      logger().e("[GenerateProofUseCase] Error: $error");

      throw error;
    });
  }
}
