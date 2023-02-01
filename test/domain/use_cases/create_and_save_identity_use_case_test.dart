import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/create_and_save_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';

import '../../common/common_mocks.dart';
import '../../common/identity_mocks.dart';
import 'create_and_save_identity_use_case_test.mocks.dart';

// Data
final privateIdentity = PrivateIdentityEntity(
  privateKey: CommonMocks.privateKey,
  did: CommonMocks.did,
  publicKey: CommonMocks.pubKeys,
  profiles: CommonMocks.profiles,
);
var exception = Exception();
var param = CreateAndSaveIdentityParam(
    blockchain: CommonMocks.blockchain, network: CommonMocks.network);
var paramSecret = CreateAndSaveIdentityParam(
    secret: CommonMocks.privateKey,
    blockchain: CommonMocks.blockchain,
    network: CommonMocks.network);

// Dependencies
MockIdentityRepository identityRepository = MockIdentityRepository();
MockGetDidUseCase getDidUseCase = MockGetDidUseCase();
MockGetDidIdentifierUseCase getDidIdentifierUseCase =
    MockGetDidIdentifierUseCase();

// Tested instance
CreateAndSaveIdentityUseCase useCase = CreateAndSaveIdentityUseCase(
  CommonMocks.config,
  identityRepository,
  getDidUseCase,
  getDidIdentifierUseCase,
);

@GenerateMocks([
  IdentityRepository,
  GetDidUseCase,
  GetDidIdentifierUseCase,
])
void main() {
  setUp(() {
    // Given
    when(identityRepository.createIdentity(
      secret: anyNamed('secret'),
      accessMessage: anyNamed('accessMessage'),
      blockchain: anyNamed('blockchain'),
      network: anyNamed('network'),
    )).thenAnswer((realInvocation) => Future.value(privateIdentity));
    when(identityRepository.getIdentity(did: anyNamed('did'))).thenAnswer(
        (realInvocation) =>
            Future.error(UnknownIdentityException(CommonMocks.identifier)));
    when(getDidUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(IdentityMocks.did));
    when(getDidIdentifierUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.did));
  });

  test(
      "Given a private key which is not already associated with an identity, when I call execute, then I expect an identity to be returned",
      () async {
    // When
    expect(await useCase.execute(param: paramSecret), privateIdentity);

    // Then
    var configCaptured = verify(identityRepository.createIdentity(
      secret: captureAnyNamed('secret'),
      accessMessage: captureAnyNamed('accessMessage'),
      blockchain: captureAnyNamed('blockchain'),
      network: captureAnyNamed('network'),
    )).captured;
    expect(configCaptured[0], CommonMocks.privateKey);
    expect(configCaptured[1], CommonMocks.config);
    expect(configCaptured[2], CommonMocks.blockchain);
    expect(configCaptured[3], CommonMocks.network);

    expect(
        verify(identityRepository.getIdentity(did: captureAnyNamed('did')))
            .captured
            .first,
        CommonMocks.did);

    var capturedStore = verify(identityRepository.storeIdentity(
            identity: captureAnyNamed('identity')))
        .captured;
    expect(capturedStore[0], privateIdentity);
  });

  test(
      "Given a private key which is null, when I call execute, then I expect an identifier to be returned",
      () async {
    // When
    expect(await useCase.execute(param: param), privateIdentity);

    // Then
    var configCaptured = verify(identityRepository.createIdentity(
      secret: captureAnyNamed('secret'),
      accessMessage: captureAnyNamed('accessMessage'),
      blockchain: captureAnyNamed('blockchain'),
      network: captureAnyNamed('network'),
    )).captured;
    expect(configCaptured[0], null);
    expect(configCaptured[1], CommonMocks.config);
    expect(configCaptured[2], CommonMocks.blockchain);
    expect(configCaptured[3], CommonMocks.network);

    expect(
        verify(identityRepository.getIdentity(did: captureAnyNamed('did')))
            .captured
            .first,
        CommonMocks.did);

    var capturedStore = verify(identityRepository.storeIdentity(
            identity: captureAnyNamed('identity')))
        .captured;
    expect(capturedStore[0], privateIdentity);
  });

  test(
      "Given a private key and with an associated identity, when I call execute, then I expect an IdentityAlreadyExistsException to be thrown",
      () async {
    // Given
    when(identityRepository.getIdentity(did: anyNamed('did')))
        .thenAnswer((realInvocation) => Future.value(privateIdentity));

    // When
    await useCase
        .execute(param: paramSecret)
        .then((_) => null)
        .catchError((error) {
      expect(error, isA<IdentityAlreadyExistsException>());
      expect(error.did, privateIdentity.did);
    });

    // Then
    var configCaptured = verify(identityRepository.createIdentity(
      secret: captureAnyNamed('secret'),
      accessMessage: captureAnyNamed('accessMessage'),
      blockchain: captureAnyNamed('blockchain'),
      network: captureAnyNamed('network'),
    )).captured;
    expect(configCaptured[0], CommonMocks.privateKey);
    expect(configCaptured[1], CommonMocks.config);
    expect(configCaptured[2], CommonMocks.blockchain);
    expect(configCaptured[3], CommonMocks.network);

    expect(
        verify(identityRepository.getIdentity(did: captureAnyNamed('did')))
            .captured
            .first,
        CommonMocks.did);

    verifyNever(identityRepository.storeIdentity(
        identity: captureAnyNamed('identity')));
  });

  test(
      "Given a private key, when I call execute and an error occurred, then I expect an exception to be thrown",
      () async {
    // Given
    when(identityRepository.getIdentity(did: anyNamed('did')))
        .thenAnswer((realInvocation) => Future.error(exception));

    // When
    await expectLater(useCase.execute(param: paramSecret), throwsA(exception));

    // Then
    var configCaptured = verify(identityRepository.createIdentity(
      secret: captureAnyNamed('secret'),
      accessMessage: captureAnyNamed('accessMessage'),
      blockchain: captureAnyNamed('blockchain'),
      network: captureAnyNamed('network'),
    )).captured;
    expect(configCaptured[0], CommonMocks.privateKey);
    expect(configCaptured[1], CommonMocks.config);
    expect(configCaptured[2], CommonMocks.blockchain);
    expect(configCaptured[3], CommonMocks.network);

    expect(
        verify(identityRepository.getIdentity(did: captureAnyNamed('did')))
            .captured
            .first,
        CommonMocks.did);

    verifyNever(identityRepository.storeIdentity(
        identity: captureAnyNamed('identity')));
  });
}
