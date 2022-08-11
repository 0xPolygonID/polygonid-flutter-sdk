import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/data/credential/dtos/credential_fetch_request.dart';
import 'package:polygonid_flutter_sdk/data/credential/mappers/credential_request_mapper.dart';
import 'package:polygonid_flutter_sdk/domain/credential/entities/credential_request_entity.dart';
import 'package:polygonid_flutter_sdk/domain/identity/entities/circuit_data_entity.dart';

// Data
const id = "theId";
const thid = "theThid";
const to = "theTo";
const identifier = "theIdentifier";
const from = "theFrom";
const typ = "application/iden3comm-plain-json";
const type = "https://iden3-communication.io/credentials/1.0/fetch-request";
const bodyId = "theBodyId";
final body = CredentialFetchRequestBody(id: bodyId);

final CredentialRequestEntity requestEntity = CredentialRequestEntity(
    identifier,
    CircuitDataEntity(id, Uint8List.fromList([]), Uint8List.fromList([])),
    "",
    id,
    thid,
    from);

// Tested instance
CredentialRequestMapper mapper = CredentialRequestMapper();

void main() {
  group("Map to", () {
    test(
        "Given a CredentialRequestEntity, when I call mapTo, then I expect an CredentialFetchRequest to be returned",
        () {
      // When
      CredentialFetchRequest result = mapper.mapTo(requestEntity);
      expect(result.id, isA<String>());
      expect(result.typ, typ);
      expect(result.type, type);
      expect(result.thid, thid);
      expect(result.body.id, id);
      expect(result.from, identifier);
      expect(result.to, from);
    });
  });
}
