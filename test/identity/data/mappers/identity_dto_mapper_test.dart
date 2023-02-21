import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/identity_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/identity_dto_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';

import '../../../common/common_mocks.dart';

// Data
final privateIdentity = PrivateIdentityEntity(
  did: CommonMocks.identifier,
  publicKey: CommonMocks.pubKeys,
  privateKey: CommonMocks.privateKey,
  profiles: CommonMocks.profiles,
);
const authClaim = "theAuthClaim";
const state = "theState";
final mockDTO = IdentityDTO(
  did: CommonMocks.identifier,
  publicKey: CommonMocks.pubKeys,
  profiles: CommonMocks.profiles,
);
final mockEntity = IdentityEntity(
  did: CommonMocks.identifier,
  publicKey: CommonMocks.pubKeys,
  profiles: CommonMocks.profiles,
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
    expect(mapper.mapPrivateFrom(mockDTO, CommonMocks.privateKey),
        privateIdentity);
  });
}
