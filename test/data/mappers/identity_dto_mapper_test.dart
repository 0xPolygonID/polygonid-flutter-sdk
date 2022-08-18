import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/data/identity/dtos/identity_dto.dart';
import 'package:polygonid_flutter_sdk/data/identity/mappers/identity_dto_mapper.dart';
import 'package:polygonid_flutter_sdk/domain/identity/entities/identity.dart';

// Data
const privateKey = "thePrivateKey";
const identifier = "theIdentifier";
const authClaim = "theAuthClaim";
const smt = "theSmt";
const mockDTO = IdentityDTO(
    privateKey: privateKey,
    identifier: identifier,
    authClaim: authClaim,
    smt: smt);
const mockEntity = Identity(
    privateKey: privateKey,
    identifier: identifier,
    authClaim: authClaim,
    smt: smt);

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
