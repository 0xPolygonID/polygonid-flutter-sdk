import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/authenticate_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';

import 'authenticate_use_case_test.mocks.dart';

MockIdentityRepository identityRepository = MockIdentityRepository();

AuthenticateUseCase useCase = AuthenticateUseCase(identityRepository);

const issuerMessage = "theIssuerMessage";
const identifier = "theIdentifier";
AuthenticateParam param =
    AuthenticateParam(issuerMessage: issuerMessage, identifier: identifier);

@GenerateMocks([IdentityRepository])
void main() {
  group(
    "Authenticate",
    () {
      setUp(() {
        reset(identityRepository);
      });

      test(
        'Given an issuerMessage and a identifier, when we call execute, then we expect that the flow completes without exception',
        () async {
          when(identityRepository.authenticate(
                  issuerMessage: anyNamed('issuerMessage'),
                  identifier: anyNamed('identifier')))
              .thenAnswer((realInvocation) => Future.value());

          await expectLater(useCase.execute(param: param), completes);

          var captured = verify(identityRepository.authenticate(
            issuerMessage: captureAnyNamed('issuerMessage'),
            identifier: captureAnyNamed('identifier'),
          )).captured;
          expect(captured[0], issuerMessage);
          expect(captured[1], identifier);
        },
      );
    },
  );
}
