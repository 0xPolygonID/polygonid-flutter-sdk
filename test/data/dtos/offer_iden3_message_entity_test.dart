import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/offer/offer_iden3_message_entity.dart';

import '../../common/iden3com_mocks.dart';

var json = jsonDecode(Iden3commMocks.offerRequestJson);

void main() {
  group("OfferIden3MessageEntity", () {
    test("fromJson", () {
      var offerRequest = OfferIden3MessageEntity.fromJson(json);
      expect(offerRequest.id, "1");
      expect(offerRequest.typ, "theTyp");
      expect(offerRequest.type, Iden3MessageType.offer);
      expect(offerRequest.thid, "theThid");
      expect(offerRequest.from, "theFrom");
      expect(offerRequest.body.url, "offerUrl");
      expect(offerRequest.body.credentials![0].id, "credentialsId");
      expect(offerRequest.body.credentials![0].description,
          "credentialsDescription");
    });
  });
}
