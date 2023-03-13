import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/add_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/create_new_identity_use_case.dart';

import '../../../common/common_mocks.dart';
import '../../../common/identity_mocks.dart';
import 'create_new_identity_use_case_test.mocks.dart';

// Dependencies
MockIdentityRepository identityRepository = MockIdentityRepository();
MockAddIdentityUseCase addIdentityUseCase = MockAddIdentityUseCase();

// Tested instance
CreateNewIdentityUseCase useCase = CreateNewIdentityUseCase(
  CommonMocks.config,
  identityRepository,
  addIdentityUseCase,
);

@GenerateMocks([
  IdentityRepository,
  AddIdentityUseCase,
])
void main() {
  setUp(() {
    // Given
    when(identityRepository.getPrivateKey(
            accessMessage: anyNamed('accessMessage'),
            secret: anyNamed('secret')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.privateKey));
    when(addIdentityUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (realInvocation) => Future.value(IdentityMocks.privateIdentity));
  });

  test(
      "Given a secret, when I call execute, then I expect an identity to be returned",
      () async {
    // When
    expect(await useCase.execute(param: CommonMocks.message),
        IdentityMocks.privateIdentity);

    // Then
    var configCaptured = verify(identityRepository.getPrivateKey(
      accessMessage: captureAnyNamed('accessMessage'),
      secret: captureAnyNamed('secret'),
    )).captured;
    expect(configCaptured[0], CommonMocks.config);
    expect(configCaptured[1], CommonMocks.message);

    var capturedCreate =
        verify(addIdentityUseCase.execute(param: captureAnyNamed('param')))
            .captured
            .first;
    expect(capturedCreate.privateKey, CommonMocks.privateKey);
  });

  test(
      "Given a private key which is null, when I call execute, then I expect an identifier to be returned",
      () async {
    // When
    expect(await useCase.execute(), IdentityMocks.privateIdentity);

    // Then
    var configCaptured = verify(identityRepository.getPrivateKey(
      accessMessage: captureAnyNamed('accessMessage'),
      secret: captureAnyNamed('secret'),
    )).captured;
    expect(configCaptured[0], CommonMocks.config);
    expect(configCaptured[1], null);

    var capturedCreate =
        verify(addIdentityUseCase.execute(param: captureAnyNamed('param')))
            .captured
            .first;
    expect(capturedCreate.privateKey, CommonMocks.privateKey);
  });

  test(
      "Given a param, when I call execute and an error occurred, then I expect an exception to be thrown",
      () async {
    // Given
    when(identityRepository.getPrivateKey(
            accessMessage: anyNamed('accessMessage'),
            secret: anyNamed('secret')))
        .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

    // When
    await expectLater(useCase.execute(param: CommonMocks.message),
        throwsA(CommonMocks.exception));

    // Then
    var configCaptured = verify(identityRepository.getPrivateKey(
      accessMessage: captureAnyNamed('accessMessage'),
      secret: captureAnyNamed('secret'),
    )).captured;
    expect(configCaptured[0], CommonMocks.config);
    expect(configCaptured[1], CommonMocks.message);

    verifyNever(addIdentityUseCase.execute(param: captureAnyNamed('param')));
  });
}
