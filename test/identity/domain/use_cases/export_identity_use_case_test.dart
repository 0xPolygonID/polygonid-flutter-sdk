import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/export_identity_use_case.dart';

import '../../../common/common_mocks.dart';
import 'export_identity_use_case_test.mocks.dart';

const exported = "theExportedIdentity";

ExportIdentityParam param = ExportIdentityParam(
  privateKey: CommonMocks.privateKey,
  did: CommonMocks.did,
);

MockIdentityRepository mockIdentityRepository = MockIdentityRepository();

// Tested instance
ExportIdentityUseCase useCase = ExportIdentityUseCase(mockIdentityRepository);

@GenerateMocks([IdentityRepository])
void main() {
  group("Export claims", () {
    setUp(() {
      when(mockIdentityRepository.exportIdentity(
        did: anyNamed('did'),
        privateKey: anyNamed('privateKey'),
      )).thenAnswer((_) async => exported);
    });

    test(
        "Given a valid param, when I call execute, then I expect the result to be returned",
        () async {
      // When
      final result = await useCase.execute(param: param);

      // Then
      expect(result, exported);

      // Verify
      var captured = verify(mockIdentityRepository.exportIdentity(
        did: captureAnyNamed('did'),
        privateKey: captureAnyNamed('privateKey'),
      )).captured;

      expect(captured[0], CommonMocks.did);
      expect(captured[1], CommonMocks.privateKey);
    });

    test(
        "Given a valid param, when I call execute and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(mockIdentityRepository.exportIdentity(
        did: anyNamed('did'),
        privateKey: anyNamed('privateKey'),
      )).thenAnswer((_) => Future.error(CommonMocks.exception));

      // When
      expectLater(
          useCase.execute(param: param), throwsA(CommonMocks.exception));

      // Then
      var captured = verify(mockIdentityRepository.exportIdentity(
        did: captureAnyNamed('did'),
        privateKey: captureAnyNamed('privateKey'),
      )).captured;

      expect(captured[0], CommonMocks.did);
      expect(captured[1], CommonMocks.privateKey);
    });
  });
}
