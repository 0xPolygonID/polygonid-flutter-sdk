import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_jwz_use_case.dart';

import '../../../common/common_mocks.dart';
import '../../../common/iden3comm_mocks.dart';
import '../../../common/proof_mocks.dart';
import 'get_jwz_use_case_test.mocks.dart';

MockIden3commRepository iden3commRepository = MockIden3commRepository();
GetJWZUseCase useCase = GetJWZUseCase(iden3commRepository);

// Data
GetJWZParam param =
    GetJWZParam(message: CommonMocks.message, proof: ProofMocks.zkProof);

@GenerateMocks([Iden3commRepository])
void main() {
  setUp(() {
    when(iden3commRepository.encodeJWZ(jwz: anyNamed("jwz"))).thenAnswer(
        (realInvocation) => Future.value(Iden3commMocks.encodedJWZ));
  });

  test(
    'Given a param, when I call execute, then I expect a String to be returned',
    () async {
      // When
      expect(await useCase.execute(param: param), Iden3commMocks.encodedJWZ);

      // Then
      var capturedEncode =
          verify(iden3commRepository.encodeJWZ(jwz: captureAnyNamed("jwz")))
              .captured
              .first;
      expect(capturedEncode, Iden3commMocks.jwz);
    },
  );

  test(
    'Given a param, when I call execute and an error occurred, then I expect an exception to be thrown',
    () async {
      // Given
      when(iden3commRepository.encodeJWZ(jwz: anyNamed("jwz")))
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
          verify(iden3commRepository.encodeJWZ(jwz: captureAnyNamed("jwz")))
              .captured
              .first;
      expect(capturedEncode, Iden3commMocks.jwz);
    },
  );
}
