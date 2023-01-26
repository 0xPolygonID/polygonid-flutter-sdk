import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/identity_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/identity_dto_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';

// Data
const publicKey = ["thePubX", "thePubY"];
const identifier = "theIdentifier";
const privateKey = "thePrivateKey";
const privateIdentity = PrivateIdentityEntity(
    did: identifier, publicKey: publicKey, privateKey: privateKey);
const authClaim = "theAuthClaim";
const state = "theState";
const mockDTO = IdentityDTO(
  did: identifier,
  publicKey: publicKey,
);
const mockEntity = IdentityEntity(
  did: identifier,
  publicKey: publicKey,
);

// Tested instance
IdentityDTOMapper mapper = IdentityDTOMapper();

void main() {
  test(
      "Given a IdentityDTO, when I call mapFrom, then I expect an Identity to be returned",
      () {
    // When
    expect(mapper.mapFrom(mockDTO), mockEntity);
  });

  test(
      "Given a IdentityDTO, when I call mapTo, then I expect an IdentityDTO to be returned",
      () {
    // When
    expect(mapper.mapTo(mockEntity), mockDTO);
  });

  test(
      "Given a IdentityDTO and a privateKey, when I call mapPrivateFrom, then I expect a PrivateIdentity to be returned",
      () {
    // When
    expect(mapper.mapPrivateFrom(mockDTO, privateKey), privateIdentity);
  });
}
