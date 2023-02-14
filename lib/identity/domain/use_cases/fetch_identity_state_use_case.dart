import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_config_use_case.dart';

import '../repositories/identity_repository.dart';
import 'get_did_use_case.dart';

class FetchIdentityStateUseCase extends FutureUseCase<String, String> {
  final IdentityRepository _identityRepository;
  final GetEnvConfigUseCase _getEnvConfigUseCase;
  final GetDidUseCase _getDidUseCase;

  FetchIdentityStateUseCase(
    this._identityRepository,
    this._getEnvConfigUseCase,
    this._getDidUseCase,
  );

  @override
  Future<String> execute({required String param}) async {
    return _getEnvConfigUseCase
        .execute(param: PolygonIdConfig.idStateContractAddress)
        .then((contractAddress) => _getDidUseCase
            .execute(param: param)
            .then((did) =>
                _identityRepository.convertIdToBigInt(id: did.identifier))
            .then((id) => _identityRepository.getState(
                identifier: id, contractAddress: contractAddress)))
        .then((state) {
      logger().i(
          "[FetchIdentityStateUseCase] Fetched state $state for identifier $param");

      return state;
    }).catchError((error) {
      logger().e("[FetchIdentityStateUseCase] Error: $error");

      throw error;
    });
  }
}
