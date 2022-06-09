import 'dart:typed_data';

import 'package:privadoid_sdk/privadoid_wallet.dart';
import 'package:privadoid_sdk/utils/uint8_list_utils.dart';
import 'package:web3dart/crypto.dart';

import '../libs/iden3corelib.dart';
import 'jwz_token.dart';

class JWZPreparer extends JWZInputPreparer {
  // TODO: should be injected
  late Iden3CoreLib _iden3coreLib;

  String authClaim;
  PrivadoIdWallet wallet;

  JWZPreparer(
      {required this.wallet, required this.authClaim, Iden3CoreLib? coreLib}) {
    _iden3coreLib = coreLib ?? Iden3CoreLib();
  }

  @override
  Uint8List prepare(Uint8List hash, String circuitID) {
    String queryInputs = "";
    String challenge = bytesToInt(hash).toString();
    String signatureString = wallet.signMessage(challenge);
    if (circuitID == "auth") {
      queryInputs = _iden3coreLib.prepareAuthInputs(challenge, authClaim,
          wallet.publicKey[0], wallet.publicKey[1], signatureString);
    }
    return Uint8ArrayUtils.uint8ListfromString(queryInputs);
  }
}
