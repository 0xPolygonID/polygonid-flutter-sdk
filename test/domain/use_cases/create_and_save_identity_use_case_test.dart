import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_config_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/create_and_save_identity_use_case.dart';

import '../../common/common_mocks.dart';
import 'create_and_save_identity_use_case_test.mocks.dart';

// Data
final privateIdentity = PrivateIdentityEntity(
    privateKey: CommonMocks.privateKey,
    did: CommonMocks.identifier,
    publicKey: CommonMocks.pubKeys);
var exception = Exception();

// Dependencies
MockIdentityRepository identityRepository = MockIdentityRepository();
MockGetEnvConfigUseCase getEnvConfigUseCase = MockGetEnvConfigUseCase();

// Tested instance
CreateAndSaveIdentityUseCase useCase =
    CreateAndSaveIdentityUseCase(identityRepository, getEnvConfigUseCase);

@GenerateMocks([IdentityRepository, GetEnvConfigUseCase])
void main() {
  setUp(() {
    // Given
    when(getEnvConfigUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.config));
    when(identityRepository.createIdentity(
            secret: anyNamed('secret'),
            accessMessage: anyNamed('accessMessage')))
        .thenAnswer((realInvocation) => Future.value(privateIdentity));
    when(identityRepository.getIdentity(did: anyNamed('identifier')))
        .thenAnswer((realInvocation) =>
            Future.error(UnknownIdentityException(CommonMocks.identifier)));
  });

  test(
      "Given a private key which is not already associated with an identity, when I call execute, then I expect an identity to be returned",
      () async {
    // When
    expect(
        await useCase.execute(param: CommonMocks.privateKey), privateIdentity);

    // Then
    var configCaptured = verify(identityRepository.createIdentity(
            secret: captureAnyNamed('secret'),
            accessMessage: captureAnyNamed('accessMessage')))
        .captured;
    expect(configCaptured[0], CommonMocks.privateKey);
    expect(configCaptured[1], CommonMocks.config);

    expect(
        verify(identityRepository.getIdentity(
                did: captureAnyNamed('identifier')))
            .captured
            .first,
        CommonMocks.identifier);

    var capturedStore = verify(identityRepository.storeIdentity(
            identity: captureAnyNamed('identity'),
            privateKey: captureAnyNamed('privateKey')))
        .captured;
    expect(capturedStore[0], privateIdentity);
    expect(capturedStore[1], CommonMocks.privateKey);
  });

  test(
      "Given a private key which is null, when I call execute, then I expect an identifier to be returned",
      () async {
    // When
    expect(await useCase.execute(param: null), privateIdentity);

    // Then
    var configCaptured = verify(identityRepository.createIdentity(
            secret: captureAnyNamed('secret'),
            accessMessage: captureAnyNamed('accessMessage')))
        .captured;
    expect(configCaptured[0], null);
    expect(configCaptured[1], CommonMocks.config);

    expect(
        verify(identityRepository.getIdentity(
                did: captureAnyNamed('identifier')))
            .captured
            .first,
        CommonMocks.identifier);

    var capturedStore = verify(identityRepository.storeIdentity(
            identity: captureAnyNamed('identity'),
            privateKey: captureAnyNamed('privateKey')))
        .captured;
    expect(capturedStore[0], privateIdentity);
    expect(capturedStore[1], CommonMocks.privateKey);
  });

  test(
      "Given a private key and with an associated identity, when I call execute, then I expect an IdentityAlreadyExistsException to be thrown",
      () async {
    // Given
    when(identityRepository.getIdentity(did: anyNamed('identifier')))
        .thenAnswer((realInvocation) => Future.value(privateIdentity));

    // When
    await useCase
        .execute(param: CommonMocks.privateKey)
        .then((_) => null)
        .catchError((error) {
      expect(error, isA<IdentityAlreadyExistsException>());
      expect(error.did, privateIdentity.did);
    });

    // Then
    var configCaptured = verify(identityRepository.createIdentity(
            secret: captureAnyNamed('secret'),
            accessMessage: captureAnyNamed('accessMessage')))
        .captured;
    expect(configCaptured[0], CommonMocks.privateKey);
    expect(configCaptured[1], CommonMocks.config);

    expect(
        verify(identityRepository.getIdentity(
                did: captureAnyNamed('identifier')))
            .captured
            .first,
        CommonMocks.identifier);

    verifyNever(identityRepository.storeIdentity(
        identity: captureAnyNamed('identity'),
        privateKey: captureAnyNamed('privateKey')));
  });

  test(
      "Given a private key, when I call execute and an error occured, then I expect an exception to be thrown",
      () async {
    // Given
    when(identityRepository.getIdentity(did: anyNamed('identifier')))
        .thenAnswer((realInvocation) => Future.error(exception));

    // When
    await expectLater(
        useCase.execute(param: CommonMocks.privateKey), throwsA(exception));

    // Then
    var configCaptured = verify(identityRepository.createIdentity(
            secret: captureAnyNamed('secret'),
            accessMessage: captureAnyNamed('accessMessage')))
        .captured;
    expect(configCaptured[0], CommonMocks.privateKey);
    expect(configCaptured[1], CommonMocks.config);

    expect(
        verify(identityRepository.getIdentity(
                did: captureAnyNamed('identifier')))
            .captured
            .first,
        CommonMocks.identifier);

    verifyNever(identityRepository.storeIdentity(
        identity: captureAnyNamed('identity'),
        privateKey: captureAnyNamed('privateKey')));
  });
}
