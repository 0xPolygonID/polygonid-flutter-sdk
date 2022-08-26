import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/fetch_claim_response_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_state_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';

import '../dtos/fetch_claim_response_dto_test.dart';
import 'claim_mapper_test.mocks.dart';

// Data
const privateKey = "thePrivateKey";
const identifier = "theIdentifier";
const authClaim = "theAuthClaim";

/// We assume [FetchClaimResponseDTO] has been tested
final fetchClaimDTO =
    FetchClaimResponseDTO.fromJson(jsonDecode(mockFetchClaim));
final dto = ClaimDTO(
  id: fetchClaimDTO.credential.id,
  issuer: fetchClaimDTO.from,
  identifier: identifier,
  expiration: fetchClaimDTO.credential.expiration,
  type: fetchClaimDTO.credential.credentialSubject.type,
  credential: fetchClaimDTO.credential,
);
final entity = ClaimEntity(
    issuer: fetchClaimDTO.from,
    identifier: identifier,
    expiration: fetchClaimDTO.credential.expiration,
    credential: fetchClaimDTO.credential.toJson(),
    type: fetchClaimDTO.credential.credentialSubject.type,
    state: ClaimState.active,
    id: fetchClaimDTO.credential.id);

// Dependencies
MockClaimStateMapper stateMapper = MockClaimStateMapper();

// Tested instance
ClaimMapper mapper = ClaimMapper(stateMapper);

@GenerateMocks([ClaimStateMapper])
void main() {
  setUp(() {
    when(stateMapper.mapFrom(any)).thenReturn(ClaimState.active);
    when(stateMapper.mapTo(any)).thenReturn('');
  });

  group("Map from", () {
    test(
        "Given a ClaimDTO, when I call mapFrom, then I expect an ClaimEntity to be returned",
        () {
      // When
      expect(mapper.mapFrom(dto), entity);
    });
  });

  group("Map to", () {
    test(
        "Given a ClaimEntity, when I call mapTo, then I expect an ClaimDTO to be returned",
        () {
      // When
      expect(mapper.mapTo(entity), dto);
    });
  });
}
