import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
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
  final String _accessMessage;
  final IdentityRepository _identityRepository;
  final GetDidIdentifierUseCase _getDidIdentifierUseCase;

  CheckIdentityValidityUseCase(
    @Named('accessMessage') this._accessMessage,
    this._identityRepository,
    this._getDidIdentifierUseCase,
  );

  @override
  Future<void> execute({required CheckIdentityValidityParam param}) async {
    return _identityRepository
        .getPrivateKey(accessMessage: _accessMessage, secret: param.secret)
        .then((privateKey) => _getDidIdentifierUseCase.execute(
            param: GetDidIdentifierParam(
                privateKey: privateKey,
                blockchain: param.blockchain,
                network: param.network)))
        .then((_) {
      logger().i("[CheckIdentityValidityUseCase] Identity is valid");
    }).catchError((error) {
      logger().e("[CheckValidIdentityUseCase] Error: $error");

      return error;
    });
  }
}
