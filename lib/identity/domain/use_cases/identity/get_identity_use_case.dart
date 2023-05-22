import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/did_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';

class GetIdentityParam {
  final String genesisDid;
  final String? privateKey;

  GetIdentityParam({
    required this.genesisDid,
    this.privateKey,
  });
}

class GetIdentityUseCase
    extends FutureUseCase<GetIdentityParam, IdentityEntity> {
  final IdentityRepository _identityRepository;
  final GetDidUseCase _getDidUseCase;
  final GetDidIdentifierUseCase _getDidIdentifierUseCase;

  GetIdentityUseCase(
    this._identityRepository,
    this._getDidUseCase,
    this._getDidIdentifierUseCase,
  );

  @override
  Future<IdentityEntity> execute({required GetIdentityParam param}) async {
    try {
      IdentityEntity identity;

      // Check if we want [PrivateIdentityEntity] or [IdentityEntity]
      if (param.privateKey != null) {
        // Check if the did from param matches the did from the privateKey
        DidEntity did = await _getDidUseCase.execute(param: param.genesisDid);

        String genesisDid = await _getDidIdentifierUseCase.execute(
            param: GetDidIdentifierParam(
                privateKey: param.privateKey!,
                blockchain: did.blockchain,
                network: did.network,
                profileNonce: GENESIS_PROFILE_NONCE));

        if (did.did != genesisDid) {
          throw InvalidPrivateKeyException(param.privateKey!);
        }

        // Get the [PrivateIdentityEntity]
        identity = await _identityRepository
            .getIdentity(genesisDid: param.genesisDid)
            .then((identity) => PrivateIdentityEntity(
                did: param.genesisDid,
                publicKey: identity.publicKey,
                profiles: identity.profiles,
                privateKey: param.privateKey!));
      } else {
        identity =
            await _identityRepository.getIdentity(genesisDid: param.genesisDid);
      }

      logger().i("[GetIdentityUseCase] Identity: $identity");

      return identity;
    } catch (error) {
      logger().e("[GetIdentityUseCase] Error: $error");

      rethrow;
    }
  }
}
