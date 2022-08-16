import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/domain/identity/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/repositories/identity_repositories.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/use_cases/create_identity_use_case.dart';

import 'create_identity_use_case_test.mocks.dart';

const String identifier = "identifier";
const String privateKey = "privateKey";
var identityException = IdentityException('error');

MockIdentityRepository identityRepository = MockIdentityRepository();
CreateIdentityUseCase useCase = CreateIdentityUseCase(identityRepository);

@GenerateMocks([IdentityRepository])
void main() {
  setUp(() {
    when(identityRepository.createIdentity(privateKey: anyNamed('privateKey'))).thenAnswer((realInvocation) => Future.value(identifier));
  });

  test(
    'get identifier after creating identity without passing privateKey',
    () async {
      expect(await useCase.execute(), identifier);

      expect(
        verify(
          identityRepository.createIdentity(privateKey: captureAnyNamed('privateKey')),
        ).captured.first,
        null,
      );
    },
  );

  test(
    'get identifier after creating identity with privateKey',
    () async {
      expect(await useCase.execute(param: privateKey), identifier);

      expect(
        verify(
          identityRepository.createIdentity(privateKey: captureAnyNamed('privateKey')),
        ).captured.first,
        privateKey,
      );
    },
  );

  test(
    'intercept exception while try to get identifier after creating identity',
    () async {
      when(identityRepository.createIdentity(privateKey: anyNamed('privateKey'))).thenAnswer((realInvocation) => Future.error(identityException));

      await expectLater(useCase.execute(), throwsA(identityException));

      expect(
        verify(
          identityRepository.createIdentity(privateKey: captureAnyNamed('privateKey')),
        ).captured.first,
        null,
      );
    },
  );
}
