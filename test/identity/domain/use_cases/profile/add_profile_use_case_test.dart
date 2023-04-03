import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
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
  genesisDid: CommonMocks.did,
  profileNonce: 2,
  privateKey: CommonMocks.privateKey,
);

var existingParam = AddProfileParam(
  genesisDid: CommonMocks.did,
  profileNonce: CommonMocks.nonce,
  privateKey: CommonMocks.privateKey,
);

var negativeParam = AddProfileParam(
  genesisDid: CommonMocks.did,
  profileNonce: CommonMocks.negativeNonce,
  privateKey: CommonMocks.privateKey,
);

var genesisParam = AddProfileParam(
  genesisDid: CommonMocks.did,
  profileNonce: CommonMocks.genesisNonce,
  privateKey: CommonMocks.privateKey,
);

// Dependencies
MockGetIdentityUseCase getIdentityUseCase = MockGetIdentityUseCase();
MockUpdateIdentityUseCase updateIdentityUseCase = MockUpdateIdentityUseCase();
MockCreateProfilesUseCase createProfilesUseCase = MockCreateProfilesUseCase();
MockCreateIdentityStateUseCase createIdentityStateUseCase =
    MockCreateIdentityStateUseCase();
MockCheckProfileAndDidCurrentEnvUseCase checkProfileAndDidCurrentEnvUseCase =
    MockCheckProfileAndDidCurrentEnvUseCase();

// Tested instance
AddProfileUseCase useCase = AddProfileUseCase(
  getIdentityUseCase,
  updateIdentityUseCase,
  checkProfileAndDidCurrentEnvUseCase,
  createProfilesUseCase,
  createIdentityStateUseCase,
);

@GenerateMocks([
  GetIdentityUseCase,
  UpdateIdentityUseCase,
  CheckProfileAndDidCurrentEnvUseCase,
  CreateProfilesUseCase,
  CreateIdentityStateUseCase,
])
void main() {
  setUp(() {
    reset(getIdentityUseCase);
    reset(updateIdentityUseCase);
    reset(createProfilesUseCase);
    reset(createIdentityStateUseCase);
    reset(checkProfileAndDidCurrentEnvUseCase);

    // Given
    when(checkProfileAndDidCurrentEnvUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(null));
    when(getIdentityUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (realInvocation) => Future.value(IdentityMocks.privateIdentity));
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
      var captureCheck = verify(checkProfileAndDidCurrentEnvUseCase.execute(
              param: captureAnyNamed('param')))
          .captured
          .first;
      expect(captureCheck.did, CommonMocks.did);
      expect(captureCheck.privateKey, CommonMocks.privateKey);
      expect(captureCheck.profileNonce, 0);

      var getIdentityCapture =
          verify(getIdentityUseCase.execute(param: captureAnyNamed('param')))
              .captured
              .first;
      expect(getIdentityCapture.genesisDid, CommonMocks.did);

      var capturedUpdate =
          verify(updateIdentityUseCase.execute(param: captureAnyNamed('param')))
              .captured
              .first;
      expect(capturedUpdate.privateKey, CommonMocks.privateKey);
      expect(capturedUpdate.profiles.first, 0);
    },
  );

  test(
      "Given a param with an associated profile, when I call execute, then I expect an ProfileAlreadyExistsException to be thrown",
      () async {
    // Given
    when(getIdentityUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (realInvocation) => Future.value(IdentityMocks.privateIdentity));

    // When
    await useCase.execute(param: existingParam).catchError((error) {
      expect(error, isA<ProfileAlreadyExistsException>());
      expect(error.genesisDid, IdentityMocks.identity.did);
      expect(error.profileNonce,
          existingParam.profileNonce); //IdentityMocks.identity.profiles);
    });

    // Then
    var captureCheck = verify(checkProfileAndDidCurrentEnvUseCase.execute(
            param: captureAnyNamed('param')))
        .captured
        .first;
    expect(captureCheck.did, CommonMocks.did);
    expect(captureCheck.privateKey, CommonMocks.privateKey);
    expect(captureCheck.profileNonce, 0);

    var captureGetIdentity =
        verify(getIdentityUseCase.execute(param: captureAnyNamed('param')))
            .captured
            .first;
    expect(captureGetIdentity.genesisDid, CommonMocks.did);
    expect(captureGetIdentity.privateKey, CommonMocks.privateKey);

    verifyNever(updateIdentityUseCase.execute(param: captureAnyNamed('param')));
  });

  test(
      "Given a param, when I call execute and an error occurred, then I expect an exception to be thrown",
      () async {
    // Given
    when(getIdentityUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.error(exception));

    // When
    await expectLater(useCase.execute(param: param), throwsA(exception));

    // Then
    var captureCheck = verify(checkProfileAndDidCurrentEnvUseCase.execute(
            param: captureAnyNamed('param')))
        .captured
        .first;
    expect(captureCheck.did, CommonMocks.did);
    expect(captureCheck.privateKey, CommonMocks.privateKey);
    expect(captureCheck.profileNonce, 0);

    var captureGetIdentity =
        verify(getIdentityUseCase.execute(param: captureAnyNamed('param')))
            .captured
            .first;
    expect(captureGetIdentity.genesisDid, CommonMocks.did);
    expect(captureGetIdentity.privateKey, CommonMocks.privateKey);

    verifyNever(updateIdentityUseCase.execute(param: captureAnyNamed('param')));
  });
}
