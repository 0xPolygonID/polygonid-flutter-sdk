import 'package:polygonid_flutter_sdk/identity/domain/use_cases/fetch_state_roots_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../identity/domain/use_cases/fetch_identity_state_use_case.dart';
import '../exceptions/proof_generation_exceptions.dart';
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
  final FetchStateRootsUseCase _fetchStateRootsUseCase;
  final ProofRepository _proofRepository;

  GenerateNonRevProofUseCase(this._fetchIdentityStateUseCase,
      this._fetchStateRootsUseCase, this._proofRepository);

  @override
  Future<Map<String, dynamic>> execute(
      {required GenerateNonRevProofParam param}) async {
    try {
      // 1. Fetch identity latest state from the smart contract.
      String idStateHash = await _fetchIdentityStateUseCase.execute(
          param: FetchIdentityStateParam(id: param.id));

      if (idStateHash == "") {
        throw GenerateNonRevProofException(idStateHash);
      }

      //2. walk rhs
      Map<String, dynamic> proof = await _proofRepository.nonRevProof(
          param.revNonce, idStateHash, param.rhsBaseUrl);
      return proof;
    } catch (error) {
      logger().e("[GenerateNonRevProofUseCase] Error: $error");
      rethrow;
    }
  }
}
