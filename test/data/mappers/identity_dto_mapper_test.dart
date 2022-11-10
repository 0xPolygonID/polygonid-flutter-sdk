import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/identity_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/identity_dto_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';

// Data
const publicKey = ["thePubX", "thePubY"];
const identifier = "theIdentifier";
const authClaim = "theAuthClaim";
const state = "theState";
const mockDTO = IdentityDTO(
  identifier: identifier,
  publicKey: publicKey,
  state: state,
);
const mockEntity = IdentityEntity(
  identifier: identifier,
  publicKey: publicKey,
  state: state,
);

// Tested instance
IdentityDTOMapper mapper = IdentityDTOMapper();

void main() {
  group("Map from", () {
    test(
        "Given a IdentityDTO, when I call mapFrom, then I expect an Identity to be returned",
        () {
      // When
      expect(mapper.mapFrom(mockDTO), mockEntity);
    });
  });
}
