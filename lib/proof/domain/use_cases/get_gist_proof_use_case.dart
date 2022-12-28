import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_config_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_proof_entity.dart';

import '../repositories/proof_repository.dart';

class GetGistProofUseCase extends FutureUseCase<String, GistProofEntity> {
  final ProofRepository _proofRepository;
  final GetEnvConfigUseCase _getEnvConfigUseCase;

  GetGistProofUseCase(this._proofRepository, this._getEnvConfigUseCase);

  @override
  Future<GistProofEntity> execute({required String param}) async {
    return _getEnvConfigUseCase
        .execute(param: PolygonIdConfig.gistProofContractAddress)
        .then((contractAddress) => _proofRepository.getGistProof(
            idAsInt: param, contractAddress: contractAddress))
        .then((proof) {
      logger()
          .i("[GetGistProofUseCase] Gist proof $proof for identifier $param");

      return proof;
    }).catchError((error) {
      logger().e("[GetGistProofUseCase] Error: $error");

      throw error;
    });
  }
}
