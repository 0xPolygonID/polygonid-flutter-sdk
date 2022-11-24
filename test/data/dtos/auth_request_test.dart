import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/auth_request.dart';

import '../../common/common_mocks.dart';
import '../../common/iden3com_mocks.dart';

var json = jsonDecode(Iden3commMocks.authRequestJson);

void main() {
  group("AuthRequest", () {
    test(
      "fromJson",
      () {
        var authRequest = AuthRequest.fromJson(json);
        expect(authRequest.id, "4dd6479b-99b6-405c-ba9e-c7b18d251a5e");
        expect(authRequest.thid, "4dd6479b-99b6-405c-ba9e-c7b18d251a5e");
        expect(authRequest.from, "1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ");
        expect(authRequest.typ, "application/iden3comm-plain-json");
        expect(authRequest.type, Iden3MessageType.auth);
        expect(authRequest.body.reason, "test flow");
        expect(authRequest.body.message, "");
        expect(authRequest.body.callbackUrl, CommonMocks.url);
        expect(authRequest.body.scope?[0].id, 1);
        expect(
            authRequest.body.scope?[0].circuit_id, "credentialAtomicQuerySig");
        expect(authRequest.body.scope?[0].optional, false);
        expect(authRequest.body.scope?[0].rules.audience,
            "0x8b5b5a6b4e6b0b6b2b6b4b6b6b6b6b6b6b6b6b6b");
        expect(authRequest.body.scope?[0].rules.challenge, 748916);
        expect(authRequest.body.scope?[0].rules.query.allowedIssuers?[0], "*");
        expect(authRequest.body.scope?[0].rules.query.challenge, 123456);
        expect(authRequest.body.scope?[0].rules.query.schema?.type,
            "KYCAgeCredential");
        expect(authRequest.body.scope?[0].rules.query.schema?.url,
            "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld");
        expect(authRequest.body.url, "theUrl");
        expect(authRequest.body.credentials?[0].id, "27887");
        expect(authRequest.body.credentials?[0].description,
            "Authenticating with iden3");
      },
    );
  });
}
