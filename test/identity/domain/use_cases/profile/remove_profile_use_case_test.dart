import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/remove_profile_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/update_identity_use_case.dart';

import '../../../../common/common_mocks.dart';
import '../../../../common/identity_mocks.dart';
import 'remove_profile_use_case_test.mocks.dart';

MockGetIdentityUseCase getIdentityUseCase = MockGetIdentityUseCase();
MockGetDidUseCase getDidUseCase = MockGetDidUseCase();
MockUpdateIdentityUseCase updateIdentityUseCase = MockUpdateIdentityUseCase();
MockGetCurrentEnvDidIdentifierUseCase getCurrentEnvDidIdentifierUseCase =
    MockGetCurrentEnvDidIdentifierUseCase();

RemoveProfileParam param = RemoveProfileParam(
  profileNonce: CommonMocks.nonce,
  privateKey: CommonMocks.privateKey,
);

// Tested instance
RemoveProfileUseCase useCase = RemoveProfileUseCase(
  getIdentityUseCase,
  getDidUseCase,
  updateIdentityUseCase,
  getCurrentEnvDidIdentifierUseCase,
);

@GenerateMocks([
  GetIdentityUseCase,
  GetDidUseCase,
  UpdateIdentityUseCase,
  GetCurrentEnvDidIdentifierUseCase,
])
void main() {
  setUp(() {
    reset(getIdentityUseCase);
    reset(getDidUseCase);
    reset(updateIdentityUseCase);

    // Given
    when(getCurrentEnvDidIdentifierUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.did));
    when(getIdentityUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (realInvocation) => Future.value(IdentityMocks.privateIdentity));
    when(getDidUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(IdentityMocks.did));
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

  test(
    'Given a param, when I call execute and an error occurred, then I expect an exception to be thrown',
    () async {
      // Given
      when(getIdentityUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

      // When
      await expectLater(
          useCase.execute(param: param), throwsA(CommonMocks.exception));

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

      verifyNever(getDidUseCase.execute(param: captureAnyNamed('param')));
      verifyNever(
          updateIdentityUseCase.execute(param: captureAnyNamed('param')));
    },
  );
}
