import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_config_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/identity_entity.dart';
import '../entities/private_identity_entity.dart';
import '../exceptions/identity_exceptions.dart';
import '../repositories/identity_repository.dart';
import 'get_did_identifier_use_case.dart';
import 'get_did_use_case.dart';

class CreateAndSaveIdentityFromPKParam {
  final String privateKey;
  final String blockchain;
  final String network;

  CreateAndSaveIdentityFromPKParam({
    required this.privateKey,
    required this.blockchain,
    required this.network,
  });
}

class CreateAndSaveIdentityFromPKUseCase
    extends FutureUseCase<CreateAndSaveIdentityFromPKParam, IdentityEntity> {
  final IdentityRepository _identityRepository;
  final GetDidUseCase _getDidUseCase;
  final GetDidIdentifierUseCase _getDidIdentifierUseCase;

  CreateAndSaveIdentityFromPKUseCase(
    this._identityRepository,
    this._getDidUseCase,
    this._getDidIdentifierUseCase,
  );

  @override
  Future<PrivateIdentityEntity> execute(
      {required CreateAndSaveIdentityFromPKParam param}) async {
    // Create the [PrivateIdentityEntity] with the secret
    PrivateIdentityEntity privateIdentity =
        await _identityRepository.restoreIdentity(
            privateKey: param.privateKey,
            blockchain: param.blockchain,
            network: param.network);

    // Check if identity is already stored (already created)
    try {
      IdentityEntity identity =
          await _identityRepository.getIdentity(did: privateIdentity.did);

      // If there is already one, we throw
      throw IdentityAlreadyExistsException(identity.did);
    } on UnknownIdentityException {
      /// TODO: does this check make sense?
      // Check if the dids are the same
      String didIdentifier = await _getDidUseCase
          .execute(param: privateIdentity.did)
          .then((did) => _getDidIdentifierUseCase.execute(
              param: GetDidIdentifierParam(
                  privateKey: privateIdentity.privateKey,
                  blockchain: did.blockchain,
                  network: did.network)));

      if (privateIdentity.did != didIdentifier) {
        throw InvalidPrivateKeyException(privateIdentity.privateKey);
      }

      // If it doesn't exist, we save it
      await _identityRepository.storeIdentity(identity: privateIdentity);
    } catch (error) {
      logger().e("[CreateAndSaveIdentityUseCase] Error: $error");

      rethrow;
    }

    logger().i(
        "[CreateAndSaveIdentityUseCase] Identity created and saved with did: ${privateIdentity.did}, for key $param");
    return privateIdentity;
  }
}
