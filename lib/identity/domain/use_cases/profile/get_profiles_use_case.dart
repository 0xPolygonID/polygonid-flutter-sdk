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
  Future<Map<BigInt, String>> execute({required GetProfilesParam param}) async {
    try {
      await _checkProfileAndDidCurrentEnvUseCase.execute(
        param: CheckProfileAndDidCurrentEnvParam.withPrivateKey(
          did: param.genesisDid,
          privateKey: param.privateKey,
          profileNonce: BigInt.zero,
        ),
      );

      final identity = await _getIdentityUseCase.execute(
        param: GetIdentityParam(genesisDid: param.genesisDid),
      );

      return identity.profiles;
    } catch (error) {
      _stacktraceManager.logError("[GetProfilesUseCase] Error: $error");
      rethrow;
    }
  }
}
