import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identities_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/get_profiles_use_case.dart';

import '../../../../common/common_mocks.dart';
import '../../../../common/identity_mocks.dart';

import 'get_identity_use_case_test.mocks.dart';

MockIdentityRepository identityRepository = MockIdentityRepository();
MockGetDidUseCase getDidUseCase = MockGetDidUseCase();
MockGetDidIdentifierUseCase getDidIdentifierUseCase = MockGetDidIdentifierUseCase();

var param = GetIdentityParam(
    genesisDid: CommonMocks.did);

GetIdentityUseCase useCase = GetIdentityUseCase(
  identityRepository,
  getDidUseCase,
  getDidIdentifierUseCase
);

@GenerateMocks([
  IdentityRepository,
  GetDidUseCase,
  GetDidIdentifierUseCase,
])
void main() {
  setUp(() {
    reset(identityRepository);
    reset(getDidUseCase);

    // Given
    when(identityRepository.getIdentity(genesisDid: CommonMocks.did)).thenAnswer(
        (realInvocation) => Future.value(IdentityMocks.privateIdentity));
  });

  test(
    'Given a param, when I call execute, then I expect a PrivateIdentityEntity to be returned',
    () async {
      // When
      expect(await useCase.execute(param: param), IdentityMocks.privateIdentity);
    },
  );

  test(
    'Given a param, when I call execute and an error occurred, then I expect an exception to be thrown',
    () async {
      // Given
      when(useCase.execute(param: param))
          .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

      // When
      await expectLater(useCase.execute(param: param), throwsA(CommonMocks.exception));
    },
  );
}
