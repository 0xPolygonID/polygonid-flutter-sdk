import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/auth_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_request_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/iden3_message_type_data_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/mappers/iden3_message_mapper.dart';
import 'package:polygonid_flutter_sdk/sdk/mappers/iden3_message_type_mapper.dart';

const issuerMessage =
    '{"id":"0b78a480-c710-4bd8-a4fd-454b577ca991","typ":"application/iden3comm-plain-json","type":"https://iden3-communication.io/authorization/1.0/request","thid":"0b78a480-c710-4bd8-a4fd-454b577ca991","body":{"callbackUrl":"https://issuer.polygonid.me/api/callback?sessionId=867314","reason":"test flow","scope":[]},"from":"1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ"}';

final authRequest = AuthRequest.fromJson(jsonDecode(issuerMessage));
AuthRequestMapper authRequestMapper =
    AuthRequestMapper(Iden3MessageTypeDataMapper());
Iden3MessageMapper iden3messageMapper =
    Iden3MessageMapper(Iden3MessageTypeMapper());

void main() {
  group(
    "Map from",
    () {
      test(
        "Given a json string, when called mapFrom() we expect AuthRequest obj to be returned",
        () {
          Iden3MessageEntity iden3Message =
              iden3messageMapper.mapFrom(issuerMessage);
          AuthRequest mapFrom = authRequestMapper.mapTo(iden3Message);
          expect(mapFrom.id, authRequest.id);
          expect(mapFrom.typ, authRequest.typ);
          expect(mapFrom.from, authRequest.from);
          expect(mapFrom.type, authRequest.type);
          expect(mapFrom.thid, authRequest.thid);
          expect(mapFrom.body.callbackUrl, authRequest.body.callbackUrl);
          expect(mapFrom.body.message, authRequest.body.message);
          expect(mapFrom.body.reason, authRequest.body.reason);
          expect(mapFrom.body.url, authRequest.body.url);
        },
      );
    },
  );
}
