import 'package:polygonid_flutter_sdk/privadoid_sdk.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';

import 'identity_wallet.dart';

class PolygonIdSdk {
  late IdentityWallet identity;

  PolygonIdSdk() {
    configureInjection();
    identity = getItSdk<IdentityWallet>();
  }

  /// This method is here only to bootstrap the injection.
  /// It should be removed when the Statics are gone, see [PrivadoIdSdk].
  void init() {}

// TODO: SDK should be separated in 4 parts:
// - Identity Wallet
// - Credential Wallet
// - Proof Generation Service
// - iden3comm Service

// This file should be the entry point for all parts
}
