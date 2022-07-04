import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/privadoid_wallet.dart';

import '../../../libs/iden3corelib.dart';

@injectable
class WalletLibWrapper {
  Future<PrivadoIdWallet> createWallet({Uint8List? privateKey}) {
    try {
      return PrivadoIdWallet.createPrivadoIdWallet(privateKey: privateKey);
    } catch (e) {
      return Future.error(e);
    }
  }
}

class LocalIdentityDataSource {
  final Iden3CoreLib _iden3coreLib;
  final WalletLibWrapper _walletLibWrapper;

  LocalIdentityDataSource(this._iden3coreLib, this._walletLibWrapper);

  Future<String> getIdentifier({required String pubX, required String pubY}) {
    try {
      Map<String, String> map = _iden3coreLib.generateIdentity(pubX, pubY);

      return Future.value(map['id']);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> getAuthclaim({required String pubX, required String pubY}) {
    try {
      String authClaim = _iden3coreLib.getAuthClaim(pubX, pubY);

      return Future.value(authClaim);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<PrivadoIdWallet> createWallet({Uint8List? privateKey}) {
    return _walletLibWrapper.createWallet(privateKey: privateKey);
  }
}
