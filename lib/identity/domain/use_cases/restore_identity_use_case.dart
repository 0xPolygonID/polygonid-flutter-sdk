import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/identity_entity.dart';
import '../entities/private_identity_entity.dart';
import 'create_and_save_identity_use_case.dart';
import 'get_did_identifier_use_case.dart';
import 'import_identity_use_case.dart';

class RestoreIdentityParam {
  final String privateKey;
  final String blockchain;
  final String network;
  final Map<int, String>? encryptedIdentityDbs;

  RestoreIdentityParam({
    required this.privateKey,
    required this.blockchain,
    required this.network,
    this.encryptedIdentityDbs,
  });
}

class RestoreIdentityUseCase
    extends FutureUseCase<RestoreIdentityParam, IdentityEntity> {
  final CreateAndSaveIdentityUseCase _createAndSaveIdentityUseCase;
  final ImportIdentityUseCase _importIdentityUseCase;
  final GetDidIdentifierUseCase _getDidIdentifierUseCase;

  RestoreIdentityUseCase(
    this._createAndSaveIdentityUseCase,
    this._importIdentityUseCase,
    this._getDidIdentifierUseCase,
  );

  @override
  Future<PrivateIdentityEntity> execute(
      {required RestoreIdentityParam param}) async {
    try {
      // Create the [PrivateIdentityEntity] with the secret
      PrivateIdentityEntity privateIdentity =
          await _createAndSaveIdentityUseCase.execute(
              param: CreateAndSaveIdentityParam(
                  privateKey: param.privateKey,
                  blockchain: param.blockchain,
                  network: param.network));

      if (param.encryptedIdentityDbs != null) {
        param.encryptedIdentityDbs!
            .forEach((profileNonce, encryptedIdentityDb) async {
          String profileDid = await _getDidIdentifierUseCase.execute(
              param: GetDidIdentifierParam(
                  privateKey: privateIdentity.privateKey,
                  blockchain: param.blockchain,
                  network: param.network,
                  profileNonce: profileNonce));
          await _importIdentityUseCase.execute(
              param: ImportIdentityParam(
            privateKey: privateIdentity.privateKey,
            did: profileDid,
            encryptedDb: encryptedIdentityDb,
          ));
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
