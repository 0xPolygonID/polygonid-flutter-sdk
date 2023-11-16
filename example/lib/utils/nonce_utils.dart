import 'dart:math';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';

class NonceUtils {
  static const PROFILE_NONCE_KEY = "profileNonce";

  final PolygonIdSdk _polygonIdSdk;

  NonceUtils(this._polygonIdSdk);

  Future<BigInt> getPrivateProfileNonce({
    required String did,
    required String privateKey,
    required String from,
  }) async {
    final nonceLookup =
        await lookupNonce(did: did, privateKey: privateKey, from: from);

    if (nonceLookup != null) {
      logger().i("Found nonce for $from: $nonceLookup");
      return nonceLookup;
    }

    return setupNewNonce(did: did, privateKey: privateKey, from: from);
  }

  BigInt randomNonce() {
    final random = Random.secure();
    const int size = 248;
    BigInt value = BigInt.from(0);
    for (var i = 0; i < size; i++) {
      value = value << 1;
      if (random.nextBool()) {
        value = value | BigInt.from(1);
      }
    }
    if (value == BigInt.zero) {
      return randomNonce();
    }
    return value;
  }

  Future<BigInt> setupNewNonce({
    required String did,
    required String privateKey,
    required String from,
  }) async {
    BigInt nonce = randomNonce();
    logger().i("Generating new nonce for $from: $nonce");

    await _polygonIdSdk.identity.addProfile(
        genesisDid: did, privateKey: privateKey, profileNonce: nonce);

    Map<String, dynamic> info = {
      PROFILE_NONCE_KEY: nonce.toString(),
    };
    await _polygonIdSdk.iden3comm.addDidProfileInfo(
        did: did, privateKey: privateKey, interactedWithDid: from, info: info);

    return nonce;
  }

  Future<BigInt?> lookupNonce({
    required String did,
    required String privateKey,
    required String from,
  }) async {
    Map readInfo = await _polygonIdSdk.iden3comm.getDidProfileInfo(
        did: did, privateKey: privateKey, interactedWithDid: from);
    logger().i("info from $from: $readInfo");

    return (readInfo[PROFILE_NONCE_KEY] != null)
        ? BigInt.parse(readInfo[PROFILE_NONCE_KEY])
        : null;
  }

  Future<void> removeProfileInfo({
    required String did,
    required String privateKey,
    required String from,
  }) async {
    Map<BigInt, String> profilesToDelete = await _polygonIdSdk.identity
        .getProfiles(genesisDid: did, privateKey: privateKey);
    for (var nonce in profilesToDelete.keys) {
      if (nonce != BigInt.zero) {
        await _polygonIdSdk.identity.removeProfile(
            genesisDid: did, privateKey: privateKey, profileNonce: nonce);
      }
    }

    await _polygonIdSdk.iden3comm.removeDidProfileInfo(
        did: did, privateKey: privateKey, interactedWithDid: from);
  }
}
