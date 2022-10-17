import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_info_dto.dart';

// Data
String data = '''{
    "id": "c9790af7-0edc-4e7c-9e4e-ed8554f4d17b",
"@context": [
"https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/iden3credential.json-ld",
"https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld"
],
"@type": [
"Iden3Credential"
],
"expiration": "2361-03-21T21:14:48+02:00",
"updatable": false,
"version": 0,
"rev_nonce": 3477266740,
"credentialSubject": {
"birthday": 19960424,
"documentType": 1,
"id": "11A9y2rQjVJ3CxNoPVVSwLaRRTyYpBVkcLwQcfFZA8",
"type": "KYCAgeCredential"
},
"credentialStatus": {
"id": "http://localhost:8001/api/v1/identities/112heu3YTzXmiWJ35B1ZBe2EEbWmQeiLsdUnid9871/claims/revocation/status/3477266740",
"type": "SparseMerkleTreeProof"
},
"subject_position": "index",
"credentialSchema": {
"@id": "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
"type": "KYCAgeCredential"
},
"proof": [
{
"@type": "BJJSignature2021",
"issuer_data": {
"id": "112heu3YTzXmiWJ35B1ZBe2EEbWmQeiLsdUnid9871",
"state": {
"claims_tree_root": "756d1a748c27b63eba034eed4de55e4ed52b755e383af67d1acae724189f2c06",
"value": "4f715c603f2577b9d1aa8849c5ae2b0ee913ffe05a34211899b6008e77696a22"
},
"auth_claim": [
"304427537360709784173770334266246861770",
"0",
"9821890207136119642006142707914644474873951991925933535773950937966349248076",
"14645503414622222463389491856667497833545832230909855629728123986050067616432",
"0",
"0",
"0",
"0"
],
"mtp": {
"existence": true,
"siblings": []
},
"revocation_status": "http://localhost:8001/api/v1/identities/112heu3YTzXmiWJ35B1ZBe2EEbWmQeiLsdUnid9871/claims/revocation/status/0"
},
"signature": "58d54fa02f5958e581ea4748b8ac783556b00567fc35e60b01336c9101a86ca3d83847a363e0216fa72c208dab64fe88649269a9df4a270500768934ff462e01"
}
]
}''';
var json = jsonDecode(data);

// Dependencies

// Tested instance

void main() {
  group("Credential DTO", () {
    setUp(() {});

    test("Serializable", () {
      ClaimInfoDTO dto = ClaimInfoDTO.fromJson(json);
      dto.toJson();
    });
  });
}
