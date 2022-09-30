import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/authenticate_use_case.dart';

import 'authenticate_use_case_test.mocks.dart';

MockIden3commRepository iden3commRepository = MockIden3commRepository();

AuthenticateUseCase useCase = AuthenticateUseCase(iden3commRepository);

const issuerMessage = "theIssuerMessage";
const identifier = "theIdentifier";
AuthenticateParam param =
    AuthenticateParam(issuerMessage: issuerMessage, identifier: identifier);

@GenerateMocks([Iden3commRepository])
void main() {
  group(
    "Authenticate",
    () {
      setUp(() {
        reset(iden3commRepository);
      });

      test(
        'Given an issuerMessage and a identifier, when we call execute, then we expect that the flow completes without exception',
        () async {
          when(iden3commRepository.authenticate(
                  iden3message: anyNamed('iden3message'),
                  identifier: anyNamed('identifier')))
              .thenAnswer((realInvocation) => Future.value());

          await expectLater(useCase.execute(param: param), completes);

          var captured = verify(iden3commRepository.authenticate(
            iden3message: captureAnyNamed('iden3message'),
            identifier: captureAnyNamed('identifier'),
          )).captured;
          expect(captured[0], issuerMessage);
          expect(captured[1], identifier);
        },
      );
    },
  );
}
