import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_body_did_doc_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_body_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/response/auth/auth_response.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/auth_response_mapper.dart';

final mockAuthResponse = AuthResponse(
  id: "theId",
  thid: "theThid",
  to: "theTo",
  from: "theFrom",
  typ: "theTyp",
  type: "theType",
  body: AuthBodyResponse(
    message: "theMessage",
    scope: [],
    did_doc: AuthBodyDidDocResponse(
      context: [],
      id: "theBodyResponseId",
      service: [],
    ),
  ),
);

AuthResponseMapper authResponseMapper = AuthResponseMapper();

void main() {
  group(
    "Map from",
    () {
      test(
        "Given a AuthResponse obj, when called mapFrom() we expect a String to be returned",
        () {
          String mapFrom = authResponseMapper.mapFrom(mockAuthResponse);
          expect(mapFrom, contains('theId'));
          expect(mapFrom, contains('theThid'));
          expect(mapFrom, contains('theTo'));
          expect(mapFrom, contains('theFrom'));
          expect(mapFrom, contains('theTyp'));
          expect(mapFrom, contains('theType'));
          expect(mapFrom, contains('theMessage'));
          expect(mapFrom, contains('theBodyResponseId'));
        },
      );
    },
  );
}
