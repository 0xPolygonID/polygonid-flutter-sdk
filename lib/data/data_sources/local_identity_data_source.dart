import 'dart:typed_data';

import 'package:injectable/injectable.dart';

import '../../privadoid_sdk.dart';
import '../../privadoid_wallet.dart';
import '../../utils/hex_utils.dart';

// TODO: move all static code here
@injectable
class LibWrapper {
  Future<Uint8List> generatePrivateKey({Uint8List? privateKey}) {
    return PrivadoIdWallet.createPrivadoIdWallet(privateKey: privateKey)
        .then((wallet) => wallet.privateKey);
  }

  Future<String> generateIdentifier({required String privateKey}) {
    return PrivadoIdSdk.getIdentifier(privateKey);
  }
}

class LocalIdentityDataSource {
  final LibWrapper _libWrapper;

  LocalIdentityDataSource(this._libWrapper);

  Future<String> generatePrivateKey({Uint8List? privateKey}) {
    return _libWrapper
        .generatePrivateKey(privateKey: privateKey)
        .then((privateKey) => HexUtils.bytesToHex(privateKey));
  }

  Future<String> generateIdentifier({required String privateKey}) {
    return _libWrapper.generateIdentifier(privateKey: privateKey);
  }
}
