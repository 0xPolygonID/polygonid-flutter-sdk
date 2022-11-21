import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/credential_request_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/fetch_and_save_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_token_use_case.dart';

import 'fetch_and_save_claims_use_case_test.mocks.dart';

// Data
const privateKey = "thePrivateKey";
const identifier = "theIdentifier";
const message = "theMessage";
const token = "theToken";
const url = "theUrl";
final exception = Exception();

final requests = [
  CredentialRequestEntity(identifier, url, "id1", "", ""),
  CredentialRequestEntity(identifier, url, "id2", "", ""),
  CredentialRequestEntity(identifier, url, "id3", "", "")
];

final claimEntity = ClaimEntity(
    issuer: "",
    identifier: "",
    expiration: "",
    info: {},
    type: "",
    state: ClaimState.active,
    id: "id");

final result = [claimEntity, claimEntity, claimEntity];

final param = FetchAndSaveClaimsParam(
    requests: requests, identifier: identifier, privateKey: privateKey);

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
      when(credentialRepository.saveClaims(
              identifier: anyNamed('identifier'),
              privateKey: anyNamed('privateKey'),
              claims: anyNamed('claims')))
          .thenAnswer((realInvocation) => Future.value());
    });

    test(
        "Given a list of CredentialRequestEntity, when I call execute, then I expect a list of ClaimEntity to be returned",
        () async {
      // When
      expect(await useCase.execute(param: param), result);

      // Then
      var messageVerify = verify(credentialRepository.getFetchMessage(
          credentialRequest: captureAnyNamed('credentialRequest')));

      expect(messageVerify.callCount, requests.length);
      for (int i = 0; i < requests.length; i++) {
        expect(messageVerify.captured[i], requests[i]);
      }

      var authVerify =
          verify(getAuthTokenUseCase.execute(param: captureAnyNamed('param')));

      expect(authVerify.callCount, requests.length);
      for (int i = 0; i < requests.length; i++) {
        expect(authVerify.captured[i].identifier, requests[i].identifier);
        expect(authVerify.captured[i].message, message);
      }

      var fetchVerify = verify(credentialRepository.fetchClaim(
          identifier: captureAnyNamed('identifier'),
          token: captureAnyNamed('token'),
          credentialRequest: captureAnyNamed('credentialRequest')));

      expect(fetchVerify.callCount, requests.length);
      int j = 0;
      for (int i = 0; i < requests.length * 3; i += 3) {
        expect(fetchVerify.captured[i], requests[j].identifier);
        expect(fetchVerify.captured[i + 1], token);
        expect(fetchVerify.captured[i + 2], requests[j]);
        j++;
      }

      expect(
          verify(credentialRepository.saveClaims(
                  identifier: identifier,
                  privateKey: privateKey,
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
      await expectLater(useCase.execute(param: param), throwsA(exception));

      // Then
      var messageVerify = verify(credentialRepository.getFetchMessage(
          credentialRequest: captureAnyNamed('credentialRequest')));

      expect(messageVerify.callCount, requests.length);
      for (int i = 0; i < requests.length; i++) {
        expect(messageVerify.captured[i], requests[i]);
      }

      var authVerify =
          verify(getAuthTokenUseCase.execute(param: captureAnyNamed('param')));

      expect(authVerify.callCount, requests.length);
      for (int i = 0; i < requests.length; i++) {
        expect(authVerify.captured[i].identifier, requests[i].identifier);
        expect(authVerify.captured[i].message, message);
      }

      var fetchVerify = verify(credentialRepository.fetchClaim(
          identifier: captureAnyNamed('identifier'),
          token: captureAnyNamed('token'),
          credentialRequest: captureAnyNamed('credentialRequest')));

      expect(fetchVerify.callCount, requests.length);
      int j = 0;
      for (int i = 0; i < requests.length * 3; i += 3) {
        expect(fetchVerify.captured[i], requests[j].identifier);
        expect(fetchVerify.captured[i + 1], token);
        expect(fetchVerify.captured[i + 2], requests[j]);
        j++;
      }

      verifyNever(credentialRepository.saveClaims(
          identifier: identifier,
          privateKey: privateKey,
          claims: captureAnyNamed('claims')));
    });
  });
}
