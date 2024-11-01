import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

class UpdateIdentityParam {
  final String privateKey;
  final String genesisDid;
  final Map<BigInt, String> profiles;

  UpdateIdentityParam({
    required this.privateKey,
    required this.genesisDid,
    this.profiles = const {},
  });
}

class UpdateIdentityUseCase
    extends FutureUseCase<UpdateIdentityParam, PrivateIdentityEntity> {
  final IdentityRepository _identityRepository;
  final GetIdentityUseCase _getIdentityUseCase;

  UpdateIdentityUseCase(
    this._identityRepository,
    this._getIdentityUseCase,
  );

  @override
  Future<PrivateIdentityEntity> execute({
    required UpdateIdentityParam param,
  }) async {
    IdentityEntity identity = await _getIdentityUseCase.execute(
      param: GetIdentityParam(
        genesisDid: param.genesisDid,
        privateKey: param.privateKey,
      ),
    );

    try {
      if (identity is PrivateIdentityEntity) {
        identity.profiles.clear();
        identity.profiles.addAll(param.profiles);
        // we save the profiles in a separate store ref
        await _identityRepository.putProfiles(
          did: param.genesisDid,
          privateKey: param.privateKey,
          profiles: param.profiles,
        );
        // then we update the identity
        await _identityRepository.storeIdentity(identity: identity);
      } else {
        throw InvalidPrivateKeyException(
          privateKey: param.privateKey,
          errorMessage: "The provided private key is not valid",
        );
      }
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      logger().e("[UpdateIdentityUseCase] Error: $error");

      throw UnknownIdentityException(
        did: param.genesisDid,
        errorMessage: "Error updating identity, with error: $error",
      );
    }

    logger().i("[UpdateIdentityUseCase] Identity updated");
    return identity;
  }
}
