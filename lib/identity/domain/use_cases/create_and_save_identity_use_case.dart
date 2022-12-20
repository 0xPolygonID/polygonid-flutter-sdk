import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_config_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../constants.dart';
import '../entities/identity_entity.dart';
import '../entities/private_identity_entity.dart';
import '../exceptions/identity_exceptions.dart';
import '../repositories/identity_repository.dart';

class CreateAndSaveIdentityParam {
  final String? secret;
  final String blockchain;
  final String network;

  CreateAndSaveIdentityParam({
    this.secret,
    required this.blockchain,
    required this.network,
  });
}

class CreateAndSaveIdentityUseCase
    extends FutureUseCase<CreateAndSaveIdentityParam, IdentityEntity> {
  final IdentityRepository _identityRepository;
  final GetEnvConfigUseCase _getEnvConfigUseCase;

  CreateAndSaveIdentityUseCase(
      this._identityRepository, this._getEnvConfigUseCase);

  @override
  Future<PrivateIdentityEntity> execute(
      {required CreateAndSaveIdentityParam param}) async {
    // Create the [PrivateIdentityEntity] with the secret
    String accessMessage = POLYGONID_ACCESS_MESSAGE;
    PrivateIdentityEntity privateIdentity =
        await _identityRepository.createIdentity(
            secret: param.secret,
            accessMessage: accessMessage,
            blockchain: param.blockchain,
            network: param.network);

    // Check if identity is already stored (already created)
    try {
      IdentityEntity identity =
          await _identityRepository.getIdentity(did: privateIdentity.did);

      // If there is already one, we throw
      throw IdentityAlreadyExistsException(identity.did);
    } on UnknownIdentityException {
      // If it doesn't exist, we save it
      await _identityRepository.storeIdentity(
          identity: privateIdentity, privateKey: privateIdentity.privateKey);
    } catch (error) {
      logger().e("[CreateAndSaveIdentityUseCase] Error: $error");

      rethrow;
    }

    logger().i(
        "[CreateAndSaveIdentityUseCase] Identity created and saved with did: ${privateIdentity.did}, for key ${param.secret}");
    return privateIdentity;
  }
}
