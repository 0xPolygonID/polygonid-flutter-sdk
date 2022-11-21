import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/create_and_save_identity_use_case.dart';

import 'create_and_save_identity_use_case_test.mocks.dart';

// Data
const privateKey = "thePrivateKey";
const walletPrivateKey = "theWalletPrivateKey";
const identifier = "theIdentifier";
const pubKeys = ["pubX", "pubY"];
const smt = "theSmt";
const privateIdentity = PrivateIdentityEntity(
    privateKey: privateKey, identifier: identifier, publicKey: pubKeys);
var exception = Exception();

// Dependencies
MockIdentityRepository identityRepository = MockIdentityRepository();

// Tested instance
CreateAndSaveIdentityUseCase useCase =
    CreateAndSaveIdentityUseCase(identityRepository);

@GenerateMocks([IdentityRepository])
void main() {
  setUp(() {
    // Given
    when(identityRepository.createIdentity(secret: anyNamed('secret')))
        .thenAnswer((realInvocation) => Future.value(privateIdentity));
    when(identityRepository.getIdentity(identifier: anyNamed('identifier')))
        .thenAnswer((realInvocation) =>
            Future.error(UnknownIdentityException(identifier)));
  });

  test(
      "Given a private key which is not already associated with an identity, when I call execute, then I expect an identity to be returned",
      () async {
    // When
    expect(await useCase.execute(param: privateKey), privateIdentity);

    // Then
    expect(
        verify(identityRepository.createIdentity(
                secret: captureAnyNamed('secret')))
            .captured
            .first,
        privateKey);
    expect(
        verify(identityRepository.getIdentity(
                identifier: captureAnyNamed('identifier')))
            .captured
            .first,
        identifier);

    var capturedStore = verify(identityRepository.storeIdentity(
            identity: captureAnyNamed('identity'),
            privateKey: captureAnyNamed('privateKey')))
        .captured;
    expect(capturedStore[0], privateIdentity);
    expect(capturedStore[1], privateKey);
  });

  test(
      "Given a private key which is null, when I call execute, then I expect an identifier to be returned",
      () async {
    // When
    expect(await useCase.execute(param: null), privateIdentity);

    // Then
    expect(
        verify(identityRepository.createIdentity(
                secret: captureAnyNamed('secret')))
            .captured
            .first,
        null);
    expect(
        verify(identityRepository.getIdentity(
                identifier: captureAnyNamed('identifier')))
            .captured
            .first,
        identifier);
    var capturedStore = verify(identityRepository.storeIdentity(
            identity: captureAnyNamed('identity'),
            privateKey: captureAnyNamed('privateKey')))
        .captured;
    expect(capturedStore[0], privateIdentity);
    expect(capturedStore[1], privateKey);
  });

  test(
      "Given a private key and with an associated identity, when I call execute, then I expect an IdentityAlreadyExistsException to be thrown",
      () async {
    // Given
    when(identityRepository.getIdentity(identifier: anyNamed('identifier')))
        .thenAnswer((realInvocation) => Future.value(privateIdentity));

    // When
    await useCase
        .execute(param: privateKey)
        .then((_) => null)
        .catchError((error) {
      expect(error, isA<IdentityAlreadyExistsException>());
      expect(error.identifier, privateIdentity.identifier);
    });

    // Then
    expect(
        verify(identityRepository.createIdentity(
                secret: captureAnyNamed('secret')))
            .captured
            .first,
        privateKey);
    expect(
        verify(identityRepository.getIdentity(
                identifier: captureAnyNamed('identifier')))
            .captured
            .first,
        identifier);
    verifyNever(identityRepository.storeIdentity(
        identity: captureAnyNamed('identity'),
        privateKey: captureAnyNamed('privateKey')));
  });

  test(
      "Given a private key, when I call execute and an error occured, then I expect an exception to be thrown",
      () async {
    // Given
    when(identityRepository.getIdentity(identifier: anyNamed('identifier')))
        .thenAnswer((realInvocation) => Future.error(exception));

    // When
    await expectLater(useCase.execute(param: privateKey), throwsA(exception));

    // Then
    expect(
        verify(identityRepository.createIdentity(
                secret: captureAnyNamed('secret')))
            .captured
            .first,
        privateKey);
    expect(
        verify(identityRepository.getIdentity(
                identifier: captureAnyNamed('identifier')))
            .captured
            .first,
        identifier);
    verifyNever(identityRepository.storeIdentity(
        identity: captureAnyNamed('identity'),
        privateKey: captureAnyNamed('privateKey')));
  });
}
