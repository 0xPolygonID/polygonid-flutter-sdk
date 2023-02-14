import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/create_and_save_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/create_new_identity_use_case.dart';

import '../../common/common_mocks.dart';
import '../../common/identity_mocks.dart';
import 'create_new_identity_use_case_test.mocks.dart';

// Data
var exception = Exception();
var param = CreateNewIdentityParam(
    blockchain: CommonMocks.blockchain, network: CommonMocks.network);
var paramSecret = CreateNewIdentityParam(
    secret: CommonMocks.message,
    blockchain: CommonMocks.blockchain,
    network: CommonMocks.network);

// Dependencies
MockIdentityRepository identityRepository = MockIdentityRepository();
MockCreateAndSaveIdentityUseCase createAndSaveIdentityUseCase =
    MockCreateAndSaveIdentityUseCase();

// Tested instance
CreateNewIdentityUseCase useCase = CreateNewIdentityUseCase(
  CommonMocks.config,
  identityRepository,
  createAndSaveIdentityUseCase,
);

@GenerateMocks([
  IdentityRepository,
  CreateAndSaveIdentityUseCase,
])
void main() {
  setUp(() {
    // Given
    when(identityRepository.getPrivateKey(
            accessMessage: anyNamed('accessMessage'),
            secret: anyNamed('secret')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.privateKey));
    when(createAndSaveIdentityUseCase.execute(param: anyNamed('param')))
        .thenAnswer(
            (realInvocation) => Future.value(IdentityMocks.privateIdentity));
  });

  test(
      "Given a secret, when I call execute, then I expect an identity to be returned",
      () async {
    // When
    expect(await useCase.execute(param: paramSecret),
        IdentityMocks.privateIdentity);

    // Then
    var configCaptured = verify(identityRepository.getPrivateKey(
      accessMessage: captureAnyNamed('accessMessage'),
      secret: captureAnyNamed('secret'),
    )).captured;
    expect(configCaptured[0], CommonMocks.config);
    expect(configCaptured[1], CommonMocks.message);

    var capturedCreate = verify(createAndSaveIdentityUseCase.execute(
            param: captureAnyNamed('param')))
        .captured
        .first;
    expect(capturedCreate.privateKey, CommonMocks.privateKey);
    expect(capturedCreate.blockchain, CommonMocks.blockchain);
    expect(capturedCreate.network, CommonMocks.network);
  });

  test(
      "Given a private key which is null, when I call execute, then I expect an identifier to be returned",
      () async {
    // When
    expect(await useCase.execute(param: param), IdentityMocks.privateIdentity);

    // Then
    var configCaptured = verify(identityRepository.getPrivateKey(
      accessMessage: captureAnyNamed('accessMessage'),
      secret: captureAnyNamed('secret'),
    )).captured;
    expect(configCaptured[0], CommonMocks.config);
    expect(configCaptured[1], null);

    var capturedCreate = verify(createAndSaveIdentityUseCase.execute(
            param: captureAnyNamed('param')))
        .captured
        .first;
    expect(capturedCreate.privateKey, CommonMocks.privateKey);
    expect(capturedCreate.blockchain, CommonMocks.blockchain);
    expect(capturedCreate.network, CommonMocks.network);
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
    await expectLater(
        useCase.execute(param: paramSecret), throwsA(CommonMocks.exception));

    // Then
    var configCaptured = verify(identityRepository.getPrivateKey(
      accessMessage: captureAnyNamed('accessMessage'),
      secret: captureAnyNamed('secret'),
    )).captured;
    expect(configCaptured[0], CommonMocks.config);
    expect(configCaptured[1], CommonMocks.message);

    verifyNever(
        createAndSaveIdentityUseCase.execute(param: captureAnyNamed('param')));
  });
}
