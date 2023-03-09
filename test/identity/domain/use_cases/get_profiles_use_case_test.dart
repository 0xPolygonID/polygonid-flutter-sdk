import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_profiles_use_case.dart';

import '../../../common/common_mocks.dart';
import '../../../common/identity_mocks.dart';

import 'get_profiles_use_case_test.mocks.dart';

MockIdentityRepository identityRepository = MockIdentityRepository();
MockGetIdentityUseCase getIdentityUseCase = MockGetIdentityUseCase();

// Data
String param = CommonMocks.did;

GetProfilesUseCase useCase = GetProfilesUseCase(
  identityRepository,
  getIdentityUseCase,
);

@GenerateMocks([
  IdentityRepository,
  GetIdentityUseCase,
])
void main() {
  setUp(() {
    reset(identityRepository);
    reset(getIdentityUseCase);

    // Given
    when(getIdentityUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(IdentityMocks.identity));
    when(identityRepository.getDidIdentifier(
      blockchain: anyNamed('blockchain'),
      network: anyNamed('network'),
      claimsRoot: anyNamed('claimsRoot'),
      profileNonce: anyNamed('profileNonce'),
    )).thenAnswer((realInvocation) => Future.value(CommonMocks.did));
  });

  test(
    'Given a param, when I call execute, then I expect an Map<int, String> to be returned',
    () async {
      // When
      expect(await useCase.execute(param: param), CommonMocks.profiles);

      // Then
      var getIdentityCapture =
          verify(getIdentityUseCase.execute(param: captureAnyNamed('param')))
              .captured;
      expect(getIdentityCapture.first.genesisDid, CommonMocks.did);
    },
  );

  test(
    'Given a param, when I call execute and an error occurred, then I expect an exception to be thrown',
    () async {
      // Given
      when(getIdentityUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

      // When
      await expectLater(
          useCase.execute(param: param), throwsA(CommonMocks.exception));

      // Then
      var getIdentityCapture =
          verify(getIdentityUseCase.execute(param: captureAnyNamed('param')))
              .captured;
      expect(getIdentityCapture.first.genesisDid, CommonMocks.did);
    },
  );
}
