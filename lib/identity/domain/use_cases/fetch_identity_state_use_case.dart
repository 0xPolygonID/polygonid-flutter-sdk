import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';

class FetchIdentityStateUseCase extends FutureUseCase<String, String> {
  final IdentityRepository _identityRepository;
  final GetEnvUseCase _getEnvUseCase;
  final GetDidUseCase _getDidUseCase;

  FetchIdentityStateUseCase(
    this._identityRepository,
    this._getEnvUseCase,
    this._getDidUseCase,
  );

  @override
  Future<String> execute({required String param}) async {
    return _getEnvUseCase
        .execute()
        .then((env) => _getDidUseCase
            .execute(param: param)
            .then((did) =>
                _identityRepository.convertIdToBigInt(id: did.identifier))
            .then((id) => _identityRepository.getState(
                identifier: id, contractAddress: env.idStateContract)))
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
