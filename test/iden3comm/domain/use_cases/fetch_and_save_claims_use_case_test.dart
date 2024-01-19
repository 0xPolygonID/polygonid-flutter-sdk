import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/cache_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claim_revocation_status_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/save_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_credential_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/fetch_and_save_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_token_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_fetch_requests_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';

import '../../../common/common_mocks.dart';
import '../../../common/iden3comm_mocks.dart';
import 'authenticate_use_case_test.dart';
import 'fetch_and_save_claims_use_case_test.mocks.dart';

// Data
final exception = Exception();

final requests = [
  "theRequest",
  "theOtherRequest",
  "theThirdRequest",
];

final revStatus = {
  "mtp": {
    "existence": false,
  }
};

final claimEntity = ClaimEntity(
  issuer: "",
  did: "",
  expiration: "",
  info: {},
  type: "",
  state: ClaimState.active,
  id: "id",
  credentialRawValue: "",
);

final result = [claimEntity, claimEntity, claimEntity];

final param = FetchAndSaveClaimsParam(
    message: Iden3commMocks.offerRequest,
    genesisDid: CommonMocks.identifier,
    profileNonce: CommonMocks.genesisNonce,
    privateKey: CommonMocks.privateKey);

// Dependencies
MockIden3commCredentialRepository iden3commCredentialRepository =
    MockIden3commCredentialRepository();
MockGetFetchRequestsUseCase getFetchRequestsUseCase =
    MockGetFetchRequestsUseCase();
MockCheckProfileAndDidCurrentEnvUseCase checkProfileAndDidCurrentEnvUseCase =
    MockCheckProfileAndDidCurrentEnvUseCase();
MockGetDidIdentifierUseCase getDidIdentifierUseCase =
    MockGetDidIdentifierUseCase();
MockGetEnvUseCase getEnvUseCase = MockGetEnvUseCase();
MockSaveClaimsUseCase saveClaimsUseCase = MockSaveClaimsUseCase();
MockGetAuthTokenUseCase getAuthTokenUseCase = MockGetAuthTokenUseCase();
MockGetClaimRevocationStatusUseCase getClaimRevocationStatusUseCase =
    MockGetClaimRevocationStatusUseCase();
MockCacheCredentialUseCase cacheCredentialUseCase =
    MockCacheCredentialUseCase();
MockStacktraceManager stacktraceManager = MockStacktraceManager();

// Tested instance
FetchAndSaveClaimsUseCase useCase = FetchAndSaveClaimsUseCase(
  iden3commCredentialRepository,
  checkProfileAndDidCurrentEnvUseCase,
  getEnvUseCase,
  getDidIdentifierUseCase,
  getFetchRequestsUseCase,
  getAuthTokenUseCase,
  saveClaimsUseCase,
  getClaimRevocationStatusUseCase,
  cacheCredentialUseCase,
  stacktraceManager,
);

@GenerateMocks([
  Iden3commCredentialRepository,
  CheckProfileAndDidCurrentEnvUseCase,
  GetEnvUseCase,
  GetDidIdentifierUseCase,
  GetFetchRequestsUseCase,
  GetAuthTokenUseCase,
  SaveClaimsUseCase,
  GetClaimRevocationStatusUseCase,
  CacheCredentialUseCase,
  StacktraceManager,
])
void main() {
  group("Fetch and save claims", () {
    setUp(() {
      reset(iden3commCredentialRepository);
      reset(getFetchRequestsUseCase);
      reset(getAuthTokenUseCase);
      reset(saveClaimsUseCase);
      reset(getClaimRevocationStatusUseCase);

      // Given
      when(getFetchRequestsUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.value(requests));
      when(getAuthTokenUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.value(CommonMocks.token));
      when(saveClaimsUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.value(result));
      when(iden3commCredentialRepository.fetchClaim(
              did: anyNamed('did'),
              authToken: anyNamed('authToken'),
              url: anyNamed('url')))
          .thenAnswer((realInvocation) => Future.value(claimEntity));
      when(getClaimRevocationStatusUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.value(revStatus));
      when(getDidIdentifierUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.value(CommonMocks.did));
      when(getEnvUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.value(CommonMocks.env));
      when(checkProfileAndDidCurrentEnvUseCase.execute(
              param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.value(null));
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
      expect(fetchMessageCaptures.did, CommonMocks.did);

      var authVerify =
          verify(getAuthTokenUseCase.execute(param: captureAnyNamed('param')));

      expect(authVerify.callCount, requests.length);
      for (int i = 0; i < requests.length; i++) {
        expect(authVerify.captured[i].genesisDid, param.genesisDid);
        expect(authVerify.captured[i].privateKey, param.privateKey);
        expect(authVerify.captured[i].message, requests[i]);
      }

      var verifyConfig =
          verify(getEnvUseCase.execute(param: captureAnyNamed('param')));
      expect(verifyConfig.callCount, 1);
      var capturedConfig = verifyConfig.captured;
      expect(capturedConfig[0], null);

      var captureCheck = verify(checkProfileAndDidCurrentEnvUseCase.execute(
              param: captureAnyNamed('param')))
          .captured
          .first;
      expect(captureCheck.did, param.genesisDid);
      expect(captureCheck.privateKey, CommonMocks.privateKey);
      expect(captureCheck.profileNonce, CommonMocks.genesisNonce);

      var fetchVerify = verify(iden3commCredentialRepository.fetchClaim(
          did: captureAnyNamed('did'),
          authToken: captureAnyNamed('authToken'),
          url: captureAnyNamed('url')));

      expect(fetchVerify.callCount, requests.length);
      int j = 0;
      for (int i = 0; i < requests.length * 3; i += 3) {
        expect(fetchVerify.captured[i], CommonMocks.did);
        expect(fetchVerify.captured[i + 1], CommonMocks.token);
        expect(fetchVerify.captured[i + 2], param.message.body.url);
        j++;
      }

      // FIXME: This is verifying code that is currently commented out.
      // var revStatusVerify = verify(getClaimRevocationStatusUseCase.execute(
      //     param: captureAnyNamed('param')));
    });

    test(
        "Given a FetchAndSaveClaimsParam, when I call execute and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(iden3commCredentialRepository.fetchClaim(
              did: anyNamed('did'),
              authToken: anyNamed('authToken'),
              url: anyNamed('url')))
          .thenAnswer((realInvocation) => Future.error(exception));
      // When
      await expectLater(useCase.execute(param: param), throwsA(exception));

      // Then
      var fetchMessageCaptures = verify(
              getFetchRequestsUseCase.execute(param: captureAnyNamed('param')))
          .captured
          .first;

      expect(fetchMessageCaptures.message, param.message);
      expect(fetchMessageCaptures.did, CommonMocks.did);

      var authVerify =
          verify(getAuthTokenUseCase.execute(param: captureAnyNamed('param')));

      expect(authVerify.callCount, 1);
      expect(authVerify.captured[0].genesisDid, param.genesisDid);
      expect(authVerify.captured[0].privateKey, param.privateKey);
      expect(authVerify.captured[0].message, requests[0]);

      var fetchVerify = verify(iden3commCredentialRepository.fetchClaim(
          did: captureAnyNamed('did'),
          authToken: captureAnyNamed('authToken'),
          url: captureAnyNamed('url')));

      expect(fetchVerify.callCount, 1);

      expect(fetchVerify.captured[0], CommonMocks.did);
      expect(fetchVerify.captured[1], CommonMocks.token);
      expect(fetchVerify.captured[2], param.message.body.url);

      verifyNever(getClaimRevocationStatusUseCase.execute(
          param: captureAnyNamed('param')));
    });
  });
}
