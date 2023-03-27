import 'dart:convert';
import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_sd_proof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_proof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/jwz/jwz.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/jwz/jwz_header.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/jwz/jwz_proof.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/proof_entity.dart';

import 'common_mocks.dart';
import 'identity_mocks.dart';

class ProofMocks {
  /// [JWZHeader]
  static String jwzHeaderJson = '''
  {
      "alg": "groth16",
      "circuitId": "authV2",
      "crit": [
          "circuitId"
      ],
      "typ": "application/iden3-zkp-json"
  }
  ''';

  static JWZHeader jwzHeader = JWZHeader.fromJson(jsonDecode(jwzHeaderJson));

  static JWZPayload jwzPayload = JWZPayload(payload: CommonMocks.message);

  /// [JWZProof]
  static String jwzProofJson = '''
  {
    "proof": {
      "pi_a": [
        "12972257478055385287254365242929501313320558748939011660089608743099745111180",
        "21622795818283390802665504767647060461631890183525796753414450241606249570803",
        "1"
      ],
      "pi_b": [
        [
          "12847099681483620244891896889509565905200847639156662566646831644425587767605",
          "7726906658874355928566136582233753422308699830282128425801792100522740842714"
        ],
        [
          "6980467906257014147239154441798190038380315305036926368340008520828455606752",
          "2230249755933402645582750376178300456263004874069787222631240999642444874805"
        ],
        [
          "1",
          "0"
        ]
      ],
      "pi_c": [
        "16986087905048485488743861514238967021136225770235326941460938993915565121755",
        "6238325077558487082209623595523126622748360999246019878388111583106516338436",
        "1"
      ],
      "protocol": "groth16",
      "curve": "bn128"
    },
    "pub_signals": [
      "17316009529728255179407732231309441587133332082639649894788962814402285838612",
      "4219394255904646201524967826472004258359338691812127250829480128630763541992",
      "35420013747224963877199162246728707260324950256512116597756573594137329664"
    ]
  }
  ''';

  /// [JWZVPProof]
  static String jwzVpProofJson = '''
  {
    "verifiableCredential": {
        "documentType": 99,
        "@type": "KYCAgeCredential"
    },
    "@type": "VerifiablePresentation",
    "@context": [
         "https://www.w3.org/2018/credentials/v1",
         "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v3.json-ld"
    ]
  }
  ''';

  static JWZProof jwzProof = JWZProof.fromJson(jsonDecode(jwzProofJson));

  static JWZEntity jwz =
      JWZEntity(header: jwzHeader, payload: jwzPayload, proof: jwzProof);

  static JWZVPProof vp = JWZVPProof.fromJson(jsonDecode(jwzVpProofJson));

  static String encodedJWZ =
      'eyJhbGciOiJncm90aDE2IiwiY2lyY3VpdElkIjoiYXV0aFYyIiwiY3JpdCI6WyJjaXJjdWl0SWQiXSwidHlwIjoiYXBwbGljYXRpb24vaWRlbjMtemtwLWpzb24ifQ.dGhlTWVzc2FnZQ.eyJwcm9vZiI6eyJwaV9hIjpbIjEyOTcyMjU3NDc4MDU1Mzg1Mjg3MjU0MzY1MjQyOTI5NTAxMzEzMzIwNTU4NzQ4OTM5MDExNjYwMDg5NjA4NzQzMDk5NzQ1MTExMTgwIiwiMjE2MjI3OTU4MTgyODMzOTA4MDI2NjU1MDQ3Njc2NDcwNjA0NjE2MzE4OTAxODM1MjU3OTY3NTM0MTQ0NTAyNDE2MDYyNDk1NzA4MDMiLCIxIl0sInBpX2IiOltbIjEyODQ3MDk5NjgxNDgzNjIwMjQ0ODkxODk2ODg5NTA5NTY1OTA1MjAwODQ3NjM5MTU2NjYyNTY2NjQ2ODMxNjQ0NDI1NTg3NzY3NjA1IiwiNzcyNjkwNjY1ODg3NDM1NTkyODU2NjEzNjU4MjIzMzc1MzQyMjMwODY5OTgzMDI4MjEyODQyNTgwMTc5MjEwMDUyMjc0MDg0MjcxNCJdLFsiNjk4MDQ2NzkwNjI1NzAxNDE0NzIzOTE1NDQ0MTc5ODE5MDAzODM4MDMxNTMwNTAzNjkyNjM2ODM0MDAwODUyMDgyODQ1NTYwNjc1MiIsIjIyMzAyNDk3NTU5MzM0MDI2NDU1ODI3NTAzNzYxNzgzMDA0NTYyNjMwMDQ4NzQwNjk3ODcyMjI2MzEyNDA5OTk2NDI0NDQ4NzQ4MDUiXSxbIjEiLCIwIl1dLCJwaV9jIjpbIjE2OTg2MDg3OTA1MDQ4NDg1NDg4NzQzODYxNTE0MjM4OTY3MDIxMTM2MjI1NzcwMjM1MzI2OTQxNDYwOTM4OTkzOTE1NTY1MTIxNzU1IiwiNjIzODMyNTA3NzU1ODQ4NzA4MjIwOTYyMzU5NTUyMzEyNjYyMjc0ODM2MDk5OTI0NjAxOTg3ODM4ODExMTU4MzEwNjUxNjMzODQzNiIsIjEiXSwicHJvdG9jb2wiOiJncm90aDE2IiwiY3VydmUiOiJibjEyOCJ9LCJwdWJfc2lnbmFscyI6WyIxNzMxNjAwOTUyOTcyODI1NTE3OTQwNzczMjIzMTMwOTQ0MTU4NzEzMzMzMjA4MjYzOTY0OTg5NDc4ODk2MjgxNDQwMjI4NTgzODYxMiIsIjQyMTkzOTQyNTU5MDQ2NDYyMDE1MjQ5Njc4MjY0NzIwMDQyNTgzNTkzMzg2OTE4MTIxMjcyNTA4Mjk0ODAxMjg2MzA3NjM1NDE5OTIiLCIzNTQyMDAxMzc0NzIyNDk2Mzg3NzE5OTE2MjI0NjcyODcwNzI2MDMyNDk1MDI1NjUxMjExNjU5Nzc1NjU3MzU5NDEzNzMyOTY2NCJdfQ';

  /// [CircuitDataEntity]
  static Uint8List datFile = Uint8List(32);
  static Uint8List zKeyFile = Uint8List(32);
  static CircuitDataEntity circuitData =
      CircuitDataEntity(CommonMocks.circuitId, datFile, zKeyFile);

  static ProofEntity proof = ProofEntity(
      existence: true, siblings: [IdentityMocks.hash, IdentityMocks.hash]);

  static GistProofEntity gistProof =
      GistProofEntity(root: CommonMocks.message, proof: proof);
}
