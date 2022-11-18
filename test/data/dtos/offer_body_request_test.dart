import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/offer/offer_body_request.dart';

String data = '''
{
    "url": "offerUrl",
    "credentials": [
      {
        "id": "credentialsId",
        "description": "credentialsDescription"
      }
    ]
}
''';
var json = jsonDecode(data);

void main() {
  group("OfferBodyRequest", () {
    test("fromJson", () {
      var offerBodyRequest = OfferBodyRequest.fromJson(json);
      expect(offerBodyRequest.url, "offerUrl");
      expect(offerBodyRequest.credentials![0].id, "credentialsId");
      expect(offerBodyRequest.credentials![0].description, "credentialsDescription");
    });
    test("toJson", () {
      var offerBodyRequest = OfferBodyRequest.fromJson(json);
      expect(offerBodyRequest.toJson(), json);
    });
  });
}