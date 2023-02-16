import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_auth_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_public_keys_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/remove_identity_state_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../credential/domain/use_cases/remove_all_claims_use_case.dart';
import '../entities/identity_entity.dart';
import '../exceptions/identity_exceptions.dart';
import '../repositories/identity_repository.dart';
import 'create_identity_state_use_case.dart';
import 'create_identity_use_case.dart';
import 'get_did_identifier_use_case.dart';
import 'get_did_use_case.dart';

class UpdateIdentityParam {
  final String privateKey;
  final String blockchain;
  final String network;
  final List<int> profiles;

  UpdateIdentityParam(
      {required this.privateKey,
      required this.blockchain,
      required this.network,
      this.profiles = const []});
}

class UpdateIdentityUseCase
    extends FutureUseCase<UpdateIdentityParam, PrivateIdentityEntity> {
  final IdentityRepository _identityRepository;
  final CreateIdentityUseCase _createIdentityUseCase;
  final CreateIdentityStateUseCase _createIdentityStateUseCase;
  final RemoveIdentityStateUseCase _removeIdentityStateUseCase;
  final RemoveAllClaimsUseCase _removeAllClaimsUseCase;

  UpdateIdentityUseCase(
    this._identityRepository,
    this._createIdentityUseCase,
    this._createIdentityStateUseCase,
    this._removeIdentityStateUseCase,
    this._removeAllClaimsUseCase,
  );

  @override
  Future<PrivateIdentityEntity> execute(
      {required UpdateIdentityParam param}) async {
    // Create the new [IdentityEntity]
    PrivateIdentityEntity identity = await _createIdentityUseCase.execute(
        param: CreateIdentityParam(
            privateKey: param.privateKey,
            blockchain: param.blockchain,
            network: param.network,
            profiles: param.profiles));

    try {
      // Check if identity is already stored (already added)
      IdentityEntity oldIdentity =
          await _identityRepository.getIdentity(genesisDid: identity.did);

      // remove old identity states and claims
      if (oldIdentity.profiles != null) {
        for (int profileDid in oldIdentity.profiles.keys) {
          if (identity.profiles == null ||
              identity.profiles[profileDid] == null) {
            await _removeIdentityStateUseCase.execute(
                param: RemoveIdentityStateParam(
                    did: oldIdentity.profiles[profileDid]!,
                    privateKey: param.privateKey));
            await _removeAllClaimsUseCase.execute(
                param: RemoveAllClaimsParam(
                    did: oldIdentity.profiles[profileDid]!,
                    privateKey: param.privateKey));
          }
        }
      }

      // create identity state for each profile did that was not previously created
      if (identity.profiles != null) {
        for (String profileDid in identity.profiles.values) {
          if (oldIdentity.profiles == null ||
              oldIdentity.profiles[profileDid] == null) {
            await _createIdentityStateUseCase.execute(
                param: CreateIdentityStateParam(
                    did: profileDid, privateKey: param.privateKey));
          }
        }
      }
    } catch (error) {
      logger().e("[UpdateIdentityUseCase] Error: $error");

      rethrow;
    }

    logger().i(
        "[UpdateIdentityUseCase] Identity updated with did: ${identity.did}, for key $param");
    return identity;
  }
}
