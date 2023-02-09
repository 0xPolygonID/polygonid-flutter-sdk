import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_identity_auth_claim_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../exceptions/identity_exceptions.dart';
import '../repositories/identity_repository.dart';
import 'get_did_identifier_use_case.dart';
import 'get_did_use_case.dart';

class CreateAndSaveIdentityParam {
  final String privateKey;
  final String blockchain;
  final String network;

  CreateAndSaveIdentityParam({
    required this.privateKey,
    required this.blockchain,
    required this.network,
  });
}

class CreateAndSaveIdentityUseCase
    extends FutureUseCase<CreateAndSaveIdentityParam, PrivateIdentityEntity> {
  final IdentityRepository _identityRepository;
  final GetDidUseCase _getDidUseCase;
  final GetDidIdentifierUseCase _getDidIdentifierUseCase;
  final GetIdentityAuthClaimUseCase _getIdentityAuthClaimUseCase;

  CreateAndSaveIdentityUseCase(
    this._identityRepository,
    this._getDidUseCase,
    this._getDidIdentifierUseCase,
    this._getIdentityAuthClaimUseCase,
  );

  @override
  Future<PrivateIdentityEntity> execute(
      {required CreateAndSaveIdentityParam param}) async {
    // Get AuthClaim
    List<String> authClaim =
        await _getIdentityAuthClaimUseCase.execute(param: param.privateKey);

    // Get the didIdentifier
    String didIdentifier = await _getDidIdentifierUseCase.execute(
        param: GetDidIdentifierParam(
            privateKey: param.privateKey,
            blockchain: param.blockchain,
            network: param.network));

    // Create the [IdentityEntity]
    PrivateIdentityEntity identity = await _identityRepository
        .createIdentity(
          didIdentifier: didIdentifier,
          privateKey: param.privateKey,
          authClaim: authClaim,
        )
        .then((entity) => PrivateIdentityEntity(
            did: entity.did,
            publicKey: entity.publicKey,
            profiles: entity.profiles,
            privateKey: param.privateKey));

    // Check if identity is already stored (already created)
    try {
      await _identityRepository.getIdentity(did: identity.did);

      // If there is already one, we throw
      throw IdentityAlreadyExistsException(identity.did);
    } on UnknownIdentityException {
      /// TODO: does this check make sense?
      // Check if the dids are the same
      String didIdentifier = await _getDidUseCase
          .execute(param: identity.did)
          .then((did) => _getDidIdentifierUseCase.execute(
              param: GetDidIdentifierParam(
                  privateKey: param.privateKey,
                  blockchain: did.blockchain,
                  network: did.network)));

      if (identity.did != didIdentifier) {
        throw InvalidPrivateKeyException(param.privateKey);
      }

      // If it doesn't exist, we save it
      await _identityRepository.storeIdentity(identity: identity);
    } catch (error) {
      logger().e("[CreateAndSaveIdentityUseCase] Error: $error");

      rethrow;
    }

    logger().i(
        "[CreateAndSaveIdentityUseCase] Identity created and saved with did: ${identity.did}, for key $param");
    return identity;
  }
}
