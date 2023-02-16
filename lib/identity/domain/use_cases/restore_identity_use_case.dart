import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_identity_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/identity_entity.dart';
import '../entities/private_identity_entity.dart';
import '../exceptions/identity_exceptions.dart';
import 'add_identity_use_case.dart';
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
  final AddIdentityUseCase _addIdentityUseCase;
  final GetIdentityUseCase _getIdentityUseCase;
  final ImportIdentityUseCase _importIdentityUseCase;
  final GetDidIdentifierUseCase _getDidIdentifierUseCase;

  RestoreIdentityUseCase(
    this._addIdentityUseCase,
    this._getIdentityUseCase,
    this._importIdentityUseCase,
    this._getDidIdentifierUseCase,
  );

  @override
  Future<PrivateIdentityEntity> execute(
      {required RestoreIdentityParam param}) async {
    PrivateIdentityEntity? privateIdentity;
    try {
      String genesisDid = await _getDidIdentifierUseCase.execute(
          param: GetDidIdentifierParam(
              privateKey: param.privateKey,
              blockchain: param.blockchain,
              network: param.network));
      privateIdentity = await _getIdentityUseCase.execute(
          param: GetIdentityParam(
              genesisDid: genesisDid,
              privateKey: param.privateKey)) as PrivateIdentityEntity;
    } on UnknownIdentityException {
      privateIdentity = await _addIdentityUseCase.execute(
          param: AddIdentityParam(
              privateKey: param.privateKey,
              blockchain: param.blockchain,
              network: param.network));
    } catch (error) {
      logger().e("[RestoreIdentityUseCase] Error: $error");

      rethrow;
    }

    try {
      if (param.encryptedIdentityDbs != null && privateIdentity != null) {
        for (MapEntry<int, String> identityDb
            in param.encryptedIdentityDbs!.entries) {
          String profileDid = await _getDidIdentifierUseCase.execute(
              param: GetDidIdentifierParam(
                  privateKey: param.privateKey,
                  blockchain: param.blockchain,
                  network: param.network,
                  profileNonce: identityDb.key));
          await _importIdentityUseCase.execute(
              param: ImportIdentityParam(
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
