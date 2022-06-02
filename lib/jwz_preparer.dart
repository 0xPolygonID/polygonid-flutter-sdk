import 'dart:typed_data';

import 'package:privadoid_sdk/privadoid_wallet.dart';
import 'package:privadoid_sdk/utils/uint8_list_utils.dart';
import 'package:web3dart/crypto.dart';

import 'jwz_token.dart';
import 'libs/iden3corelib.dart';

class JWZPreparer extends JWZInputPreparer {
  static Iden3CoreLib get _iden3coreLib {
    return Iden3CoreLib();
  }

  String authClaim;
  PrivadoIdWallet wallet;

  JWZPreparer({required this.wallet, required this.authClaim});

  @override
  Uint8List prepare(Uint8List hash, String circuitID) {
    String queryInputs = "";
    String challenge = bytesToInt(hash).toString();
    String signatureString = wallet.signMessage(challenge);
    if (circuitID == "auth") {
      queryInputs = _iden3coreLib.prepareAuthInputs(challenge, authClaim,
          wallet.publicKey[0], wallet.publicKey[1], signatureString);
    } /* else if (circuitID == "credentialAtomicQueryMTP") {
      queryInputs = _iden3coreLib.prepareAtomicQueryMTPInputs(
          challenge,
          pubX,
          pubY,
          signatureString,
          credential.credential!,
          json.encode(credential.credential!.toJson()),
          schema,
          claimType,
          key,
          value,
          operator,
          revocationStatus);
    } else if (circuitID == "credentialAtomicQuerySig") {
      queryInputs = _iden3coreLib.prepareAtomicQuerySigInputs(
          Uint8ArrayUtils.uint8ListToString(hash),
          pubX,
          pubY,
          signatureString,
          credential.credential!,
          json.encode(credential.credential!.toJson()),
          schema,
          claimType,
          key,
          value,
          operator,
          revocationStatus);
    }*/
    return Uint8ArrayUtils.uint8ListfromString(queryInputs);
  }
}
