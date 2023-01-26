import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/fetch_and_save_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_fetch_requests_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_token_use_case.dart';

import '../../common/common_mocks.dart';
import '../../common/iden3com_mocks.dart';
import 'fetch_and_save_claims_use_case_test.mocks.dart';

// Data
final exception = Exception();

final requests = [
  "theRequest",
  "theOtherRequest",
  "theThirdRequest",
];

final claimEntity = ClaimEntity(
    issuer: "",
    did: "",
    expiration: "",
    info: {},
    type: "",
    state: ClaimState.active,
    id: "id");

final result = [claimEntity, claimEntity, claimEntity];

final param = FetchAndSaveClaimsParam(
    message: Iden3commMocks.offerRequest,
    did: CommonMocks.identifier,
    privateKey: CommonMocks.privateKey);

// Dependencies
MockGetFetchRequestsUseCase getFetchRequestsUseCase =
    MockGetFetchRequestsUseCase();
MockGetAuthTokenUseCase getAuthTokenUseCase = MockGetAuthTokenUseCase();
MockCredentialRepository credentialRepository = MockCredentialRepository();

// Tested instance
FetchAndSaveClaimsUseCase useCase = FetchAndSaveClaimsUseCase(
    getFetchRequestsUseCase, getAuthTokenUseCase, credentialRepository);

@GenerateMocks(
    [GetFetchRequestsUseCase, GetAuthTokenUseCase, CredentialRepository])
void main() {
  group("Fetch and save claims", () {
    setUp(() {
      reset(credentialRepository);
      reset(getAuthTokenUseCase);

      // Given
      when(getFetchRequestsUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.value(requests));
      when(getAuthTokenUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.value(CommonMocks.token));
      when(credentialRepository.fetchClaim(
              did: anyNamed('identifier'),
              token: anyNamed('token'),
              message: anyNamed('message')))
          .thenAnswer((realInvocation) => Future.value(claimEntity));
      when(credentialRepository.saveClaims(
              did: anyNamed('identifier'),
              privateKey: anyNamed('privateKey'),
              claims: anyNamed('claims')))
          .thenAnswer((realInvocation) => Future.value());
    });

    test(
        "Given a FetchAndSaveClaimsParam, when I call execute, then I expect a list of ClaimEntity to be returned",
        () async {
      // When
      expect(await useCase.execute(param: param), result);

      // Then
      var fetchMessageCaptures = verify(
              getFetchRequestsUseCase.execute(param: captureAnyNamed('param')))
          .captured
          .first;

      expect(fetchMessageCaptures.message, param.message);
      expect(fetchMessageCaptures.did, param.did);

      var authVerify =
          verify(getAuthTokenUseCase.execute(param: captureAnyNamed('param')));

      expect(authVerify.callCount, requests.length);
      for (int i = 0; i < requests.length; i++) {
        expect(authVerify.captured[i].did, param.did);
        expect(authVerify.captured[i].privateKey, param.privateKey);
        expect(authVerify.captured[i].message, requests[i]);
      }

      var fetchVerify = verify(credentialRepository.fetchClaim(
          did: captureAnyNamed('identifier'),
          token: captureAnyNamed('token'),
          message: captureAnyNamed('message')));

      expect(fetchVerify.callCount, requests.length);
      int j = 0;
      for (int i = 0; i < requests.length * 3; i += 3) {
        expect(fetchVerify.captured[i], param.did);
        expect(fetchVerify.captured[i + 1], CommonMocks.token);
        expect(fetchVerify.captured[i + 2], param.message);
        j++;
      }

      expect(
          verify(credentialRepository.saveClaims(
                  did: CommonMocks.identifier,
                  privateKey: CommonMocks.privateKey,
                  claims: captureAnyNamed('claims')))
              .captured
              .first,
          result);
    });

    test(
        "Given a FetchAndSaveClaimsParam, when I call execute and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(credentialRepository.fetchClaim(
              did: anyNamed('identifier'),
              token: anyNamed('token'),
              message: anyNamed('message')))
          .thenAnswer((realInvocation) => Future.error(exception));
      // When
      await expectLater(useCase.execute(param: param), throwsA(exception));

      // Then
      var fetchMessageCaptures = verify(
              getFetchRequestsUseCase.execute(param: captureAnyNamed('param')))
          .captured
          .first;

      expect(fetchMessageCaptures.message, param.message);
      expect(fetchMessageCaptures.did, param.did);

      var authVerify =
          verify(getAuthTokenUseCase.execute(param: captureAnyNamed('param')));

      expect(authVerify.callCount, 1);
      expect(authVerify.captured[0].did, param.did);
      expect(authVerify.captured[0].privateKey, param.privateKey);
      expect(authVerify.captured[0].message, requests[0]);

      var fetchVerify = verify(credentialRepository.fetchClaim(
          did: captureAnyNamed('identifier'),
          token: captureAnyNamed('token'),
          message: captureAnyNamed('message')));

      expect(fetchVerify.callCount, 1);

      expect(fetchVerify.captured[0], param.did);
      expect(fetchVerify.captured[1], CommonMocks.token);
      expect(fetchVerify.captured[2], param.message);

      verifyNever(credentialRepository.saveClaims(
          did: CommonMocks.identifier,
          privateKey: CommonMocks.privateKey,
          claims: captureAnyNamed('claims')));
    });
  });
}
