import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/identity_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/identity_dto_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';

// Data
const publicKey = ["thePubX", "thePubY"];
const identifier = "theIdentifier";
const privateKey = "thePrivateKey";
const mockDTO = IdentityDTO(identifier: identifier, publicKey: publicKey);
const mockEntity = IdentityEntity(identifier: identifier, publicKey: publicKey);
const privateIdentity = PrivateIdentityEntity(
    identifier: identifier, publicKey: publicKey, privateKey: privateKey);

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
