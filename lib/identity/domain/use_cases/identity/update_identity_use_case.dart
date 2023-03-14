import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_auth_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_public_keys_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/smt/remove_identity_state_use_case.dart';

import '../../../../common/domain/domain_logger.dart';
import '../../../../common/domain/use_case.dart';
import '../../../../credential/domain/use_cases/remove_all_claims_use_case.dart';
import '../../entities/identity_entity.dart';
import '../../exceptions/identity_exceptions.dart';
import '../../repositories/identity_repository.dart';
import '../smt/create_identity_state_use_case.dart';
import 'create_identity_use_case.dart';
import '../get_did_identifier_use_case.dart';
import '../get_did_use_case.dart';

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
  final GetIdentityUseCase _getIdentityUseCase;

  UpdateIdentityUseCase(
    this._identityRepository,
    this._createIdentityUseCase,
    this._getIdentityUseCase,
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
      IdentityEntity oldIdentity = await _getIdentityUseCase.execute(
          param: GetIdentityParam(
              genesisDid: identity.did, privateKey: param.privateKey));

      if (oldIdentity is PrivateIdentityEntity) {
        await _identityRepository.storeIdentity(identity: identity);
      } else {
        throw InvalidPrivateKeyException(param.privateKey);
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
