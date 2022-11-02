import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_config_use_case.dart';

import '../repositories/identity_repository.dart';

class FetchIdentityStateUseCase extends FutureUseCase<String, String> {
  final IdentityRepository _identityRepository;
  final GetEnvConfigUseCase _getEnvConfigUseCase;

  FetchIdentityStateUseCase(
      this._identityRepository, this._getEnvConfigUseCase);

  @override
  Future<String> execute({required String param}) async {
    return _getEnvConfigUseCase
        .execute(param: PolygonIdConfig.idStateContractAddress)
        .then((contractAddress) => _identityRepository.fetchIdentityState(
            id: param, contractAddress: contractAddress))
        .then((state) {
      logger()
          .i("[FetchIdentityStateUseCase] Fetched state $state for id $param");

      return state;
    }).catchError((error) {
      logger().e("[FetchIdentityStateUseCase] Error: $error");

      throw error;
    });
  }
}
