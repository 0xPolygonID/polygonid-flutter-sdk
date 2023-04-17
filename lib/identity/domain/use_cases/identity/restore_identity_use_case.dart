import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/add_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

class RestoreIdentityParam {
  final String genesisDid;
  final String privateKey;
  final String? encryptedDb;

  RestoreIdentityParam({
    required this.genesisDid,
    required this.privateKey,
    this.encryptedDb,
  });
}

class RestoreIdentityUseCase
    extends FutureUseCase<RestoreIdentityParam, IdentityEntity> {
  final AddIdentityUseCase _addIdentityUseCase;
  final GetIdentityUseCase _getIdentityUseCase;
  final IdentityRepository _identityRepository;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;

  RestoreIdentityUseCase(
    this._addIdentityUseCase,
    this._getIdentityUseCase,
    this._identityRepository,
    this._getCurrentEnvDidIdentifierUseCase,
  );

  @override
  Future<PrivateIdentityEntity> execute(
      {required RestoreIdentityParam param}) async {
    PrivateIdentityEntity? privateIdentity;

    try {
      String genesisDid = await _getCurrentEnvDidIdentifierUseCase.execute(
          param: GetCurrentEnvDidIdentifierParam(
              privateKey: param.privateKey,
              profileNonce: GENESIS_PROFILE_NONCE));
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
      if (param.encryptedDb != null && privateIdentity != null) {
        await _identityRepository
            .importIdentity(
          did: privateIdentity.did,
          privateKey: param.privateKey,
          encryptedDb: param.encryptedDb!,
        )
            .then((_) {
          logger().i(
              "[ImportProfileUseCase] Profile for did ${privateIdentity!.did} has been imported");
        }).catchError((error) {
          logger().e("[ImportProfileUseCase] Error: $error");

          throw error;
        });
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
