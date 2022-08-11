import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/data/credential/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/data/credential/dtos/fetch_claim_response_dto.dart';
import 'package:polygonid_flutter_sdk/data/credential/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/data/credential/mappers/claim_state_mapper.dart';
import 'package:polygonid_flutter_sdk/domain/credential/entities/claim_entity.dart';

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
    credential: fetchClaimDTO.credential);
final entity = ClaimEntity(
    issuer: fetchClaimDTO.from,
    identifier: identifier,
    expiration: fetchClaimDTO.credential.expiration,
    data: fetchClaimDTO.credential.toJson(),
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
