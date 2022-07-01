import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/domain/use_cases/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';

class PolygonIdSdk {
  late GetIdentityUseCase _getIdentityUseCase;

  PolygonIdSdk() {
    configureInjection();
    _getIdentityUseCase = getIt<GetIdentityUseCase>();
  }

  /// Get a private key and an identity from a string
  /// If [key] if ommited or null, a random one will be used to create the identity
  Future<Map<String, dynamic>> getIdentity({Uint8List? key}) async {
    return _getIdentityUseCase.execute(param: key);
  }

  // TODO: SDK should be separated in 4 parts:
  // - Identity Wallet
  // - Credential Wallet
  // - Proof Generation Service
  // - iden3comm Service

  // This file should be the entry point for all parts
}
