import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/update_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/add_profile_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/create_profiles_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/smt/create_identity_state_use_case.dart';

import '../../../../common/common_mocks.dart';
import '../../../../common/identity_mocks.dart';
import 'add_profile_use_case_test.mocks.dart';

// Data
var exception = Exception();
var param = AddProfileParam(
  profileNonce: 2,
  privateKey: CommonMocks.privateKey,
);

// Dependencies
MockGetIdentityUseCase getIdentityUseCase = MockGetIdentityUseCase();
MockGetDidUseCase getDidUseCase = MockGetDidUseCase();
MockUpdateIdentityUseCase updateIdentityUseCase = MockUpdateIdentityUseCase();
MockCreateProfilesUseCase createProfilesUseCase = MockCreateProfilesUseCase();
MockCreateIdentityStateUseCase createIdentityStateUseCase =
    MockCreateIdentityStateUseCase();
MockGetCurrentEnvDidIdentifierUseCase getCurrentEnvDidIdentifierUseCase =
    MockGetCurrentEnvDidIdentifierUseCase();

// Tested instance
AddProfileUseCase useCase = AddProfileUseCase(
  getIdentityUseCase,
  getDidUseCase,
  updateIdentityUseCase,
  getCurrentEnvDidIdentifierUseCase,
  createProfilesUseCase,
  createIdentityStateUseCase,
);

@GenerateMocks([
  GetIdentityUseCase,
  GetDidUseCase,
  UpdateIdentityUseCase,
  GetCurrentEnvDidIdentifierUseCase,
  CreateProfilesUseCase,
  CreateIdentityStateUseCase,
])
void main() {
  setUp(() {
    reset(getIdentityUseCase);
    reset(getDidUseCase);
    reset(updateIdentityUseCase);
    reset(createProfilesUseCase);
    reset(createIdentityStateUseCase);
    reset(getCurrentEnvDidIdentifierUseCase);

    // Given
    when(getCurrentEnvDidIdentifierUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.did));
    when(getIdentityUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (realInvocation) => Future.value(IdentityMocks.privateIdentity));
    when(getDidUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(IdentityMocks.did));
    when(createProfilesUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (realInvocation) => Future.value(
            {param.profileNonce: CommonMocks.did + "${param.profileNonce}"}));
    when(createIdentityStateUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value());
    when(updateIdentityUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (realInvocation) => Future.value(IdentityMocks.privateIdentity));
  });

  test(
    'Given a param, when I call execute, then I expect the process to complete',
    () async {
      // When
      await expectLater(useCase.execute(param: param), completes);

      // Then
      expect(
          verify(getCurrentEnvDidIdentifierUseCase.execute(
                  param: captureAnyNamed('param')))
              .captured
              .first
              .privateKey,
          param.privateKey);

      var getIdentityCapture =
          verify(getIdentityUseCase.execute(param: captureAnyNamed('param')))
              .captured
              .first;
      expect(getIdentityCapture.genesisDid, CommonMocks.did);

      var capturedDid =
          verify(getDidUseCase.execute(param: captureAnyNamed('param')))
              .captured
              .first;
      expect(capturedDid, CommonMocks.did);

      var capturedUpdate =
          verify(updateIdentityUseCase.execute(param: captureAnyNamed('param')))
              .captured
              .first;
      expect(capturedUpdate.privateKey, CommonMocks.privateKey);
      expect(capturedUpdate.profiles.first, 0);
    },
  );
}
