import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/export_claims_use_case.dart';

import 'export_claims_use_case_test.mocks.dart';

const privateKey = "thePrivateKey";
const identifier = "theIdentifier";
const exportedClaims = "theExportedClaims";

ExportClaimsParam param = ExportClaimsParam(
  privateKey: privateKey,
  did: identifier,
);

MockCredentialRepository mockCredentialRepository = MockCredentialRepository();

// Tested instance
ExportClaimsUseCase useCase = ExportClaimsUseCase(mockCredentialRepository);

@GenerateMocks([CredentialRepository])
void main() {
  group("Export claims", () {
    //
    setUp(() {
      when(mockCredentialRepository.exportClaims(
        did: anyNamed('identifier'),
        privateKey: anyNamed('privateKey'),
      )).thenAnswer((_) async => exportedClaims);
    });

    //
    test(
        "Given a valid param, when I call execute, then I expect the result to be returned",
        () async {
      // When
      final result = await useCase.execute(param: param);

      // Then
      expect(result, exportedClaims);

      // Verify
      var captured = verify(mockCredentialRepository.exportClaims(
        did: captureAnyNamed('identifier'),
        privateKey: captureAnyNamed('privateKey'),
      )).captured;

      expect(captured[0], identifier);
      expect(captured[1], privateKey);
    });
  });
}
