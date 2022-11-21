import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_token_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof_generation/domain/repositories/proof_repository.dart';

import 'get_auth_token_use_case_test.mocks.dart';

// Data
const message = "theMessage";
const identifier = "theIdentifier";
const privateKey = "thePrivateKey";
const authClaim = "theAuthClaim";
const pubKeys = ["pubX", "pubY"];
const privateIdentity = PrivateIdentityEntity(
    privateKey: privateKey, identifier: identifier, publicKey: pubKeys);
const circuitId = "1";
final datFile = Uint8List(32);
final zKeyFile = Uint8List(32);
final circuitData = CircuitDataEntity(circuitId, datFile, zKeyFile);
final param = GetAuthTokenParam(identifier, privateKey, message);
const result = "token";
var exception = Exception();

// Dependencies
MockIden3commRepository iden3commRepository = MockIden3commRepository();
MockCredentialRepository credentialRepository = MockCredentialRepository();
MockProofRepository proofRepository = MockProofRepository();
MockIdentityRepository identityRepository = MockIdentityRepository();

// Tested instance
GetAuthTokenUseCase useCase = GetAuthTokenUseCase(iden3commRepository,
    proofRepository, credentialRepository, identityRepository);

@GenerateMocks([
  Iden3commRepository,
  CredentialRepository,
  ProofRepository,
  IdentityRepository
])
void main() {
  setUp(() {
    // Given
    when(identityRepository.getPrivateIdentity(
            identifier: anyNamed('identifier'),
            privateKey: anyNamed('privateKey')))
        .thenAnswer((realInvocation) => Future.value(privateIdentity));
    when(proofRepository.loadCircuitFiles(any))
        .thenAnswer((realInvocation) => Future.value(circuitData));
    when(credentialRepository.getAuthClaim(identity: anyNamed('identity')))
        .thenAnswer((realInvocation) => Future.value(authClaim));
    when(iden3commRepository.getAuthToken(
            identity: anyNamed('identity'),
            message: anyNamed('message'),
            authData: anyNamed('authData'),
            authClaim: anyNamed('authClaim')))
        .thenAnswer((realInvocation) => Future.value(result));
  });

  test(
      "Given an identifier and a message, when I call execute, then I expect a String to be returned",
      () async {
    // When
    expect(await useCase.execute(param: param), result);

    // Then
    var identityCaptured = verify(identityRepository.getPrivateIdentity(
            identifier: captureAnyNamed('identifier'),
            privateKey: captureAnyNamed('privateKey')))
        .captured;
    expect(identityCaptured[0], identifier);
    expect(identityCaptured[1], privateKey);

    expect(verify(proofRepository.loadCircuitFiles(captureAny)).captured.first,
        "auth");

    expect(
        verify(credentialRepository.getAuthClaim(
                identity: captureAnyNamed('identity')))
            .captured
            .first,
        privateIdentity);

    var authCaptured = verify(iden3commRepository.getAuthToken(
            identity: captureAnyNamed('identity'),
            message: captureAnyNamed('message'),
            authData: captureAnyNamed('authData'),
            authClaim: captureAnyNamed('authClaim')))
        .captured;
    expect(authCaptured[0], privateIdentity);
    expect(authCaptured[1], message);
    expect(authCaptured[2], circuitData);
    expect(authCaptured[3], authClaim);
  });

  test(
      "Given an identifier and a message, when I call execute and an error occurred, then I expect an exception to be thrown",
      () async {
    // Given
    when(credentialRepository.getAuthClaim(identity: anyNamed('identity')))
        .thenAnswer((realInvocation) => Future.error(exception));

    // When
    await expectLater(useCase.execute(param: param), throwsA(exception));

    // Then
    var identityCaptured = verify(identityRepository.getPrivateIdentity(
            identifier: captureAnyNamed('identifier'),
            privateKey: captureAnyNamed('privateKey')))
        .captured;
    expect(identityCaptured[0], identifier);
    expect(identityCaptured[1], privateKey);

    expect(verify(proofRepository.loadCircuitFiles(captureAny)).captured.first,
        "auth");

    expect(
        verify(credentialRepository.getAuthClaim(
                identity: captureAnyNamed('identity')))
            .captured
            .first,
        privateIdentity);

    verifyNever(iden3commRepository.getAuthToken(
        identity: captureAnyNamed('identity'),
        message: captureAnyNamed('message'),
        authData: captureAnyNamed('authData'),
        authClaim: captureAnyNamed('authClaim')));
  });
}
