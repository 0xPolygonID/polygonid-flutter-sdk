import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/import_identity_use_case.dart';

import 'import_identity_use_case_test.mocks.dart';

const privateKey = "thePrivateKey";
const identifier = "theIdentifier";
const encrypted = "theIdentityToBeImported";

ImportIdentityParam param = ImportIdentityParam(
  privateKey: privateKey,
  did: identifier,
  encryptedDb: encrypted,
);

MockIdentityRepository identityRepository = MockIdentityRepository();

// Tested instance
ImportIdentityUseCase useCase = ImportIdentityUseCase(identityRepository);

@GenerateMocks([IdentityRepository])
void main() {
  group("Import claims", () {
    //
    setUp(() {
      when(identityRepository.importIdentity(
        did: anyNamed('did'),
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
      var captured = verify(identityRepository.importIdentity(
        did: captureAnyNamed('did'),
        privateKey: captureAnyNamed('privateKey'),
        encryptedDb: captureAnyNamed('encryptedDb'),
      )).captured;

      expect(captured[0], identifier);
      expect(captured[1], privateKey);
      expect(captured[2], encrypted);
    });
  });
}
