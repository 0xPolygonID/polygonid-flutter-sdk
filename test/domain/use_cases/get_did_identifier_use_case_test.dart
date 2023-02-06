import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_identity_auth_claim_use_case.dart';

import '../../common/common_mocks.dart';
import '../../common/credential_mocks.dart';
import 'get_did_identifier_use_case_test.mocks.dart';

MockIdentityRepository identityRepository = MockIdentityRepository();
MockGetIdentityAuthClaimUseCase getIdentityAuthClaimUseCase =
    MockGetIdentityAuthClaimUseCase();

// Data
GetDidIdentifierParam param = GetDidIdentifierParam(
  privateKey: CommonMocks.privateKey,
  blockchain: CommonMocks.blockchain,
  network: CommonMocks.network,
);

GetDidIdentifierUseCase useCase = GetDidIdentifierUseCase(
  identityRepository,
  getIdentityAuthClaimUseCase,
);

@GenerateMocks([
  IdentityRepository,
  GetIdentityAuthClaimUseCase,
])
void main() {
  setUp(() {
    reset(identityRepository);
    reset(getIdentityAuthClaimUseCase);

    // Given
    when(getIdentityAuthClaimUseCase.execute(param: anyNamed('param')))
        .thenAnswer(
            (realInvocation) => Future.value(CredentialMocks.authClaim));
    when(identityRepository.getDidIdentifier(
      privateKey: anyNamed('privateKey'),
      blockchain: anyNamed('blockchain'),
      network: anyNamed('network'),
      authClaim: anyNamed('authClaim'),
    )).thenAnswer((realInvocation) => Future.value(CommonMocks.did));
  });

  test(
    'Given a param, when I call execute, then I expect an list of String to be returned',
    () async {
      // When
      expect(await useCase.execute(param: param), CommonMocks.did);

      // Then
      expect(
          verify(getIdentityAuthClaimUseCase.execute(
                  param: captureAnyNamed('param')))
              .captured
              .first,
          CommonMocks.privateKey);

      var authClaimCapture = verify(identityRepository.getDidIdentifier(
        privateKey: captureAnyNamed('privateKey'),
        blockchain: captureAnyNamed('blockchain'),
        network: captureAnyNamed('network'),
        authClaim: captureAnyNamed('authClaim'),
      )).captured;
      expect(authClaimCapture[0], CommonMocks.privateKey);
      expect(authClaimCapture[1], CommonMocks.blockchain);
      expect(authClaimCapture[2], CommonMocks.network);
      expect(authClaimCapture[3], CredentialMocks.authClaim);
    },
  );

  test(
    'Given a param, when I call execute and an error occurred, then I expect an exception to be thrown',
    () async {
      // Given
      when(getIdentityAuthClaimUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

      // When
      await expectLater(
          useCase.execute(param: param), throwsA(CommonMocks.exception));

      // Then
      expect(
          verify(getIdentityAuthClaimUseCase.execute(
                  param: captureAnyNamed('param')))
              .captured
              .first,
          CommonMocks.privateKey);

      verifyNever(identityRepository.getDidIdentifier(
        privateKey: captureAnyNamed('privateKey'),
        blockchain: captureAnyNamed('blockchain'),
        network: captureAnyNamed('network'),
        authClaim: captureAnyNamed('authClaim'),
      ));
    },
  );
}
