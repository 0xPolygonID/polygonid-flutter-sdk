import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/fetch/fetch_body_request.dart';

import '../../../common/iden3comm_mocks.dart';

var json = jsonDecode(Iden3commMocks.fetchRequestBodyJson);

void main() {
  group("FetchBodyRequest", () {
    test("fromJson", () {
      var fetchBodyRequest = FetchBodyRequest.fromJson(json);
      expect(fetchBodyRequest.id, "fe4d9b5e-7b7e-4b9e-8c5a-1b5b4b4e4e4e");
    });
    test("toJson", () {
      var fetchBodyRequest = FetchBodyRequest.fromJson(json);
      expect(fetchBodyRequest.toJson(), json);
    });
  });
}
