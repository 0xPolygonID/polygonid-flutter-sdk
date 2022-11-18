import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/auth_body_request.dart';

String data = '''
{
  "reason": "test flow",
  "message": "",
  "callbackUrl": "https://verifier.polygonid.me/api/callback?sessionId=748916",
  "scope": [
    {
      "id": 1,
      "circuit_id": "credentialAtomicQuerySig",
      "optional": false,
      "rules": {
        "audience": "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b",
        "challenge": 748916,
        "query": {
          "allowedIssuers": [
            "*"
          ],
          "challenge": 123456,
          "schema": {
            "type": "KYCAgeCredential",
            "url": "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld"
          },
          "req": {
            "birthday": {
              "\$lt": 20000101
            }
          }
        }
      }
    }
  ],
  "url": "theUrl",
  "credentials": [
    {
      "id": "27887",
      "description": "Authenticating with iden3"
    }
  ]
}
''';
var json = jsonDecode(data);

void main() {
  group("AuthBodyRequest", () {
    test("fromJson", () {
      var authBodyRequest = AuthBodyRequest.fromJson(json);
      expect(authBodyRequest.reason, "test flow");
      expect(authBodyRequest.message, "");
      expect(authBodyRequest.callbackUrl,
          "https://verifier.polygonid.me/api/callback?sessionId=748916");
      expect(authBodyRequest.scope![0].id, 1);
      expect(authBodyRequest.scope![0].circuit_id, "credentialAtomicQuerySig");
      expect(authBodyRequest.scope![0].rules?.query?.allowedIssuers![0], "*");
      expect(authBodyRequest.scope![0].rules?.query?.schema?.type,
          "KYCAgeCredential");
      expect(authBodyRequest.scope![0].rules?.query?.schema?.url,
          "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld");
      expect(authBodyRequest.url, "theUrl");
      expect(authBodyRequest.credentials![0].id, "27887");
      expect(authBodyRequest.credentials![0].description,
          "Authenticating with iden3");
    });
    test("toJson", () {
      var authBodyRequest = AuthBodyRequest.fromJson(json);
      expect(authBodyRequest.toJson(), json);
    });
  });
}
