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
}
