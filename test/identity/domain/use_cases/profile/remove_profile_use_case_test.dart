import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/remove_all_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identities_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/create_profiles_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/get_profiles_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/remove_profile_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/update_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/smt/remove_identity_state_use_case.dart';

import '../../../../common/common_mocks.dart';
import '../../../../common/identity_mocks.dart';

import 'remove_profile_use_case_test.mocks.dart';

MockGetIdentityUseCase getIdentityUseCase = MockGetIdentityUseCase();
MockGetDidUseCase getDidUseCase = MockGetDidUseCase();
MockCreateProfilesUseCase createProfilesUseCase = MockCreateProfilesUseCase();
MockRemoveIdentityStateUseCase removeIdentityStateUseCase =
    MockRemoveIdentityStateUseCase();
MockRemoveAllClaimsUseCase removeAllClaimsUseCase =
    MockRemoveAllClaimsUseCase();
MockUpdateIdentityUseCase updateIdentityUseCase = MockUpdateIdentityUseCase();

RemoveProfileParam param = RemoveProfileParam(
  profileNonce: CommonMocks.nonce,
  genesisDid: CommonMocks.did,
  privateKey: CommonMocks.privateKey,
);

var negativeParam = RemoveProfileParam(
  profileNonce: CommonMocks.negativeNonce,
  genesisDid: CommonMocks.did,
  privateKey: CommonMocks.privateKey,
);

var genesisParam = RemoveProfileParam(
  profileNonce: CommonMocks.genesisNonce,
  genesisDid: CommonMocks.did,
  privateKey: CommonMocks.privateKey,
);

// Tested instance
RemoveProfileUseCase useCase = RemoveProfileUseCase(
    getIdentityUseCase,
    getDidUseCase,
    createProfilesUseCase,
    removeIdentityStateUseCase,
    removeAllClaimsUseCase,
    updateIdentityUseCase);

@GenerateMocks([
  GetIdentityUseCase,
  GetDidUseCase,
  CreateProfilesUseCase,
  RemoveIdentityStateUseCase,
  RemoveAllClaimsUseCase,
  UpdateIdentityUseCase,
])
void main() {
  setUp(() {
    reset(getIdentityUseCase);
    reset(getDidUseCase);
    reset(createProfilesUseCase);
    reset(removeIdentityStateUseCase);
    reset(removeAllClaimsUseCase);
    reset(updateIdentityUseCase);

    // Given
    when(getIdentityUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (realInvocation) => Future.value(IdentityMocks.privateIdentity));
    when(getDidUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(IdentityMocks.did));
    when(createProfilesUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.profiles));
    when(removeIdentityStateUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value());
    when(removeAllClaimsUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value());
    when(updateIdentityUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (realInvocation) => Future.value(IdentityMocks.privateIdentity));
  });

  test(
    'Given a param, when I call execute, then I expect no response to be returned',
    () async {
      // When
      expect(await useCase.execute(param: param).then((realInvocation) => null),
          null);

      // Then
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
      expect(capturedUpdate.blockchain, CommonMocks.blockchain);
      expect(capturedUpdate.network, CommonMocks.network);
      expect(capturedUpdate.profiles.first, 0);
    },
  );

  test(
    'Given a param, when I call execute and an error occurred, then I expect an exception to be thrown',
    () async {
      // Given
      when(getIdentityUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

      // When
      await expectLater(
          useCase.execute(param: param), throwsA(CommonMocks.exception));
    },
  );

  test(
      "Given a param and with an negative profile nonce, when I call execute, then I expect an InvalidProfileException to be thrown",
      () async {
    // Given

    // When
    await useCase
        .execute(param: negativeParam)
        .then((_) => null)
        .catchError((error) {
      expect(error, isA<InvalidProfileException>());
      expect(error.error, IdentityMocks.profileNegativeError);
      expect(error.profileNonce,
          negativeParam.profileNonce); //IdentityMocks.identity.profiles);
    });

    // Then
    verifyNever(getIdentityUseCase.execute(param: captureAnyNamed('param')));

    verifyNever(getDidUseCase.execute(param: captureAnyNamed('param')));

    verifyNever(updateIdentityUseCase.execute(param: captureAnyNamed('param')));
  });

  test(
      "Given a param and with an profile nonce of 0, when I call execute, then I expect an InvalidProfileException to be thrown",
      () async {
    // Given

    // When
    await useCase
        .execute(param: genesisParam)
        .then((_) => null)
        .catchError((error) {
      expect(error, isA<InvalidProfileException>());
      expect(error.error, IdentityMocks.profileGenesisError);
      expect(error.profileNonce,
          genesisParam.profileNonce); //IdentityMocks.identity.profiles);
    });

    // Then
    verifyNever(getIdentityUseCase.execute(param: captureAnyNamed('param')));

    verifyNever(getDidUseCase.execute(param: captureAnyNamed('param')));

    verifyNever(updateIdentityUseCase.execute(param: captureAnyNamed('param')));
  });
}
