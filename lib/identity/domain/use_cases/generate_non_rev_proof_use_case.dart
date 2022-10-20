import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../repositories/identity_repository.dart';

class GenerateNonRevProofParam {
  final String id;
  final String rhsBaseUrl;
  final int revNonce;

  GenerateNonRevProofParam(this.id, this.rhsBaseUrl, this.revNonce);
}

class GenerateNonRevProofUseCase
    extends FutureUseCase<GenerateNonRevProofParam, Map<String, dynamic>> {
  final IdentityRepository _identityRepository;

  GenerateNonRevProofUseCase(this._identityRepository);

  @override
  Future<Map<String, dynamic>> execute(
      {required GenerateNonRevProofParam param}) async {
    try {
      Map<String, dynamic> proof = await _identityRepository.nonRevProof(
          param.revNonce, param.id, param.rhsBaseUrl);
      return proof;
    } catch (error) {
      logger().e("[GenerateNonRevProofUseCase] Error: $error");
      rethrow;
    }
  }
}
