import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/create_and_save_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_identity_auth_claim_use_case.dart';

import '../../common/common_mocks.dart';
import '../../common/credential_mocks.dart';
import '../../common/identity_mocks.dart';
import 'create_and_save_identity_use_case_test.mocks.dart';

// Data
var exception = Exception();
var param = CreateAndSaveIdentityParam(
    privateKey: CommonMocks.privateKey,
    blockchain: CommonMocks.blockchain,
    network: CommonMocks.network);

// Dependencies
MockIdentityRepository identityRepository = MockIdentityRepository();
MockGetDidUseCase getDidUseCase = MockGetDidUseCase();
MockGetDidIdentifierUseCase getDidIdentifierUseCase =
    MockGetDidIdentifierUseCase();
MockGetIdentityAuthClaimUseCase getIdentityAuthClaimUseCase =
    MockGetIdentityAuthClaimUseCase();

// Tested instance
CreateAndSaveIdentityUseCase useCase = CreateAndSaveIdentityUseCase(
  identityRepository,
  getDidUseCase,
  getDidIdentifierUseCase,
  getIdentityAuthClaimUseCase,
);

@GenerateMocks([
  IdentityRepository,
  GetDidUseCase,
  GetDidIdentifierUseCase,
  GetIdentityAuthClaimUseCase,
])
void main() {
  setUp(() {
    // Given
    when(identityRepository.getPrivateKey(
            accessMessage: anyNamed('accessMessage'),
            secret: anyNamed('secret')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.privateKey));
    when(identityRepository.createIdentity(
      privateKey: anyNamed('privateKey'),
      didIdentifier: anyNamed('didIdentifier'),
      authClaim: anyNamed('authClaim'),
    )).thenAnswer((realInvocation) => Future.value(IdentityMocks.identity));
    when(identityRepository.getIdentity(did: anyNamed('did'))).thenAnswer(
        (realInvocation) =>
            Future.error(UnknownIdentityException(CommonMocks.identifier)));
    when(getDidUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(IdentityMocks.did));
    when(getDidIdentifierUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.did));
    when(getIdentityAuthClaimUseCase.execute(param: anyNamed('param')))
        .thenAnswer(
            (realInvocation) => Future.value(CredentialMocks.authClaim));
  });

  test(
      "Given a private key which is not already associated with an identity, when I call execute, then I expect an identity to be returned",
      () async {
    // When
    expect(await useCase.execute(param: param), IdentityMocks.privateIdentity);

    // Then
    var configCaptured = verify(identityRepository.createIdentity(
      privateKey: captureAnyNamed('privateKey'),
      didIdentifier: captureAnyNamed('didIdentifier'),
      authClaim: captureAnyNamed('authClaim'),
    )).captured;
    expect(configCaptured[0], CommonMocks.privateKey);
    expect(configCaptured[1], CommonMocks.did);
    expect(configCaptured[2], CredentialMocks.authClaim);

    expect(
        verify(identityRepository.getIdentity(did: captureAnyNamed('did')))
            .captured
            .first,
        CommonMocks.did);

    var capturedStore = verify(identityRepository.storeIdentity(
            identity: captureAnyNamed('identity')))
        .captured;
    expect(capturedStore[0], IdentityMocks.privateIdentity);
  });

  test(
      "Given a private key and with an associated identity, when I call execute, then I expect an IdentityAlreadyExistsException to be thrown",
      () async {
    // Given
    when(identityRepository.getIdentity(did: anyNamed('did'))).thenAnswer(
        (realInvocation) => Future.value(IdentityMocks.privateIdentity));

    // When
    await useCase.execute(param: param).then((_) => null).catchError((error) {
      expect(error, isA<IdentityAlreadyExistsException>());
      expect(error.did, IdentityMocks.identity.did);
    });

    // Then
    var configCaptured = verify(identityRepository.createIdentity(
      privateKey: captureAnyNamed('privateKey'),
      didIdentifier: captureAnyNamed('didIdentifier'),
      authClaim: captureAnyNamed('authClaim'),
    )).captured;
    expect(configCaptured[0], CommonMocks.privateKey);
    expect(configCaptured[1], CommonMocks.did);
    expect(configCaptured[2], CredentialMocks.authClaim);

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
    await expectLater(useCase.execute(param: param), throwsA(exception));

    // Then
    var configCaptured = verify(identityRepository.createIdentity(
      privateKey: captureAnyNamed('privateKey'),
      didIdentifier: captureAnyNamed('didIdentifier'),
      authClaim: captureAnyNamed('authClaim'),
    )).captured;
    expect(configCaptured[0], CommonMocks.privateKey);
    expect(configCaptured[1], CommonMocks.did);
    expect(configCaptured[2], CredentialMocks.authClaim);

    expect(
        verify(identityRepository.getIdentity(did: captureAnyNamed('did')))
            .captured
            .first,
        CommonMocks.did);

    verifyNever(identityRepository.storeIdentity(
        identity: captureAnyNamed('identity')));
  });
}
