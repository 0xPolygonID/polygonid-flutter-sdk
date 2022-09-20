import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/credential_request_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/fetch_and_save_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_auth_token_use_case.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/entities/circuit_data_entity.dart';

import 'fetch_and_save_claims_use_case_test.mocks.dart';

// Data
const identifier = "theIdentifier";
const message = "theMessage";
const token = "theToken";
const url = "theUrl";
final exception = Exception();
final circuitData = [
  CircuitDataEntity(
      "circuitId1", Uint8List.fromList([]), Uint8List.fromList([])),
  CircuitDataEntity(
      "circuitId2", Uint8List.fromList([]), Uint8List.fromList([])),
  CircuitDataEntity(
      "circuitId3", Uint8List.fromList([]), Uint8List.fromList([]))
];

final requestEntities = [
  CredentialRequestEntity(identifier, circuitData[0], url, "id1", "", ""),
  CredentialRequestEntity(identifier, circuitData[1], url, "id2", "", ""),
  CredentialRequestEntity(identifier, circuitData[2], url, "id3", "", "")
];

final claimEntity = ClaimEntity(
    issuer: "",
    identifier: "",
    expiration: "",
    credential: {},
    type: "",
    state: ClaimState.active,
    id: "id");

final result = [claimEntity, claimEntity, claimEntity];

// Dependencies
MockGetAuthTokenUseCase getAuthTokenUseCase = MockGetAuthTokenUseCase();
MockCredentialRepository credentialRepository = MockCredentialRepository();

// Tested instance
FetchAndSaveClaimsUseCase useCase =
    FetchAndSaveClaimsUseCase(getAuthTokenUseCase, credentialRepository);

@GenerateMocks([GetAuthTokenUseCase, CredentialRepository])
void main() {
  group("Fetch and save claims", () {
    setUp(() {
      reset(credentialRepository);
      reset(getAuthTokenUseCase);

      // Given
      when(credentialRepository.getFetchMessage(
              credentialRequest: anyNamed('credentialRequest')))
          .thenAnswer((realInvocation) => Future.value(message));
      when(getAuthTokenUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.value(token));
      when(credentialRepository.fetchClaim(
              identifier: anyNamed('identifier'),
              token: anyNamed('token'),
              credentialRequest: anyNamed('credentialRequest')))
          .thenAnswer((realInvocation) => Future.value(claimEntity));
      when(credentialRepository.saveClaims(claims: anyNamed('claims')))
          .thenAnswer((realInvocation) => Future.value());
    });

    test(
        "Given a list of CredentialRequestEntity, when I call execute, then I expect a list of ClaimEntity to be returned",
        () async {
      // When
      expect(await useCase.execute(param: requestEntities), result);

      // Then
      var messageVerify = verify(credentialRepository.getFetchMessage(
          credentialRequest: captureAnyNamed('credentialRequest')));

      expect(messageVerify.callCount, requestEntities.length);
      for (int i = 0; i < requestEntities.length; i++) {
        expect(messageVerify.captured[i], requestEntities[i]);
      }

      var authVerify =
          verify(getAuthTokenUseCase.execute(param: captureAnyNamed('param')));

      expect(authVerify.callCount, requestEntities.length);
      for (int i = 0; i < requestEntities.length; i++) {
        expect(
            authVerify.captured[i].identifier, requestEntities[i].identifier);
        expect(authVerify.captured[i].message, message);
      }

      var fetchVerify = verify(credentialRepository.fetchClaim(
          identifier: captureAnyNamed('identifier'),
          token: captureAnyNamed('token'),
          credentialRequest: captureAnyNamed('credentialRequest')));

      expect(fetchVerify.callCount, requestEntities.length);
      int j = 0;
      for (int i = 0; i < requestEntities.length * 3; i += 3) {
        expect(fetchVerify.captured[i], requestEntities[j].identifier);
        expect(fetchVerify.captured[i + 1], token);
        expect(fetchVerify.captured[i + 2], requestEntities[j]);
        j++;
      }

      expect(
          verify(credentialRepository.saveClaims(
                  claims: captureAnyNamed('claims')))
              .captured
              .first,
          result);
    });

    test(
        "Given a list of CredentialRequestEntity, when I call execute and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(credentialRepository.fetchClaim(
              identifier: anyNamed('identifier'),
              token: anyNamed('token'),
              credentialRequest: anyNamed('credentialRequest')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(
          useCase.execute(param: requestEntities), throwsA(exception));

      // Then
      var messageVerify = verify(credentialRepository.getFetchMessage(
          credentialRequest: captureAnyNamed('credentialRequest')));

      expect(messageVerify.callCount, requestEntities.length);
      for (int i = 0; i < requestEntities.length; i++) {
        expect(messageVerify.captured[i], requestEntities[i]);
      }

      var authVerify =
          verify(getAuthTokenUseCase.execute(param: captureAnyNamed('param')));

      expect(authVerify.callCount, requestEntities.length);
      for (int i = 0; i < requestEntities.length; i++) {
        expect(
            authVerify.captured[i].identifier, requestEntities[i].identifier);
        expect(authVerify.captured[i].message, message);
      }

      var fetchVerify = verify(credentialRepository.fetchClaim(
          identifier: captureAnyNamed('identifier'),
          token: captureAnyNamed('token'),
          credentialRequest: captureAnyNamed('credentialRequest')));

      expect(fetchVerify.callCount, requestEntities.length);
      int j = 0;
      for (int i = 0; i < requestEntities.length * 3; i += 3) {
        expect(fetchVerify.captured[i], requestEntities[j].identifier);
        expect(fetchVerify.captured[i + 1], token);
        expect(fetchVerify.captured[i + 2], requestEntities[j]);
        j++;
      }

      verifyNever(
          credentialRepository.saveClaims(claims: captureAnyNamed('claims')));
    });
  });
}
