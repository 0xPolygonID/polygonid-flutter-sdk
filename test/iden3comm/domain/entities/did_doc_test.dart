import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document.dart';

String data = '''
{
  "@context": [
    "https://www.w3.org/ns/did/v1"
  ],
  "id": "did:iden3:polygon:mumbai:119tqceWdRd2F6WnAyVuFQRFjK3WUXq2LorSPyG9LJ",
  "service": [
    {
      "id": "did:iden3:polygon:mumbai:119tqceWdRd2F6WnAyVuFQRFjK3WUXq2LorSPyG9LJ#push",
      "type": "push-notification",
      "serviceEndpoint": "https://push.polygonid.me/api/v1",
      "metadata": {
        "devices": [
          {
            "ciphertext": "sIyhw8MsRzFTMX",
            "alg": "RSA-OAEP-512"
          }
        ]
      }
    }
  ]
}
''';

var json = jsonDecode(data);

void main() {
  group('AuthBodyDidDocResponse', () {
    test('fromJson', () {
      var authBodyDidDocResponse = DIDDocument.fromJson(json);
      expect(authBodyDidDocResponse.id,
          'did:iden3:polygon:mumbai:119tqceWdRd2F6WnAyVuFQRFjK3WUXq2LorSPyG9LJ');
      expect(authBodyDidDocResponse.service?[0].id,
          'did:iden3:polygon:mumbai:119tqceWdRd2F6WnAyVuFQRFjK3WUXq2LorSPyG9LJ#push');
      expect(authBodyDidDocResponse.service?[0].type, 'push-notification');
      expect(authBodyDidDocResponse.service?[0].serviceEndpoint,
          'https://push.polygonid.me/api/v1');
      expect(
          authBodyDidDocResponse.service?[0].metadata?.devices?[0].ciphertext,
          'sIyhw8MsRzFTMX');
      expect(authBodyDidDocResponse.service?[0].metadata?.devices?[0].alg,
          'RSA-OAEP-512');
    });
    test(
      'AuthBodyDidDocResponse.toJson',
      () {
        var authBodyDidDocResponse = DIDDocument.fromJson(json);
        expect(authBodyDidDocResponse.toJson(), json);
      },
    );
  });
}
