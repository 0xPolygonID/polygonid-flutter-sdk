import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/offer/offer_request.dart';

String data = '''
{
  "id": "1",
  "typ": "theTyp",
  "type": "theType",
  "thid": "theThid",
  "from": "theFrom",
  "body": {
    "url": "offerUrl",
    "credentials": [
      {
        "id": "credentialsId",
        "description": "credentialsDescription"
      }
    ]
  }
}
''';
var json = jsonDecode(data);

void main() {
  group("OfferRequest", () {
    test("fromJson", () {
      var offerRequest = OfferRequest.fromJson(json);
      expect(offerRequest.id, "1");
      expect(offerRequest.typ, "theTyp");
      expect(offerRequest.type, "theType");
      expect(offerRequest.thid, "theThid");
      expect(offerRequest.from, "theFrom");
      expect(offerRequest.body!.url, "offerUrl");
      expect(offerRequest.body!.credentials![0].id, "credentialsId");
      expect(offerRequest.body!.credentials![0].description,
          "credentialsDescription");
    });
    test("toJson", () {
      var offerRequest = OfferRequest.fromJson(json);
      expect(offerRequest.toJson(), json);
    });
  });
}
