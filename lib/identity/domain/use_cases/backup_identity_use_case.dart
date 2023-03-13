import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/identity_entity.dart';
import 'export_identity_use_case.dart';
import 'get_identity_use_case.dart';

class BackupIdentityUseCase extends FutureUseCase<String, Map<int, String>> {
  final GetIdentityUseCase _getIdentityUseCase;
  final ExportIdentityUseCase _exportIdentityUseCase;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;

  BackupIdentityUseCase(
    this._getIdentityUseCase,
    this._exportIdentityUseCase,
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
        result[profile.key] = await _exportIdentityUseCase.execute(
            param: ExportIdentityParam(
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
