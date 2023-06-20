import 'package:polygonid_flutter_sdk/credential/domain/use_cases/generate_non_rev_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_non_rev_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/claim_entity.dart';
import '../repositories/credential_repository.dart';

class GetClaimRevocationStatusParam {
  final ClaimEntity claim;
  final Map<String, dynamic>? nonRevProof;

  GetClaimRevocationStatusParam({
    required this.claim,
    this.nonRevProof,
  });
}

class GetClaimRevocationStatusUseCase
    extends FutureUseCase<GetClaimRevocationStatusParam, Map<String, dynamic>> {
  final CredentialRepository _credentialRepository;
  final GenerateNonRevProofUseCase _generateNonRevProofUseCase;
  final GetNonRevProofUseCase _getNonRevProofUseCase;

  GetClaimRevocationStatusUseCase(this._credentialRepository,
      this._generateNonRevProofUseCase, this._getNonRevProofUseCase);

  @override
  Future<Map<String, dynamic>> execute(
      {required GetClaimRevocationStatusParam param}) async {
    return _credentialRepository.isUsingRHS(claim: param.claim).then((useRHS) {
      if (useRHS) {
        try {
          return _generateNonRevProofUseCase.execute(
              param: GenerateNonRevProofParam(
                  claim: param.claim, nonRevProof: param.nonRevProof));
        } catch (e) {
          return _getNonRevProofUseCase.execute(param: param.claim);
        }
      } else {
        return _getNonRevProofUseCase.execute(param: param.claim);
      }
    }).then((status) {
      logger()
          .i("[GetClaimRevocationStatusUseCase] Revocation status: $status");
      return status;
    }).catchError((error) {
      logger().e("[GetClaimRevocationStatusUseCase] Error: $error");
      throw error;
    });
  }
}
