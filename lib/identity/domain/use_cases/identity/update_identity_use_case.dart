import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/create_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

class UpdateIdentityParam {
  final String privateKey;
  final List<BigInt> profiles;

  UpdateIdentityParam({required this.privateKey, this.profiles = const []});
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
            privateKey: param.privateKey, profiles: param.profiles));

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
