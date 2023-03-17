import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/export_profile_use_case.dart';

class BackupIdentityUseCase extends FutureUseCase<String, Map<int, String>> {
  final GetIdentityUseCase _getIdentityUseCase;
  final ExportProfileUseCase _exportProfileUseCase;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;

  BackupIdentityUseCase(
    this._getIdentityUseCase,
    this._exportProfileUseCase,
    this._getCurrentEnvDidIdentifierUseCase,
  );

  @override
  Future<Map<int, String>> execute({required String param}) async {
    try {
      Map<int, String> result = {};
      String genesisDid = await _getCurrentEnvDidIdentifierUseCase.execute(
          param: GetCurrentEnvDidIdentifierParam(privateKey: param));

      IdentityEntity identity = await _getIdentityUseCase.execute(
          param: GetIdentityParam(genesisDid: genesisDid));

      for (MapEntry<int, String> profile in identity.profiles.entries) {
        result[profile.key] = await _exportProfileUseCase.execute(
            param: ExportProfileParam(
          privateKey: param,
          did: profile.value,
        ));
      }

      logger().i(
          "[BackupIdentityUseCase] Identity backed up with did: ${identity.did}, for key $param");
      return result;
    } catch (error) {
      logger().e("[BackupIdentityUseCase] Error: $error");

      rethrow;
    }
  }
}
