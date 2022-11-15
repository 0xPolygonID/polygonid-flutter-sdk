import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/remove_claims_use_case.dart';

import 'get_claims_use_case_test.mocks.dart';

// Data
const identifier = "theIdentifier";
const privateKey = "thePrivateKey";
const ids = ["theId", "theId1", "theId2"];
final param = RemoveClaimsParam(
    claimIds: ids, identifier: identifier, privateKey: privateKey);
final exception = Exception();

// Dependencies
MockCredentialRepository credentialRepository = MockCredentialRepository();

// Tested instance
RemoveClaimsUseCase useCase = RemoveClaimsUseCase(credentialRepository);

@GenerateMocks([CredentialRepository])
void main() {
  group("Remove claims", () {
    setUp(() {
      reset(credentialRepository);

      // Given
      when(credentialRepository.removeClaims(
              identifier: identifier,
              privateKey: privateKey,
              claimIds: anyNamed("claimIds")))
          .thenAnswer((realInvocation) => Future.value());
    });

    test(
        "Given a list of ids, when I call execute, then I expect the process to complete",
        () async {
      // When
      await expectLater(useCase.execute(param: param), completes);

      // Then
      var capturedRemove = verify(credentialRepository.removeClaims(
              identifier: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              claimIds: captureAnyNamed('claimIds')))
          .captured;
      expect(capturedRemove[0], identifier);
      expect(capturedRemove[1], privateKey);
      expect(capturedRemove[2], ids);
    });

    test(
        "Given a list of ids, when I call execute and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(credentialRepository.removeClaims(
              identifier: identifier,
              privateKey: privateKey,
              claimIds: anyNamed("claimIds")))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(useCase.execute(param: param), throwsA(exception));

      // Then
      var capturedRemove = verify(credentialRepository.removeClaims(
              identifier: captureAnyNamed('identifier'),
              privateKey: captureAnyNamed('privateKey'),
              claimIds: captureAnyNamed('claimIds')))
          .captured;
      expect(capturedRemove[0], identifier);
      expect(capturedRemove[1], privateKey);
      expect(capturedRemove[2], ids);
    });
  });
}
