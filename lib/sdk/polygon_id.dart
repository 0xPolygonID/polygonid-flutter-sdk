import 'package:privadoid_sdk/domain/common/tuples.dart';
import 'package:privadoid_sdk/domain/use_cases/get_identity_use_case.dart';

class PolygonID {
  final GetIdentityUseCase _getIdentityUseCase;

  PolygonID(this._getIdentityUseCase);

  Future<Pair<String, String>> getIdentity(String? seedPhrase) async {
    return _getIdentityUseCase.execute(param: seedPhrase);
  }
}
