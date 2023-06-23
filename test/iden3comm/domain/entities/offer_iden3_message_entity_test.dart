import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/offer_iden3_message_entity.dart';

import '../../../common/iden3comm_mocks.dart';

var json = jsonDecode(Iden3commMocks.offerRequestJson);

void main() {
  group("OfferIden3MessageEntity", () {
    test("fromJson", () {
      var offerRequest = OfferIden3MessageEntity.fromJson(json);
      expect(offerRequest.id, "1");
      expect(offerRequest.typ, "theTyp");
      expect(offerRequest.messageType, Iden3MessageType.credentialOffer);
      expect(offerRequest.thid, "theThid");
      expect(offerRequest.from, "theFrom");
      expect(offerRequest.body.url, Iden3commMocks.offerUrl);
      expect(offerRequest.body.credentials[0].id, "claimId");
      expect(offerRequest.body.credentials[0].description, "claimDescription");
    });
  });
}
