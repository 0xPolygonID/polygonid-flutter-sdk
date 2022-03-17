import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import "package:hex/hex.dart";
import 'package:privadoid_sdk/http.dart';
import 'package:privadoid_sdk/model/revocation_status.dart';
import 'package:privadoid_sdk/privadoid_wallet.dart';
import 'package:privadoid_sdk/utils/hex_utils.dart';
import 'package:privadoid_sdk/utils/uint8_list_utils.dart';

import 'libs/iden3corelib.dart';
import 'model/credential_data.dart';

class PrivadoIdSdk {
  static const MethodChannel _channel = MethodChannel('privadoid_sdk');
  static Iden3CoreLib get _iden3coreLib {
    return Iden3CoreLib();
  }

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String?> createNewIdentity({Uint8List? privateKey}) async {
    final PrivadoIdWallet wallet =
        await PrivadoIdWallet.createPrivadoIdWallet(privateKey: privateKey);
    return HexUtils.bytesToHex(wallet.privateKey);
  }

  static Future<String?> getGenesisId(String privateKey) async {
    final PrivadoIdWallet wallet = await PrivadoIdWallet.createPrivadoIdWallet(
        privateKey: HexUtils.hexToBytes(privateKey));

    final String? mtRoot = _iden3coreLib.getMerkleTreeRoot(
        wallet.publicKey[0], wallet.publicKey[1]);
    if (kDebugMode) {
      print("mtRoot: " + mtRoot!);
    }
    Uint8List bufMtRoot = Uint8List.fromList(HEX.decode(mtRoot!));
    BigInt mtRootBigInt = Uint8ArrayUtils.beBuff2int(
        Uint8List.fromList(bufMtRoot.reversed.toList()));
    if (kDebugMode) {
      print("mtRootBigInt: " + mtRootBigInt.toString());
    }

    String state = wallet.hashMessage(mtRootBigInt.toString(),
        BigInt.zero.toString(), BigInt.zero.toString());
    if (kDebugMode) {
      print("state: " + state);
    }
    Uint8List bufState = Uint8List.fromList(HEX.decode(state));
    BigInt stateBigInt = Uint8ArrayUtils.beBuff2int(bufState);
    if (kDebugMode) {
      print("stateBigInt: " + stateBigInt.toString());
    }

    final String? genesisId = _iden3coreLib.getGenesisId(state);
    if (kDebugMode) {
      print("GenesisId: " + genesisId!);
    }

    return genesisId;
  }

  static Future<String?> getIdentifier(String privateKey) async {
    final PrivadoIdWallet wallet = await PrivadoIdWallet.createPrivadoIdWallet(
        privateKey: HexUtils.hexToBytes(privateKey));

    final String? mtRoot = _iden3coreLib.getMerkleTreeRoot(
        wallet.publicKey[0], wallet.publicKey[1]);
    if (kDebugMode) {
      print("mtRoot: " + mtRoot!);
    }
    Uint8List bufMtRoot = Uint8List.fromList(HEX.decode(mtRoot!));
    BigInt mtRootBigInt = Uint8ArrayUtils.beBuff2int(
        Uint8List.fromList(bufMtRoot.reversed.toList()));
    if (kDebugMode) {
      print("mtRootBigInt: " + mtRootBigInt.toString());
    }

    String state = wallet.hashMessage(mtRootBigInt.toString(),
        BigInt.zero.toString(), BigInt.zero.toString());
    if (kDebugMode) {
      print("state: " + state);
    }
    Uint8List bufState = Uint8List.fromList(HEX.decode(state));
    BigInt stateBigInt = Uint8ArrayUtils.beBuff2int(bufState);
    if (kDebugMode) {
      print("stateBigInt: " + stateBigInt.toString());
    }

    final String? genesisId = _iden3coreLib.getGenesisId(state);
    if (kDebugMode) {
      print("GenesisId: " + genesisId!);
    }

    return genesisId;
  }

  static Future<String?> getAuthClaim(String privateKey) async {
    final PrivadoIdWallet wallet = await PrivadoIdWallet.createPrivadoIdWallet(
        privateKey: HexUtils.hexToBytes(privateKey));

    String authClaim =
        _iden3coreLib.getAuthClaim(wallet.publicKey[0], wallet.publicKey[1]);
    if (kDebugMode) {
      print("authClaim: " + authClaim);
    }
    return authClaim;
  }

  static Future<String?> prepareAuthInputs(
      String challenge, String privateKey, String authClaim) async {
    final PrivadoIdWallet wallet = await PrivadoIdWallet.createPrivadoIdWallet(
        privateKey: HexUtils.hexToBytes(privateKey));
    String signatureString = wallet.signMessage(challenge);

    String? genesisId = await getIdentifier(privateKey);
    print("GENESIS ID :" + genesisId!);

    var authInputs = _iden3coreLib.prepareAuthInputs(challenge, authClaim,
        wallet.publicKey[0], wallet.publicKey[1], signatureString);
    return authInputs;
  }

  static Future<String?> prepareAtomicQueryInputs(
      String challenge,
      String privateKey,
      CredentialData credential,
      String claimType,
      String key,
      int value,
      int operator,
      String revStatusUrl) async {
    final PrivadoIdWallet wallet = await PrivadoIdWallet.createPrivadoIdWallet(
        privateKey: HexUtils.hexToBytes(privateKey));

    String signatureString = wallet.signMessage(challenge);

    // schema
    var uri = Uri.parse(credential.credential!.credentialSchema!.id!);
    var res = await get(uri.authority, uri.path);
    String schema = (res.body);

    // revocation status
    res = await get(revStatusUrl, "");
    String revStatus = (res.body);
    final RevocationStatus revocationStatus =
        RevocationStatus.fromJson(json.decode(revStatus));

    var queryInputs = _iden3coreLib.prepareAtomicQueryInputs(
        challenge,
        wallet.publicKey[0],
        wallet.publicKey[1],
        signatureString,
        credential.credential!,
        json.encode(credential.credential!.toJson()),
        schema,
        claimType,
        key,
        value,
        operator,
        revocationStatus);
    return queryInputs;
  }
}
