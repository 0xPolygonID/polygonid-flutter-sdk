import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_public_keys_use_case.dart';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';

class CreateProfilesParam {
  final String privateKey;
  final List<BigInt> profiles;

  CreateProfilesParam({required this.privateKey, this.profiles = const []});
}

class CreateProfilesUseCase
    extends FutureUseCase<CreateProfilesParam, Map<BigInt, String>> {
  final GetPublicKeysUseCase _getPublicKeysUseCase;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;
  final StacktraceManager _stacktraceManager;

  CreateProfilesUseCase(
    this._getPublicKeysUseCase,
    this._getCurrentEnvDidIdentifierUseCase,
    this._stacktraceManager,
  );

  @override
  Future<Map<BigInt, String>> execute(
      {required CreateProfilesParam param}) async {
    return Future.wait(
      [
        _getPublicKeysUseCase.execute(param: param.privateKey),
        _getCurrentEnvDidIdentifierUseCase.execute(
            param: GetCurrentEnvDidIdentifierParam(
                privateKey: param.privateKey, profileNonce: BigInt.zero))
      ],
      eagerError: true,
    ).then((values) async {
      String didIdentifier = values[1] as String;
      List<String> publicKey = values[0] as List<String>;
      Map<BigInt, String> profiles = {BigInt.zero: didIdentifier};

      for (BigInt profile in param.profiles) {
        String profileDid = await _getCurrentEnvDidIdentifierUseCase.execute(
            param: GetCurrentEnvDidIdentifierParam(
                privateKey: param.privateKey, profileNonce: profile));
        profiles[profile] = profileDid;
      }

      return profiles;
    }).then((profiles) {
      _stacktraceManager.addTrace(
          "[CreateProfilesUseCase] Profiles created with values: $profiles, for param $param");
      logger().i(
          "[CreateProfilesUseCase] Profiles created with values: $profiles, for param $param");

      return profiles;
    }).catchError((error) {
      _stacktraceManager
          .addTrace("[CreateProfilesUseCase] Error: $error for param $param");
      _stacktraceManager
          .addError("[CreateProfilesUseCase] Error: $error for param $param");
      logger().e("[CreateProfilesUseCase] Error: $error for param $param");

      throw error;
    });
  }
}
