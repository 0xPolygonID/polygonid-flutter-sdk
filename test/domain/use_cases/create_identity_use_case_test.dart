import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/domain/identity/entities/identity.dart';
import 'package:polygonid_flutter_sdk/domain/identity/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/domain/identity/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/domain/identity/use_cases/create_identity_use_case.dart';

import 'create_identity_use_case_test.mocks.dart';

// Data
const privateKey = "thePrivateKey";
const walletPrivateKey = "theWalletPrivateKey";
const identifier = "theIdentifier";
const authClaim = "theAuthClaim";
const mockEntity = Identity(
    privateKey: privateKey, identifier: identifier, authClaim: authClaim);
var exception = Exception();

// Dependencies
MockIdentityRepository identityRepository = MockIdentityRepository();

// Tested instance
CreateIdentityUseCase useCase = CreateIdentityUseCase(identityRepository);

@GenerateMocks([IdentityRepository])
void main() {
  setUp(() {
    // Given
    when(identityRepository.getIdentifier(privateKey: anyNamed('privateKey')))
        .thenAnswer((realInvocation) => Future.value(identifier));
    when(identityRepository.createIdentity(privateKey: anyNamed('privateKey')))
        .thenAnswer((realInvocation) => Future.value(identifier));
    when(identityRepository.getIdentity(identifier: anyNamed('identifier')))
        .thenAnswer((realInvocation) =>
            Future.error(UnknownIdentityException(identifier)));
  });

  test(
      "Given a private key and with associated identity, when I call execute, then I expect an identifier to be returned",
      () async {
    // When
    expect(await useCase.execute(param: privateKey), identifier);

    // Then
    expect(
        verify(identityRepository.getIdentifier(
                privateKey: captureAnyNamed('privateKey')))
            .captured
            .first,
        privateKey);
    expect(
        verify(identityRepository.getIdentity(
                identifier: captureAnyNamed('identifier')))
            .captured
            .first,
        identifier);
    expect(
        verify(identityRepository.createIdentity(
                privateKey: captureAnyNamed('privateKey')))
            .captured
            .first,
        privateKey);
  });

  test(
      "Given a private key which is null with no associated identity, when I call execute, then I expect an identifier to be returned",
      () async {
    // When
    expect(await useCase.execute(), identifier);

    // Then
    expect(
        verify(identityRepository.getIdentifier(
                privateKey: captureAnyNamed('privateKey')))
            .captured
            .first,
        null);
    expect(
        verify(identityRepository.getIdentity(
                identifier: captureAnyNamed('identifier')))
            .captured
            .first,
        identifier);
    expect(
        verify(identityRepository.createIdentity(
                privateKey: captureAnyNamed('privateKey')))
            .captured
            .first,
        null);
  });

  test(
      "Given a private key and with an associated identity, when I call execute, then I expect an identifier to be returned",
      () async {
    // Given
    when(identityRepository.getIdentity(identifier: anyNamed('identifier')))
        .thenAnswer((realInvocation) => Future.value(mockEntity));

    // When
    expect(await useCase.execute(param: privateKey), identifier);

    // Then
    expect(
        verify(identityRepository.getIdentifier(
                privateKey: captureAnyNamed('privateKey')))
            .captured
            .first,
        privateKey);
    expect(
        verify(identityRepository.getIdentity(
                identifier: captureAnyNamed('identifier')))
            .captured
            .first,
        identifier);
    verifyNever(identityRepository.createIdentity(
            privateKey: captureAnyNamed('privateKey')))
        .captured;
  });

  test(
      "Given a private key, when I call execute and an error occured, then I expect an exception to be thrown",
      () async {
    // Given
    when(identityRepository.getIdentifier(privateKey: anyNamed('privateKey')))
        .thenAnswer((realInvocation) => Future.error(exception));

    // When
    await expectLater(useCase.execute(param: privateKey), throwsA(exception));

    // Then
    expect(
        verify(identityRepository.getIdentifier(
                privateKey: captureAnyNamed('privateKey')))
            .captured
            .first,
        privateKey);
    verifyNever(identityRepository.getIdentity(
        identifier: captureAnyNamed('identifier')));
    verifyNever(identityRepository.createIdentity(
        privateKey: captureAnyNamed('privateKey')));
  });
}
