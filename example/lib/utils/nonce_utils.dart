import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';

class NonceUtils {
  static const PROFILE_NONCE_KEY = "profileNonce";

  final PolygonIdSdk _polygonIdSdk;

  NonceUtils(this._polygonIdSdk);

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
}
