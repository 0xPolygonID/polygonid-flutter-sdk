import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

class BackupIdentityUseCase extends FutureUseCase<String, String> {
  final GetIdentityUseCase _getIdentityUseCase;
  final IdentityRepository _identityRepository;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;

  BackupIdentityUseCase(
    this._getIdentityUseCase,
    this._identityRepository,
    this._getCurrentEnvDidIdentifierUseCase,
  );

  @override
  Future<String> execute({required String param}) async {
    String genesisDid = await _getCurrentEnvDidIdentifierUseCase.execute(
        param: GetCurrentEnvDidIdentifierParam(
            privateKey: param, profileNonce: GENESIS_PROFILE_NONCE));

    IdentityEntity identity = await _getIdentityUseCase.execute(
        param: GetIdentityParam(genesisDid: genesisDid, privateKey: param));

    return _identityRepository
        .exportIdentity(
      did: identity.did,
      privateKey: param,
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
