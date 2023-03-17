import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/add_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/import_profile_use_case.dart';

class RestoreIdentityParam {
  final String privateKey;
  final Map<int, String>? encryptedIdentityDbs;

  RestoreIdentityParam({
    required this.privateKey,
    this.encryptedIdentityDbs,
  });
}

class RestoreIdentityUseCase
    extends FutureUseCase<RestoreIdentityParam, IdentityEntity> {
  final AddIdentityUseCase _addIdentityUseCase;
  final GetIdentityUseCase _getIdentityUseCase;
  final ImportProfileUseCase _importProfileUseCase;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;

  RestoreIdentityUseCase(
    this._addIdentityUseCase,
    this._getIdentityUseCase,
    this._importProfileUseCase,
    this._getCurrentEnvDidIdentifierUseCase,
  );

  @override
  Future<PrivateIdentityEntity> execute(
      {required RestoreIdentityParam param}) async {
    PrivateIdentityEntity? privateIdentity;

    try {
      String genesisDid = await _getCurrentEnvDidIdentifierUseCase.execute(
          param: GetCurrentEnvDidIdentifierParam(privateKey: param.privateKey));
      privateIdentity = await _getIdentityUseCase.execute(
          param: GetIdentityParam(
              genesisDid: genesisDid,
              privateKey: param.privateKey)) as PrivateIdentityEntity;
    } on UnknownIdentityException {
      privateIdentity = await _addIdentityUseCase.execute(
          param: AddIdentityParam(privateKey: param.privateKey));
    } catch (error) {
      logger().e("[RestoreIdentityUseCase] Error: $error");

      rethrow;
    }

    try {
      if (param.encryptedIdentityDbs != null && privateIdentity != null) {
        for (MapEntry<int, String> identityDb
            in param.encryptedIdentityDbs!.entries) {
          String profileDid = await _getCurrentEnvDidIdentifierUseCase.execute(
              param: GetCurrentEnvDidIdentifierParam(
                  privateKey: param.privateKey, profileNonce: identityDb.key));
          await _importProfileUseCase.execute(
              param: ImportProfileParam(
            privateKey: param.privateKey,
            did: profileDid,
            encryptedDb: identityDb.value,
          ));
        }
      }

      logger().i(
          "[RestoreIdentityUseCase] Identity restored with did: ${privateIdentity.did}, for key $param");
      return privateIdentity;
    } catch (error) {
      logger().e("[RestoreIdentityUseCase] Error: $error");

      rethrow;
    }
  }
}
