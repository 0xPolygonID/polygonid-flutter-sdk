import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/authorization/response/auth_body_did_doc_response_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/authorization/response/auth_body_response_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/authorization/response/auth_response_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/auth_response_mapper.dart';

final mockAuthResponse = AuthResponseDTO(
  id: "theId",
  thid: "theThid",
  to: "theTo",
  from: "theFrom",
  typ: "theTyp",
  type: "theType",
  body: const AuthBodyResponseDTO(
    message: "theMessage",
    proofs: [],
    did_doc: AuthBodyDidDocResponseDTO(
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
