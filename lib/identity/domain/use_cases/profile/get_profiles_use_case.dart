import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

class GetProfilesParam {
  final String genesisDid;
  final String privateKey;

  GetProfilesParam({required this.genesisDid, required this.privateKey});
}

class GetProfilesUseCase
    extends FutureUseCase<GetProfilesParam, Map<int, String>> {
  final GetIdentityUseCase _getIdentityUseCase;
  final CheckProfileAndDidCurrentEnvUseCase
      _checkProfileAndDidCurrentEnvUseCase;

  GetProfilesUseCase(
      this._getIdentityUseCase, this._checkProfileAndDidCurrentEnvUseCase);

  @override
  Future<Map<int, String>> execute({required GetProfilesParam param}) {
    return _checkProfileAndDidCurrentEnvUseCase
        .execute(
            param: CheckProfileAndDidCurrentEnvParam(
                did: param.genesisDid, privateKey: param.privateKey))
        .then((_) => _getIdentityUseCase
                .execute(param: GetIdentityParam(genesisDid: param.genesisDid))
                .then((identity) => identity.profiles)
                .then((profiles) {
              logger()
                  .i("[GetProfilesUseCase] Profiles for $param are: $profiles");

              return profiles;
            }))
        .catchError((error) {
      logger().e("[GetProfilesUseCase] Error: $error");

      throw error;
    });
  }
}
