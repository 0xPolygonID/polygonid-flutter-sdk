import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/fetch_identity_state_use_case.dart';

class GetNonRevProofUseCase
    extends FutureUseCase<ClaimEntity, Map<String, dynamic>> {
  final IdentityRepository _identityRepository;
  final CredentialRepository _credentialRepository;
  final FetchIdentityStateUseCase _fetchIdentityStateUseCase;

  GetNonRevProofUseCase(this._identityRepository, this._credentialRepository,
      this._fetchIdentityStateUseCase);

  @override
  Future<Map<String, dynamic>> execute({required ClaimEntity param}) {
    return _credentialRepository
        .getRevocationStatus(claim: param)
        .then((nonRevProof) {
      logger().i("[GetNonRevProofUseCase] Non rev proof: $nonRevProof");

      return nonRevProof;
    }).catchError((error) {
      logger().e("[GetNonRevProofUseCase] Error: $error");

      throw error;
    });
  }
}
