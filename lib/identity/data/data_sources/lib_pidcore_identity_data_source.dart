import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';

import '../../libs/polygonidcore/pidcore_identity.dart';

class LibPolygonIdCoreIdentityDataSource {
  final PolygonIdCoreIdentity _polygonIdCoreIdentity;

  LibPolygonIdCoreIdentityDataSource(
    this._polygonIdCoreIdentity,
  );

  String calculateGenesisId(
      String claimsTreeRoot, String blockchain, String network) {
    String input = jsonEncode({
      "claimsTreeRoot": claimsTreeRoot,
      //"8174871235721986756013575194888048894328426483724665491825528183806540196001",
      "blockchain": blockchain, //"polygon",
      "network": network, //"mumbai"
    });

    String output = _polygonIdCoreIdentity.calculateGenesisId(input);
    logger().d("calculateGenesisId: $output");
    return output;
  }

  String calculateProfileId(String genesisDid, int profileNonce) {
    String input = jsonEncode({
      "genesisDID":
          genesisDid, //"did:iden3:polygon:mumbai:wwc17vYCJV4iqVRQu9U99CpG5KtHFbXRxE16fH3Kp",
      "nonce": profileNonce.toString(), // "10"
    });

    String output = _polygonIdCoreIdentity.calculateProfileId(input);
    logger().d("calculateProfileId: $output");
    // {"profileDID":"did:iden3:polygon:mumbai:x42d3rxWAC6mGS8AmCVWFUz7Tnndm2QCy1KzksG2R"}
    return output;
  }

  String genesisIdToBigInt(String genesisId) {
    String output = _polygonIdCoreIdentity.convertIdToBigInt(genesisId);
    logger().d("genesisIdToBigInt: $output");
    return output;
  }
}
