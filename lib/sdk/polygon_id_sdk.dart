import 'package:privadoid_sdk/domain/common/tuples.dart';
import 'package:privadoid_sdk/domain/use_cases/get_identity_use_case.dart';
import 'package:privadoid_sdk/sdk/di/injector.dart';

class PolygonIdSdk {
  late GetIdentityUseCase _getIdentityUseCase;

  PolygonIdSdk() {
    configureInjection();
    _getIdentityUseCase = getIt<GetIdentityUseCase>();
  }

  /// Get a private key and an identity from a string
  /// If [key] if ommited or null, a random one will be used to create the identity
  Future<Pair<String, String>> getIdentity({String? key}) async {
    return _getIdentityUseCase.execute(param: key);
  }
}
