import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/display_type/unknown_display_type.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_info_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_state_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/display_type_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/response/credential_issuance_response.dart';

import '../../../iden3comm/data/dtos/credential_issuance_message_test.dart';
import 'claim_mapper_test.mocks.dart';

// Data
const privateKey = "thePrivateKey";
const identifier = "theIdentifier";
const authClaim = "theAuthClaim";

/// We assume [CredentialIssuanceMessage] has been tested
final issuanceMessage =
    CredentialIssuanceMessage.fromJson(jsonDecode(mockIssuanceMessage));

final Map<String, dynamic> info = issuanceMessage.body.credential.toJson();
final dto = CredentialDTO(
  id: issuanceMessage.body.credential.id,
  issuer: issuanceMessage.from,
  did: identifier,
  expiration: issuanceMessage.body.credential.expirationDate,
  type: issuanceMessage.body.credential.credentialSubject.type,
  info: issuanceMessage.body.credential,
  credentialRawValue: mockIssuanceMessage,
);
final entity = CredentialEntity(
  issuer: issuanceMessage.from,
  did: identifier,
  expiration: issuanceMessage.body.credential.expirationDate,
  info: info,
  type: issuanceMessage.body.credential.credentialSubject.type,
  state: CredentialState.active,
  id: issuanceMessage.body.credential.id,
  credentialRawValue: mockIssuanceMessage,
);
final displayType = UnknownDisplayType({});

// Dependencies
final stateMapper = MockCredentialStateMapper();
final infoMapper = MockCredentialInfoMapper();
MockDisplayTypeMapper displayTypeMapper = MockDisplayTypeMapper();
// Tested instance
CredentialMapper mapper =
    CredentialMapper(stateMapper, infoMapper, displayTypeMapper);

@GenerateMocks([
  CredentialStateMapper,
  CredentialInfoMapper,
  DisplayTypeMapper,
])
void main() {
  setUp(() {});

  group("Map from", () {
    test(
        "Given a ClaimDTO, when I call mapFrom, then I expect an ClaimEntity to be returned",
        () {
      // Given
      when(infoMapper.mapFrom(any)).thenReturn(info);
      when(stateMapper.mapFrom(any)).thenReturn(CredentialState.active);
      when(displayTypeMapper.mapFrom(any)).thenReturn(displayType);

      // When
      expect(mapper.mapFrom(dto), entity);

      // Then
      expect(verify(infoMapper.mapFrom(captureAny)).captured.first,
          issuanceMessage.body.credential);
      expect(verify(stateMapper.mapFrom(captureAny)).captured.first, '');
      verifyNever(displayTypeMapper.mapFrom(captureAny));
    });
  });

  group("Map to", () {
    test(
        "Given a ClaimEntity, when I call mapTo, then I expect an ClaimDTO to be returned",
        () {
      // Given
      when(infoMapper.mapTo(any)).thenReturn(issuanceMessage.body.credential);
      when(stateMapper.mapTo(any)).thenReturn('');
      when(displayTypeMapper.mapTo(any)).thenReturn({});

      // When
      expect(mapper.mapTo(entity), dto);

      // Then
      expect(verify(infoMapper.mapTo(captureAny)).captured.first, info);
      expect(verify(stateMapper.mapTo(captureAny)).captured.first,
          CredentialState.active);
    });
  });
}
