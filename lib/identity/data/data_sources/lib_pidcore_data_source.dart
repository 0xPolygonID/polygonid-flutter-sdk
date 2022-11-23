import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';

import '../../libs/polygonidcore/polygonidcore.dart';

class LibPolygonIdCoreDataSource {
  final PolygonIdCoreLib _polygonIdCoreLib;

  LibPolygonIdCoreDataSource(
    this._polygonIdCoreLib,
  );

  String calculateGenesisId(String claimsTreeRoot) {
    String input = {
      "claimsTreeRoot": claimsTreeRoot,
      //"8174871235721986756013575194888048894328426483724665491825528183806540196001",
      "blockchain": "polygon",
      "network": "mumbai"
    }.toString();

    String output = _polygonIdCoreLib.calculateGenesisId(input);
    logger().d("calculateGenesisId: $output");
    return output;
  }

  String getAuthInputs() {
    String input = {
      "id": "tT2t3b685r2dKsjo4MioyKeceFT4mQEYfDd69EY5Y",
      "nonce": "0",
      "authClaim": {
        "issuerId": null,
        "claim": [
          "304427537360709784173770334266246861770",
          "0",
          "17640206035128972995519606214765283372613874593503528180869261482403155458945",
          "20634138280259599560273310290025659992320584624461316485434108770067472477956",
          "15930428023331155902",
          "0",
          "0",
          "0"
        ],
        "incProof": {
          "proof": {"existence": true, "siblings": []},
          "treeState": {
            "state":
                "18656147546666944484453899241916469544090258810192803949522794490493271005313",
            "claimsRoot":
                "9763429684850732628215303952870004997159843236039795272605841029866455670219",
            "revocationRoot": "0",
            "rootOfRoots": "0"
          }
        },
        "nonRevProof": {
          "proof": {"existence": false, "siblings": []},
          "treeState": {
            "state":
                "18656147546666944484453899241916469544090258810192803949522794490493271005313",
            "claimsRoot":
                "9763429684850732628215303952870004997159843236039795272605841029866455670219",
            "revocationRoot": "0",
            "rootOfRoots": "0"
          }
        }
      },
      "gistProof": {
        "root":
            "4924303677736085224554833340748086265406229626627819375177261957522622163007",
        "proof": {
          "existence": false,
          "siblings": [],
          "node_aux": {
            "key":
                "24846663430375341177084327381366271031641225773947711007341346118923321345",
            "value":
                "6317996369756476782464660619835940615734517981889733696047139451453239145426"
          }
        }
      },
      "signature":
          "fccc15d7aed2bf4f5d7dbe55c81087970344d13e5d9f348e61965ac364f41d29b366b52bc0820c603877352054833da083f5595c29c881ccd8ee47aa639aa103",
      "challenge": "10"
    }.toString();

    String output = _polygonIdCoreLib.getAuthInputs(input);

    logger().d("getAuthV2Inputs: $output");
    return output;
  }

  /// - schema - schema hash hex string
  /// - nonce - nonce as big int string
  String issueClaim(
      {required String schema,
      required String nonce,
      required String pubX,
      required String pubY}) {
    //String revNonce = "15930428023331155902";
    String input = {
      "schema": schema, //"ca938857241db9451ea329256b9c06e5",
      "nonce": nonce, //"13260572831089785859",
      "indexSlotA": pubX,
      //"15468939102716291673743744296736132867654217747684906302563904432835075522918",
      "indexSlotB": pubY,
      //"10564057289999407626309237453457578977834988122411075958351091519856342060014"
    }.toString();

    String output = _polygonIdCoreLib.createClaim(input);

    logger().d("createClaim: $output");
    return output;
  }
}
