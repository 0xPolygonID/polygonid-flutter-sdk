import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_config_use_case.dart';

import '../repositories/identity_repository.dart';

class GetGistProofUseCase extends FutureUseCase<String, String> {
  final IdentityRepository _identityRepository;
  final GetEnvConfigUseCase _getEnvConfigUseCase;

  GetGistProofUseCase(this._identityRepository, this._getEnvConfigUseCase);

  @override
  Future<String> execute({required String param}) async {
    return _getEnvConfigUseCase
        .execute(param: PolygonIdConfig.gistProofContractAddress)
        .then((contractAddress) => _identityRepository.getGistProof(
            identifier: param, contractAddress: contractAddress))
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
