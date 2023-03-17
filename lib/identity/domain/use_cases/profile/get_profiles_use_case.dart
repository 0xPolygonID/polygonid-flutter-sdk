import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

class GetProfilesUseCase extends FutureUseCase<String, Map<int, String>> {
  final GetIdentityUseCase _getIdentityUseCase;

  GetProfilesUseCase(this._getIdentityUseCase);

  @override
  Future<Map<int, String>> execute({required String param}) {
    return _getIdentityUseCase
        .execute(param: GetIdentityParam(genesisDid: param))
        .then((identity) => identity.profiles)
        .then((profiles) {
      logger().i("[GetProfilesUseCase] Profiles for $param are: $profiles");

      return profiles;
    }).catchError((error) {
      logger().e("[GetProfilesUseCase] Error: $error");

      throw error;
    });
  }
}
