import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/add_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/add_profile_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/create_identity_state_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/create_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/update_identity_use_case.dart';

import '../../../../common/common_mocks.dart';
import '../../../../common/identity_mocks.dart';
import 'add_profile_use_case_test.mocks.dart';

// Data
var exception = Exception();
var param = AddProfileParam(
  profileNonce: CommonMocks.nonce,
  genesisDid: CommonMocks.did,
  privateKey: CommonMocks.privateKey,
);

// Dependencies
MockGetIdentityUseCase getIdentityUseCase = MockGetIdentityUseCase();
MockGetDidUseCase getDidUseCase = MockGetDidUseCase();
MockUpdateIdentityUseCase updateIdentityUseCase = MockUpdateIdentityUseCase();

// Tested instance
AddProfileUseCase useCase = AddProfileUseCase(
  getIdentityUseCase,
  getDidUseCase,
  updateIdentityUseCase,
);

@GenerateMocks([
  GetIdentityUseCase,
  GetDidUseCase,
  UpdateIdentityUseCase,
])
void main() {
  setUp(() {
    reset(getIdentityUseCase);
    reset(getDidUseCase);
    reset(updateIdentityUseCase);

    // Given
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
      "Given a param and with an associated profile, when I call execute, then I expect an ProfileAlreadyExistsException to be thrown",
      () async {
    // Given
    when(getIdentityUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (realInvocation) => Future.value(IdentityMocks.privateIdentity));

    // When
    await useCase.execute(param: param).then((_) => null).catchError((error) {
      expect(error, isA<ProfileAlreadyExistsException>());
      expect(error.genesisDid, IdentityMocks.identity.did);
      expect(error.profileNonce, 0); //IdentityMocks.identity.profiles);
    });

    // Then
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
    var captureGetIdentity =
        verify(getIdentityUseCase.execute(param: captureAnyNamed('param')))
            .captured
            .first;
    expect(captureGetIdentity.genesisDid, CommonMocks.did);
    expect(captureGetIdentity.privateKey, CommonMocks.privateKey);

    verifyNever(getDidUseCase.execute(param: captureAnyNamed('param')));

    verifyNever(updateIdentityUseCase.execute(param: captureAnyNamed('param')));
  });
}
