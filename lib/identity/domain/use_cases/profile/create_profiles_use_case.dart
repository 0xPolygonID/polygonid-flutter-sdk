import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_public_keys_use_case.dart';

import '../../../../common/domain/domain_logger.dart';
import '../../../../common/domain/use_case.dart';
import '../../repositories/identity_repository.dart';
import '../get_did_identifier_use_case.dart';

class CreateProfilesParam {
  final String privateKey;
  final List<int> profiles;

  CreateProfilesParam({required this.privateKey, this.profiles = const []});
}

class CreateProfilesUseCase
    extends FutureUseCase<CreateProfilesParam, Map<int, String>> {
  final GetPublicKeysUseCase _getPublicKeysUseCase;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;

  CreateProfilesUseCase(
    this._getPublicKeysUseCase,
    this._getCurrentEnvDidIdentifierUseCase,
  );

  @override
  Future<Map<int, String>> execute({required CreateProfilesParam param}) async {
    return Future.wait([
      _getPublicKeysUseCase.execute(param: param.privateKey),
      _getCurrentEnvDidIdentifierUseCase.execute(
          param: GetCurrentEnvDidIdentifierParam(privateKey: param.privateKey))
    ], eagerError: true)
        .then((values) async {
      String didIdentifier = values[1] as String;
      List<String> publicKey = values[0] as List<String>;
      Map<int, String> profiles = {0: didIdentifier};

      for (int profile in param.profiles) {
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
