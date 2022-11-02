import 'package:flutter/cupertino.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:polygonid_flutter_sdk/sdk/proof_generation.dart';

import 'credential_wallet.dart';
import 'iden3comm.dart';
import 'identity_wallet.dart';

class PolygonIsSdkNotInitializedException implements Exception {
  String message;

  PolygonIsSdkNotInitializedException(this.message);
}

class PolygonIdSdk {
  static PolygonIdSdk? _ref;

  static PolygonIdSdk get I {
    if (_ref == null) {
      throw PolygonIsSdkNotInitializedException(
          "The PolygonID SDK has not been initialized,"
          "please call and await PolygonIdSDK.init()");
    }

    return _ref!;
  }

  static Future<void> init() async {
    // As [PolygonIdSdk] uses path_provider plugin, we need to ensure the
    // platform is initialized
    WidgetsFlutterBinding.ensureInitialized();

    // Init injection
    configureInjection();
    await getItSdk.allReady();

    // SDK singleton
    _ref = PolygonIdSdk._();
    _ref!.identity = await getItSdk.getAsync<IdentityWallet>();
    _ref!.credential = await getItSdk.getAsync<CredentialWallet>();
    _ref!.proof = await getItSdk.getAsync<ProofGeneration>();
    _ref!.iden3comm = await getItSdk.getAsync<Iden3comm>();
  }

  late IdentityWallet identity;
  late CredentialWallet credential;
  late ProofGeneration proof;
  late Iden3comm iden3comm;

  PolygonIdSdk._();
}
