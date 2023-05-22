import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_public_keys_use_case.dart';

import '../../../../common/domain/domain_logger.dart';
import '../../../../common/domain/use_case.dart';

class CreateProfilesParam {
  final String privateKey;
  final List<BigInt> profiles;

  CreateProfilesParam({required this.privateKey, this.profiles = const []});
}

class CreateProfilesUseCase
    extends FutureUseCase<CreateProfilesParam, Map<BigInt, String>> {
  final GetPublicKeysUseCase _getPublicKeysUseCase;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;

  CreateProfilesUseCase(
    this._getPublicKeysUseCase,
    this._getCurrentEnvDidIdentifierUseCase,
  );

  @override
  Future<Map<BigInt, String>> execute(
      {required CreateProfilesParam param}) async {
    return Future.wait([
      _getPublicKeysUseCase.execute(param: param.privateKey),
      _getCurrentEnvDidIdentifierUseCase.execute(
          param: GetCurrentEnvDidIdentifierParam(
              privateKey: param.privateKey, profileNonce: BigInt.zero))
    ], eagerError: true)
        .then((values) async {
      String didIdentifier = values[1] as String;
      Map<BigInt, String> profiles = {BigInt.zero: didIdentifier};

      for (BigInt profile in param.profiles) {
        String profileDid = await _getCurrentEnvDidIdentifierUseCase.execute(
            param: GetCurrentEnvDidIdentifierParam(
                privateKey: param.privateKey, profileNonce: profile));
        profiles[profile] = profileDid;
      }

      return profiles;
    }).then((profiles) {
      logger().i(
          "[CreateProfilesUseCase] Profiles created with values: $profiles, for param $param");

      return profiles;
    }).catchError((error) {
      logger().e("[CreateProfilesUseCase] Error: $error for param $param");

      throw error;
    });
  }
}
