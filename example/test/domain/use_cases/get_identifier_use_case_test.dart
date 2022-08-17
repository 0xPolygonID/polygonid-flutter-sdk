import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/repositories/identity_repositories.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/use_cases/get_identifier_use_case.dart';

import 'get_identifier_use_case_test.mocks.dart';

const String identifier = "identifier";
const String privateKey = "privateKey";

MockIdentityRepository identityRepository = MockIdentityRepository();
GetIdentifierUseCase useCase = GetIdentifierUseCase(identityRepository);

@GenerateMocks([IdentityRepository])
void main() {
  setUp(() {
    when(identityRepository.getCurrentIdentifier()).thenAnswer((realInvocation) => Future.value(identifier));
  });

  test(
    'get current identifier, expect identifier',
    () async {
      expect(await useCase.execute(), identifier);
    },
  );
}
