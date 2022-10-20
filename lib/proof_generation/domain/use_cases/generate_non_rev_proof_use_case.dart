import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../identity/domain/use_cases/fetch_identity_state_use_case.dart';
import '../repositories/proof_repository.dart';

class GenerateNonRevProofParam {
  final String id;
  final String rhsBaseUrl;
  final int revNonce;

  GenerateNonRevProofParam(this.id, this.rhsBaseUrl, this.revNonce);
}

class GenerateNonRevProofUseCase
    extends FutureUseCase<GenerateNonRevProofParam, Map<String, dynamic>> {
  final FetchIdentityStateUseCase _fetchIdentityStateUseCase;
  final ProofRepository _proofRepository;

  GenerateNonRevProofUseCase(
      this._fetchIdentityStateUseCase, this._proofRepository);

  @override
  Future<Map<String, dynamic>> execute(
      {required GenerateNonRevProofParam param}) async {
    try {
      Map<String, dynamic> proof = await _proofRepository.nonRevProof(
          param.revNonce, param.id, param.rhsBaseUrl);
      return proof;
    } catch (error) {
      logger().e("[GenerateNonRevProofUseCase] Error: $error");
      rethrow;
    }
  }
}
