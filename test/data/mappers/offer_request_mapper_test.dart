import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/offer/offer_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/iden3_message_type_data_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/offer_request_mapper.dart';
import 'package:polygonid_flutter_sdk/sdk/mappers/iden3_message_mapper.dart';
import 'package:polygonid_flutter_sdk/sdk/mappers/iden3_message_type_mapper.dart';

String data = '''
{
  "id": "1",
  "typ": "theTyp",
  "type": "https://iden3-communication.io/authorization/1.0/request",
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
final offerRequest = OfferRequest.fromJson(json);

Iden3MessageMapper iden3messageMapper =
    Iden3MessageMapper(Iden3MessageTypeMapper());

//Tested instance
OfferRequestMapper offerRequestMapper =
    OfferRequestMapper(Iden3MessageTypeDataMapper());

void main() {
  group("OfferRequestMapper", () {
    test("mapTo", () {
      var iden3MessageEntity = iden3messageMapper.mapFrom(data);
      var offerRequestMapped = offerRequestMapper.mapTo(iden3MessageEntity);
      expect(offerRequestMapped.id, "1");
      expect(offerRequestMapped.typ, "theTyp");
      expect(offerRequestMapped.type, "https://iden3-communication.io/authorization/1.0/request");
      expect(offerRequestMapped.thid, "theThid");
      expect(offerRequestMapped.from, "theFrom");
      expect(offerRequestMapped.body!.url, "offerUrl");
      expect(offerRequestMapped.body!.credentials![0].id, "credentialsId");
      expect(offerRequestMapped.body!.credentials![0].description,
          "credentialsDescription");
    });
  });
}
