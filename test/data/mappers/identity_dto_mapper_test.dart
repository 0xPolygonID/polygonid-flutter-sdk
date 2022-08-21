import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/identity_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/identity_dto_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';

// Data
const privateKey = "thePrivateKey";
const identifier = "theIdentifier";
const authClaim = "theAuthClaim";
const mockDTO = IdentityDTO(
    privateKey: privateKey, identifier: identifier, authClaim: authClaim);
const mockEntity = IdentityEntity(
    privateKey: privateKey, identifier: identifier, authClaim: authClaim);

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
