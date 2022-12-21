import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claim_revocation_status_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/circuit_data_entity.dart';
import '../entities/jwz/jwz_proof.dart';
import '../repositories/proof_repository.dart';
import 'prove_use_case.dart';

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
  final GetClaimRevocationStatusUseCase _getClaimRevocationStatusUseCase;
  final ProveUseCase _proveUseCase;

  GenerateProofUseCase(this._proofRepository,
      this._getClaimRevocationStatusUseCase, this._proveUseCase);

  @override
  Future<JWZProof> execute({required GenerateProofParam param}) async {
    // Get revocation status
    Map<String, dynamic> revocationStatus =
        await _getClaimRevocationStatusUseCase.execute(param: param.authClaim);

    // Prepare atomic query inputs
    Uint8List atomicQueryInputs =
        await _proofRepository.calculateAtomicQueryInputs(
            param.challenge,
            param.authClaim,
            param.circuitData.circuitId,
            param.queryParam,
            param.bjjPublicKey[0],
            param.bjjPublicKey[1],
            param.signatureString,
            revocationStatus);

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
