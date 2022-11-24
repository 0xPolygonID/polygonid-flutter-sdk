import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/offer/offer_body_request.dart';

import '../../common/iden3com_mocks.dart';

var json = jsonDecode(Iden3commMocks.offerRequestBodyJson);

void main() {
  group("OfferBodyRequest", () {
    test("fromJson", () {
      var offerBodyRequest = OfferBodyRequest.fromJson(json);
      expect(offerBodyRequest.url, "offerUrl");
      expect(offerBodyRequest.credentials![0].id, "credentialsId");
      expect(offerBodyRequest.credentials![0].description,
          "credentialsDescription");
    });
    test("toJson", () {
      var offerBodyRequest = OfferBodyRequest.fromJson(json);
      expect(offerBodyRequest.toJson(), json);
    });
  });
}
