import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';

import '../../../common/domain/use_case.dart';
import 'get_identity_use_case.dart';

class GetProfilesUseCase extends FutureUseCase<String, Map<int, String>> {
  final GetIdentityUseCase _getIdentityUseCase;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;

  GetProfilesUseCase(
      this._getIdentityUseCase, this._getCurrentEnvDidIdentifierUseCase);

  @override
  Future<Map<int, String>> execute({required String param}) {
    return _getCurrentEnvDidIdentifierUseCase
        .execute(param: GetCurrentEnvDidIdentifierParam(privateKey: param))
        .then((genesisId) => _getIdentityUseCase
            .execute(param: GetIdentityParam(genesisDid: param))
            .then((identity) => identity.profiles))
        .then((profiles) {
      logger().i("[GetProfilesUseCase] Profiles for $param are: $profiles");

      return profiles;
    }).catchError((error) {
      logger().e("[GetProfilesUseCase] Error: $error");

      throw error;
    });
  }
}
