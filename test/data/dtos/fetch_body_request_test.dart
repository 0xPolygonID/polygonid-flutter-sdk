import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/fetch/fetch_body_request.dart';

String data = '''
{
  "id": "27887"
}
''';
var json = jsonDecode(data);

void main() {
  group("FetchBodyRequest", () {
    test("fromJson", () {
      var fetchBodyRequest = FetchBodyRequest.fromJson(json);
      expect(fetchBodyRequest.id, "27887");
    });
    test("toJson", () {
      var fetchBodyRequest = FetchBodyRequest.fromJson(json);
      expect(fetchBodyRequest.toJson(), json);
    });
  });
}
