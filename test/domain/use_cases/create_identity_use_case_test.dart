import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/domain/identity/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/domain/identity/use_cases/create_identity_use_case.dart';

import 'create_identity_use_case_test.mocks.dart';

// Data
const privateKey = "thePrivateKey";
const walletPrivateKey = "theWalletPrivateKey";
const identifier = "theIdentifier";
const authClaim = "theAuthClaim";
var exception = Exception();

// Dependencies
MockIdentityRepository identityRepository = MockIdentityRepository();

// Tested instance
CreateIdentityUseCase useCase = CreateIdentityUseCase(identityRepository);

@GenerateMocks([IdentityRepository])
void main() {
  test(
      "Given a private key, when I call execute, then I expect an identifier to be returned",
      () async {
    // Given
    when(identityRepository.createIdentity(privateKey: anyNamed('privateKey')))
        .thenAnswer((realInvocation) => Future.value(identifier));

    // When
    expect(await useCase.execute(param: privateKey), identifier);

    // Then
    expect(
        verify(identityRepository.createIdentity(
                privateKey: captureAnyNamed('privateKey')))
            .captured
            .first,
        privateKey);
  });

  test(
      "Given a private key which is null, when I call execute, then I expect an identifier to be returned",
      () async {
    // Given
    when(identityRepository.createIdentity(privateKey: anyNamed('privateKey')))
        .thenAnswer((realInvocation) => Future.value(identifier));

    // When
    expect(await useCase.execute(), identifier);

    // Then
    expect(
        verify(identityRepository.createIdentity(
                privateKey: captureAnyNamed('privateKey')))
            .captured
            .first,
        null);
  });

  test(
      "Given a private key, when I call execute and an error occured, then I expect an exception to be thrown",
      () async {
    // Given
    when(identityRepository.createIdentity(privateKey: anyNamed('privateKey')))
        .thenAnswer((realInvocation) => Future.error(exception));

    // When
    await expectLater(useCase.execute(param: privateKey), throwsA(exception));

    // Then
    expect(
        verify(identityRepository.createIdentity(
                privateKey: captureAnyNamed('privateKey')))
            .captured
            .first,
        privateKey);
  });
}
