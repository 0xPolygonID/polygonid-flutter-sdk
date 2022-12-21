import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/iden3comm/libs/polygonidcore/pidcore_iden3comm.dart';

class LibPolygonIdCoreIden3commDataSource {
  final PolygonIdCoreIden3comm _polygonIdCoreIden3comm;

  LibPolygonIdCoreIden3commDataSource(
    this._polygonIdCoreIden3comm,
  );

  String getAuthInputs({
    required String did,
    required int profileNonce,
    required List<String> authClaim,
    required Map<String, dynamic> incProof,
    required Map<String, dynamic> nonRevProof,
    required Map<String, dynamic> gistProof,
    required Map<String, dynamic> treeState,
    required String challenge,
    required String signature,
  }) {
    String input = jsonEncode({
      "genesisDID":
          did, //"did:iden3:tT2t3b685r2dKsjo4MioyKeceFT4mQEYfDd69EY5Y",
      "profileNonce": profileNonce.toString(), //"0",
      "authClaim": authClaim,
      /*[
          "304427537360709784173770334266246861770",
          "0",
          "17640206035128972995519606214765283372613874593503528180869261482403155458945",
          "20634138280259599560273310290025659992320584624461316485434108770067472477956",
          "15930428023331155902",
          "0",
          "0",
          "0"
        ],*/
      "authClaimIncMtp": incProof,
      /*{
      "existence": true,
      "siblings": []
    }*/
      "authClaimNonRevMtp": nonRevProof, //{"existence": false, "siblings": []},
      "treeState": treeState,
      /*{
            "state":
                "18656147546666944484453899241916469544090258810192803949522794490493271005313",
            "claimsRoot":
                "9763429684850732628215303952870004997159843236039795272605841029866455670219",
            "revocationRoot": "0",
            "rootOfRoots": "0"
          }*/
      "gistProof": gistProof,
      /*{
    "root": "4924303677736085224554833340748086265406229626627819375177261957522622163007",
    "proof": {
      "existence": false,
      "siblings": [],
      "node_aux": {
        "key": "24846663430375341177084327381366271031641225773947711007341346118923321345",
        "value": "6317996369756476782464660619835940615734517981889733696047139451453239145426"
      }
    }
  },*/
      "signature":
          signature, //"fccc15d7aed2bf4f5d7dbe55c81087970344d13e5d9f348e61965ac364f41d29b366b52bc0820c603877352054833da083f5595c29c881ccd8ee47aa639aa103",
      "challenge": challenge, //"10"
    });

    String output = _polygonIdCoreIden3comm.getAuthInputs(input);

    logger().d("getAuthV2Inputs: $output");
    return output;
  }
}
