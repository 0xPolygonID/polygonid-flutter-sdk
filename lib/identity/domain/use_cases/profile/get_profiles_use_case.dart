import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

class GetProfilesParam {
  final String genesisDid;
  final String privateKey;

  GetProfilesParam({
    required this.genesisDid,
    required this.privateKey,
  });
}

class GetProfilesUseCase
    extends FutureUseCase<GetProfilesParam, Map<BigInt, String>> {
  final GetIdentityUseCase _getIdentityUseCase;
  final CheckProfileAndDidCurrentEnvUseCase
      _checkProfileAndDidCurrentEnvUseCase;
  final StacktraceManager _stacktraceManager;

  GetProfilesUseCase(
    this._getIdentityUseCase,
    this._checkProfileAndDidCurrentEnvUseCase,
    this._stacktraceManager,
  );

  @override
  Future<Map<BigInt, String>> execute({required GetProfilesParam param}) {
    return _checkProfileAndDidCurrentEnvUseCase
        .execute(
            param: CheckProfileAndDidCurrentEnvParam(
                did: param.genesisDid,
                privateKey: param.privateKey,
                profileNonce: BigInt.zero))
        .then((_) => _getIdentityUseCase
                .execute(param: GetIdentityParam(genesisDid: param.genesisDid))
                .then((identity) => identity.profiles)
                .then((profiles) {
              _stacktraceManager.addTrace(
                  "[GetProfilesUseCase] Profiles for $param are: $profiles");
              logger()
                  .i("[GetProfilesUseCase] Profiles for $param are: $profiles");

              return profiles;
            }))
        .catchError((error) {
      _stacktraceManager.addTrace("[GetProfilesUseCase] Error: $error");
      _stacktraceManager.addError("[GetProfilesUseCase] Error: $error");
      logger().e("[GetProfilesUseCase] Error: $error");
      throw error;
    });
  }
}
