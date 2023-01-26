import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/auth_body_request.dart';

import '../../common/common_mocks.dart';
import '../../common/iden3com_mocks.dart';

var json = jsonDecode(Iden3commMocks.authRequestBodyJson);

void main() {
  group("AuthBodyRequest", () {
    test("fromJson", () {
      var authBodyRequest = AuthBodyRequest.fromJson(json);
      expect(authBodyRequest.reason, "test flow");
      expect(authBodyRequest.message, "");
      expect(authBodyRequest.callbackUrl, CommonMocks.url);
      expect(authBodyRequest.scope![0].id, 1);
      expect(authBodyRequest.scope![0].circuit_id, "credentialAtomicQuerySig");
      expect(authBodyRequest.scope![0].query.query.allowedIssuers![0], "*");
      expect(authBodyRequest.scope![0].query.query.schema?.type,
          "KYCAgeCredential");
      expect(authBodyRequest.scope![0].query.query.schema?.url,
          "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld");
      expect(authBodyRequest.url, "theUrl");
      expect(authBodyRequest.credentials![0].id, "27887");
      expect(authBodyRequest.credentials![0].description,
          "Authenticating with iden3");
    });
  });
}
