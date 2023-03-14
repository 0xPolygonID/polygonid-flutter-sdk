import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/add_identity_use_case.dart';

import '../../../../common/domain/domain_logger.dart';
import '../../../../common/domain/use_case.dart';
import '../../repositories/identity_repository.dart';

class AddNewIdentityParam {
  final String? secret;
  final String blockchain;
  final String network;

  AddNewIdentityParam({
    this.secret,
    required this.blockchain,
    required this.network,
  });
}

class AddNewIdentityUseCase
    extends FutureUseCase<AddNewIdentityParam, PrivateIdentityEntity> {
  final String _accessMessage;
  final IdentityRepository _identityRepository;
  final AddIdentityUseCase _addIdentityUseCase;

  AddNewIdentityUseCase(
    @Named('accessMessage') this._accessMessage,
    this._identityRepository,
    this._addIdentityUseCase,
  );

  @override
  Future<PrivateIdentityEntity> execute({required AddNewIdentityParam param}) {
    // Get the privateKey
    return _identityRepository
        .getPrivateKey(accessMessage: _accessMessage, secret: param.secret)
        // Create and save the identity
        .then((privateKey) => _addIdentityUseCase.execute(
            param: AddIdentityParam(
                privateKey: privateKey,
                blockchain: param.blockchain,
                network: param.network)))
        .then((identity) {
      logger().i(
          "[AddNewIdentityUseCase] Identity created and saved with did: ${identity.did}, for key $param");

      return identity;
    }).catchError((error) {
      logger().e("[AddNewIdentityUseCase] Error: $error");

      throw error;
    });
  }
}
