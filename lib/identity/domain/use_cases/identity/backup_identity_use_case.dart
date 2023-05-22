import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

class BackupIdentityParam {
  final String genesisDid;
  final String privateKey;

  BackupIdentityParam({
    required this.genesisDid,
    required this.privateKey,
  });
}

class BackupIdentityUseCase extends FutureUseCase<BackupIdentityParam, String> {
  final GetIdentityUseCase _getIdentityUseCase;
  final IdentityRepository _identityRepository;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;

  BackupIdentityUseCase(
    this._getIdentityUseCase,
    this._identityRepository,
    this._getCurrentEnvDidIdentifierUseCase,
  );

  @override
  Future<String> execute({required BackupIdentityParam param}) async {
    PrivateIdentityEntity identity = await _getIdentityUseCase.execute(
        param: GetIdentityParam(
            genesisDid: param.genesisDid,
            privateKey: param.privateKey)) as PrivateIdentityEntity;

    return _identityRepository
        .exportIdentity(
      did: identity.did,
      privateKey: identity.privateKey,
    )
        .then((export) {
      logger().i(
          "[BackupIdentityUseCase] Identity backed up with did: ${identity.did}, for key $param");
      return export;
    }).catchError((error) {
      logger().e("[BackupIdentityUseCase] Error: $error");
      throw error;
    });
  }
}
