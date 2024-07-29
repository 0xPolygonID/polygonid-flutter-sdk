import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_public_keys_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/update_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/add_profile_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/create_profiles_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/smt/create_identity_state_use_case.dart';

import '../../../../common/common_mocks.dart';
import '../../../../common/identity_mocks.dart';
import 'create_profiles_use_case_test.mocks.dart';

// Data
var exception = Exception();
var param = CreateProfilesParam(
  privateKey: CommonMocks.privateKey,
  profiles: CommonMocks.bigIntValues,
);

// Dependencies
MockIdentityRepository identityRepository = MockIdentityRepository();

MockGetPublicKeysUseCase getPublicKeysUseCase = MockGetPublicKeysUseCase();
MockGetCurrentEnvDidIdentifierUseCase getCurrentEnvDidIdentifierUseCase =
    MockGetCurrentEnvDidIdentifierUseCase();
MockStacktraceManager stacktraceManager = MockStacktraceManager();

// Tested instance
CreateProfilesUseCase useCase = CreateProfilesUseCase(
  getPublicKeysUseCase,
  getCurrentEnvDidIdentifierUseCase,
  stacktraceManager,
);

@GenerateMocks([
  IdentityRepository,
  GetPublicKeysUseCase,
  GetCurrentEnvDidIdentifierUseCase,
  StacktraceManager,
])
void main() {
  setUp(() {
    reset(getPublicKeysUseCase);
    reset(getCurrentEnvDidIdentifierUseCase);

    // Given
    when(getPublicKeysUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.pubKeys));
    when(getCurrentEnvDidIdentifierUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.did));
  });

  test(
    'Given a param, when I call execute, then I expect the process to complete',
    () async {
      // When
      await expectLater(useCase.execute(param: param), completes);

      // Then
      expect(
          verify(getPublicKeysUseCase.execute(param: captureAnyNamed('param')))
              .captured
              .first,
          CommonMocks.privateKey);

      var capturedGetDid = verify(getCurrentEnvDidIdentifierUseCase.execute(
              param: captureAnyNamed('param')))
          .captured;
      expect(capturedGetDid.length, CommonMocks.intValues.length + 1);
      expect(capturedGetDid.first._privateKey, CommonMocks.privateKey);
      expect(capturedGetDid.first.profileNonce, CommonMocks.genesisNonce);

      for (int i = 1; i < CommonMocks.bigIntValues.length + 1; i++) {
        expect(capturedGetDid[i]._privateKey, CommonMocks.privateKey);
        expect(capturedGetDid[i].profileNonce, CommonMocks.bigIntValues[i - 1]);
      }
    },
  );

  test(
      "Given a param, when I call execute and an error occurred, then I expect an exception to be thrown",
      () async {
    // Given
    when(getCurrentEnvDidIdentifierUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

    // When
    await expectLater(
        useCase.execute(param: param), throwsA(CommonMocks.exception));

    // Then
    expect(
        verify(getPublicKeysUseCase.execute(param: captureAnyNamed('param')))
            .captured
            .first,
        CommonMocks.privateKey);

    var capturedGetDid = verify(getCurrentEnvDidIdentifierUseCase.execute(
            param: captureAnyNamed('param')))
        .captured;
    expect(capturedGetDid.length, 1);
    expect(capturedGetDid.first._privateKey, CommonMocks.privateKey);
    expect(capturedGetDid.first.profileNonce, CommonMocks.genesisNonce);
  });
}
