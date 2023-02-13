import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_auth_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_public_keys_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../exceptions/identity_exceptions.dart';
import '../repositories/identity_repository.dart';
import 'get_did_identifier_use_case.dart';
import 'get_did_use_case.dart';

class CreateIdentityParam {
  final String privateKey;
  final String blockchain;
  final String network;
  final List<int>? profiles;

  CreateIdentityParam({
    required this.privateKey,
    required this.blockchain,
    required this.network,
    this.profiles
  });
}

class CreateIdentityUseCase
    extends FutureUseCase<CreateIdentityParam, PrivateIdentityEntity> {
  final IdentityRepository _identityRepository;

  CreateIdentityUseCase(
    this._identityRepository,
  );

  @override
  Future<PrivateIdentityEntity> execute(
      {required CreateIdentityParam param}) async {

    // Create the [IdentityEntity]
    PrivateIdentityEntity identity = await _identityRepository
        .createIdentity(
          privateKey: param.privateKey,
          blockchain: param.blockchain,
          network: param.network,
          profiles: param.profiles,
        )
        .then((entity) => PrivateIdentityEntity(
            did: entity.did,
            publicKey: entity.publicKey,
            profiles: entity.profiles,
            privateKey: param.privateKey));

    logger().i(
        "[CreateIdentityUseCase] Identity created with did: ${identity.did}, for key $param");

    return identity;
  }
}
