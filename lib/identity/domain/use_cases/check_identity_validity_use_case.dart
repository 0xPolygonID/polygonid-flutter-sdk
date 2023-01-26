import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_config_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../constants.dart';
import '../entities/identity_entity.dart';
import '../entities/private_identity_entity.dart';
import '../exceptions/identity_exceptions.dart';
import '../repositories/identity_repository.dart';

class CheckIdentityValidityParam {
  final String secret;
  final String blockchain;
  final String network;

  CheckIdentityValidityParam({
    required this.secret,
    required this.blockchain,
    required this.network,
  });
}

class CheckIdentityValidityUseCase
    extends FutureUseCase<CheckIdentityValidityParam, void> {
  final IdentityRepository _identityRepository;

  CheckIdentityValidityUseCase(this._identityRepository);

  @override
  Future<void> execute(
      {required CheckIdentityValidityParam param}) async {
    try {
      String accessMessage = POLYGONID_ACCESS_MESSAGE;
      await _identityRepository.checkIdentityValidity(
              secret: param.secret,
              accessMessage: accessMessage,
              blockchain: param.blockchain,
              network: param.network);
      logger().i(
          "[CheckIdentityValidityUseCase] Identity is valid");
    } catch (error) {
      logger().e("[CheckValidIdentityUseCase] Error: $error");
      rethrow;
    }
  }
}
