import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/generate_non_rev_proof_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/claim_entity.dart';
import '../repositories/credential_repository.dart';

class GetClaimRevocationStatusUseCase
    extends FutureUseCase<ClaimEntity, Map<String, dynamic>> {
  final CredentialRepository _credentialRepository;
  final IdentityRepository _identityRepository;
  final GenerateNonRevProofUseCase _generateNonRevProofUseCase;

  GetClaimRevocationStatusUseCase(this._credentialRepository,
      this._identityRepository, this._generateNonRevProofUseCase);

  @override
  Future<Map<String, dynamic>> execute({required ClaimEntity param}) async {
    return _credentialRepository.isUsingRHS(claim: param).then((useRHS) {
      if (useRHS) {
        return _generateNonRevProofUseCase.execute(param: param);
      }

      return _credentialRepository.getRevocationStatus(claim: param);
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
