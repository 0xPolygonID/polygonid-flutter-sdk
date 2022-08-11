import 'package:polygonid_flutter_sdk/domain/identity/entities/circuit_data_entity.dart';

import '../../common/domain_logger.dart';
import '../../common/use_case.dart';
import '../repositories/identity_repository.dart';

class GetAuthTokenParam {
  final String identifier;
  final CircuitDataEntity circuitData;
  final String message;

  GetAuthTokenParam(this.identifier, this.circuitData, this.message);
}

class GetAuthTokenUseCase extends FutureUseCase<GetAuthTokenParam, String> {
  final IdentityRepository _identityRepository;

  GetAuthTokenUseCase(this._identityRepository);

  @override
  Future<String> execute({required GetAuthTokenParam param}) {
    return _identityRepository
        .getAuthToken(
            identifier: param.identifier,
            circuitData: param.circuitData,
            message: param.message)
        .then((token) {
      logger().i("[GetAuthTokenUseCase] Auth token: $token");

      return token;
    }).catchError((error) {
      logger().e("[GetAuthTokenUseCase] Error: $error");

      throw error;
    });
  }
}
