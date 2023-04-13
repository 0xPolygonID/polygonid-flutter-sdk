import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';

import '../../../../common/domain/domain_logger.dart';
import '../../../../common/domain/use_case.dart';
import '../../exceptions/identity_exceptions.dart';
import '../../repositories/identity_repository.dart';
import '../smt/create_identity_state_use_case.dart';
import 'create_identity_use_case.dart';

class AddIdentityParam {
  final String privateKey;
  final List<BigInt> profiles;

  AddIdentityParam({
    required this.privateKey,
    this.profiles = const [],
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
            privateKey: param.privateKey, profiles: param.profiles));
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
          await _createIdentityStateUseCase.execute(
              param: CreateIdentityStateParam(
                  did: profileDid, privateKey: param.privateKey));
        }
      }
    } catch (error) {
      logger().e("[AddIdentityUseCase] Error: $error");

      rethrow;
    }

    logger().i(
        "[AddIdentityUseCase] Identity created and saved with did: ${identity.did}, for key ${param.privateKey}");
    return identity;
  }
}
