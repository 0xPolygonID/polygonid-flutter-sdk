import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:polygonid_flutter_sdk/privadoid_wallet.dart';
import 'package:polygonid_flutter_sdk/sdk/identity_wallet.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk/utils/uint8_list_utils.dart';
import 'package:web3dart/crypto.dart';

import '../libs/iden3corelib.dart';
import 'jwz_token.dart';

class AuthInputsIsolateParam {
  final String challenge;
  final String authClaim;
  final String pubX;
  final String pubY;
  final String signature;

  AuthInputsIsolateParam(
      this.challenge, this.authClaim, this.pubX, this.pubY, this.signature);
}

class JWZPreparer extends JWZInputPreparer {
  late IdentityWallet _identityWallet;

  final String privateKey;
  String authClaim;
  PrivadoIdWallet wallet;

  JWZPreparer(
      {required this.privateKey,
      required this.wallet,
      required this.authClaim}) {
    _identityWallet = PolygonIdSdk.I.identity;
  }

  @override
  Future<Uint8List> prepare(Uint8List hash, String circuitID) async {
    String queryInputs = "";
    String challenge = bytesToInt(hash).toString();
    String signatureString =
        await _identityWallet.sign(privateKey: privateKey, message: challenge);

    if (circuitID == "auth") {
      queryInputs = await compute(
          _computeAuthInputs,
          AuthInputsIsolateParam(challenge, authClaim, wallet.publicKey[0],
              wallet.publicKey[1], signatureString));
    }

    return Uint8ArrayUtils.uint8ListfromString(queryInputs);
  }

  Future<String> _computeAuthInputs(AuthInputsIsolateParam param) {
    final iden3coreLib = Iden3CoreLib();

    return Future.value(iden3coreLib.prepareAuthInputs(param.challenge,
        param.authClaim, param.pubX, param.pubY, param.signature));
  }
}
