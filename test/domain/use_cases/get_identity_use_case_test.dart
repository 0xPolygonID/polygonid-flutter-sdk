import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:privadoid_sdk/domain/common/tuples.dart';
import 'package:privadoid_sdk/domain/repositories/identity_repository.dart';
import 'package:privadoid_sdk/domain/use_cases/get_identity_use_case.dart';

import 'get_identity_use_case_test.mocks.dart';

// Data
const key = "theKey";
final mockResult = Pair<String, String>("theResult1", "theResult2");
var exception = Exception();

// Dependencies
MockIdentityRepository identityRepository = MockIdentityRepository();

// Tested instance
GetIdentityUseCase useCase = GetIdentityUseCase(identityRepository);

@GenerateMocks([IdentityRepository])
void main() {
  test(
      "Given a seed phrase, when I call execute, then I expect a private key and an identity to be returned (as a Pair)",
      () async {
    // Given
    when(identityRepository.getIdentity(key: anyNamed('seedPhrase')))
        .thenAnswer((realInvocation) => Future.value(mockResult));

    // When
    expect(await useCase.execute(param: key), mockResult);

    // Then
    expect(
        verify(identityRepository.getIdentity(
                key: captureAnyNamed('seedPhrase')))
            .captured
            .first,
        key);
  });

  test(
      "Given a seed phrase which is null, when I call execute, then I expect a private key and an identity to be returned (as a Pair)",
      () async {
    // Given
    when(identityRepository.getIdentity(key: anyNamed('seedPhrase')))
        .thenAnswer((realInvocation) => Future.value(mockResult));

    // When
    expect(await useCase.execute(param: null), mockResult);

    // Then
    expect(
        verify(identityRepository.getIdentity(
                key: captureAnyNamed('seedPhrase')))
            .captured
            .first,
        null);
  });

  test(
      "Given a seed phrase, when I call getIdentity and an error occured, then I expect an error to be thrown",
      () async {
    // Given
    when(identityRepository.getIdentity(key: anyNamed('seedPhrase')))
        .thenAnswer((realInvocation) => Future.error(exception));

    // When
    await expectLater(useCase.execute(param: key), throwsA(exception));

    // Then
    expect(
        verify(identityRepository.getIdentity(
                key: captureAnyNamed('seedPhrase')))
            .captured
            .first,
        key);
  });
}
