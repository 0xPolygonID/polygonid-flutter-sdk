import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/import_claims_use_case.dart';

import 'import_claims_use_case_test.mocks.dart';

const privateKey = "thePrivateKey";
const identifier = "theIdentifier";
const claimsToBeImported = "theClaimsToBeImported";

ImportClaimsParam param = ImportClaimsParam(
  privateKey: privateKey,
  did: identifier,
  encryptedClaimsDb: claimsToBeImported,
);

MockCredentialRepository credentialRepository = MockCredentialRepository();

// Tested instance
ImportClaimsUseCase useCase = ImportClaimsUseCase(credentialRepository);

@GenerateMocks([CredentialRepository])
void main() {
  group("Import claims", () {
    //
    setUp(() {
      when(credentialRepository.importClaims(
        did: anyNamed('identifier'),
        privateKey: anyNamed('privateKey'),
        encryptedDb: anyNamed('encryptedDb'),
      )).thenAnswer((_) => Future.value());
    });

    //
    test(
        "Given a valid param, when I call execute, then I expect the result to be returned",
        () async {
      // When
      expect(useCase.execute(param: param), completes);

      // Verify
      var captured = verify(credentialRepository.importClaims(
        did: captureAnyNamed('identifier'),
        privateKey: captureAnyNamed('privateKey'),
        encryptedDb: captureAnyNamed('encryptedDb'),
      )).captured;

      expect(captured[0], identifier);
      expect(captured[1], privateKey);
      expect(captured[2], claimsToBeImported);
    });
  });
}
