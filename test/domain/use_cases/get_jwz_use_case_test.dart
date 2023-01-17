import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/get_jwz_use_case.dart';

import '../../common/common_mocks.dart';
import '../../common/proof_mocks.dart';
import 'get_jwz_use_case_test.mocks.dart';

MockProofRepository proofRepository = MockProofRepository();
GetJWZUseCase useCase = GetJWZUseCase(proofRepository);

// Data
GetJWZParam param =
    GetJWZParam(message: CommonMocks.message, proof: ProofMocks.jwzProof);

@GenerateMocks([ProofRepository])
void main() {
  setUp(() {
    when(proofRepository.encodeJWZ(jwz: anyNamed("jwz")))
        .thenAnswer((realInvocation) => Future.value(ProofMocks.encodedJWZ));
  });

  test(
    'Given a param, when I call execute, then I expect a String to be returned',
    () async {
      // When
      expect(await useCase.execute(param: param), ProofMocks.encodedJWZ);

      // Then
      var capturedEncode =
          verify(proofRepository.encodeJWZ(jwz: captureAnyNamed("jwz")))
              .captured
              .first;
      expect(capturedEncode, ProofMocks.jwz);
    },
  );

  test(
    'Given a param, when I call execute and an error occurred, then I expect an exception to be thrown',
    () async {
      // Given
      when(proofRepository.encodeJWZ(jwz: anyNamed("jwz")))
          .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

      // When
      await useCase
          .execute(param: param)
          .then((value) => expect(true, false))
          .catchError((error) {
        expect(error, CommonMocks.exception);
      });

      // Then
      var capturedEncode =
          verify(proofRepository.encodeJWZ(jwz: captureAnyNamed("jwz")))
              .captured
              .first;
      expect(capturedEncode, ProofMocks.jwz);
    },
  );
}
