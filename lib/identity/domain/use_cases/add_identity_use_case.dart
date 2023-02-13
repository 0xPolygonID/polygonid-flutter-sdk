import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_auth_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_public_keys_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../exceptions/identity_exceptions.dart';
import '../repositories/identity_repository.dart';
import 'create_identity_state_use_case.dart';
import 'create_identity_use_case.dart';
import 'get_did_identifier_use_case.dart';
import 'get_did_use_case.dart';

class AddIdentityParam {
  final String privateKey;
  final String blockchain;
  final String network;
  final List<int>? profiles;

  AddIdentityParam({
    required this.privateKey,
    required this.blockchain,
    required this.network,
    this.profiles
  });
}

class AddIdentityUseCase
    extends FutureUseCase<AddIdentityParam, PrivateIdentityEntity> {
  final IdentityRepository _identityRepository;
  final CreateIdentityUseCase _createIdentityUseCase;
  final CreateIdentityStateUseCase _createIdentityStateUseCase;

  AddIdentityUseCase(
    this._identityRepository,
      this._createIdentityUseCase,
      this._createIdentityStateUseCase,
  );

  @override
  Future<PrivateIdentityEntity> execute(
      {required AddIdentityParam param}) async {

    // Create the [IdentityEntity]
    PrivateIdentityEntity identity = await _createIdentityUseCase.execute(
        param: CreateIdentityParam(
            privateKey: param.privateKey,
            blockchain: param.blockchain,
            network: param.network,
            profiles: param.profiles));
    try {

      // Check if identity is already stored (already added)
      await _identityRepository.getIdentity(genesisDid: identity.did);

      // If there is already one, we throw
      throw IdentityAlreadyExistsException(identity.did);
    } on UnknownIdentityException {
      // If identity doesn't exist, we save it
      await _identityRepository.storeIdentity(identity: identity);

      // create identity state for each profile did
      if (identity.profiles != null) {
        for (String profileDid in identity.profiles.values) {
          await _createIdentityStateUseCase.execute(param:
          CreateIdentityStateParam(did: profileDid,
              privateKey: param.privateKey));
        }
      }
    } catch (error) {
      logger().e("[CreateAndSaveIdentityUseCase] Error: $error");

      rethrow;
    }

    logger().i(
        "[CreateAndSaveIdentityUseCase] Identity created and saved with did: ${identity.did}, for key $param");
    return identity;
  }
}
