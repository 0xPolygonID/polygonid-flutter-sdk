import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/domain/identity/entities/identity.dart';
import 'package:polygonid_flutter_sdk/domain/identity/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/domain/identity/use_cases/get_identity_use_case.dart';

import 'get_identity_use_case_test.mocks.dart';

// Data
const privateKey = "thePrivateKey";
const identifier = "theIdentifier";
const authClaim = "theAuthClaim";
const result = Identity(identifier: identifier, authClaim: authClaim);
var exception = Exception();

// Dependencies
MockIdentityRepository identityRepository = MockIdentityRepository();

// Tested instance
GetIdentityUseCase useCase = GetIdentityUseCase(identityRepository);

@GenerateMocks([IdentityRepository])
void main() {
  test(
      "Given a private key, when I call execute, then I expect an Identity to be returned",
      () async {
    // Given
    when(identityRepository.createIdentity(privateKey: anyNamed('privateKey')))
        .thenAnswer((realInvocation) => Future.value(result));

    // When
    expect(await useCase.execute(param: privateKey), result);

    // Then
    expect(
        verify(identityRepository.createIdentity(
                privateKey: captureAnyNamed('privateKey')))
            .captured
            .first,
        privateKey);
  });

  test(
      "Given a private key which is null, when I call execute, then I expect an Identity to be returned",
      () async {
    // Given
    when(identityRepository.createIdentity(privateKey: anyNamed('privateKey')))
        .thenAnswer((realInvocation) => Future.value(result));

    // When
    expect(await useCase.execute(), isA<Identity>());

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
