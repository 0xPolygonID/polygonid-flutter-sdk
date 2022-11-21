import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/auth_body_credentials_request.dart';

String data = '''
{
  "id": "27887",
  "description": "Authenticating with iden3"
}
''';
var json = jsonDecode(data);

void main() {
  group("AuthBodyCredentialsRequest", () {
    test("fromJson", () {
      var authBodyCredentialsRequest =
          AuthBodyCredentialsRequest.fromJson(json);
      expect(authBodyCredentialsRequest.id, "27887");
      expect(
          authBodyCredentialsRequest.description, "Authenticating with iden3");
    });
    test("toJson", () {
      var authBodyCredentialsRequest =
          AuthBodyCredentialsRequest.fromJson(json);
      expect(authBodyCredentialsRequest.toJson(), json);
    });
  });
}
