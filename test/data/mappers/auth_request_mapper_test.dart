import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/auth_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_request_mapper.dart';

const issuerMessage =
    '{"id":"0b78a480-c710-4bd8-a4fd-454b577ca991","typ":"application/iden3comm-plain-json","type":"https://iden3-communication.io/authorization/1.0/request","thid":"0b78a480-c710-4bd8-a4fd-454b577ca991","body":{"callbackUrl":"https://issuer.polygonid.me/api/callback?sessionId=867314","reason":"test flow","scope":[]},"from":"1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ"}';

final authRequest = AuthRequest.fromJson(jsonDecode(issuerMessage));
AuthRequestMapper authRequestMapper = AuthRequestMapper();

void main() {
  group(
    "Map from",
    () {
      test(
        "Given a json string, when called mapFrom() we expect AuthRequest obj to be returned",
        () {
          AuthRequest mapFrom = authRequestMapper.mapFrom(issuerMessage);
          expect(mapFrom.id, authRequest.id);
          expect(mapFrom.typ, authRequest.typ);
          expect(mapFrom.from, authRequest.from);
          expect(mapFrom.type, authRequest.type);
          expect(mapFrom.thid, authRequest.thid);
          expect(mapFrom.body?.callbackUrl, authRequest.body?.callbackUrl);
          expect(mapFrom.body?.message, authRequest.body?.message);
          expect(mapFrom.body?.reason, authRequest.body?.reason);
          expect(mapFrom.body?.url, authRequest.body?.url);
        },
      );
    },
  );
}
