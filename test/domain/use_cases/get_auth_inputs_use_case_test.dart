import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_auth_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_inputs_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/sign_message_use_case.dart';

import '../../common/common_mocks.dart';
import '../../common/identity_mocks.dart';
import 'get_auth_inputs_use_case_test.mocks.dart';

MockGetIdentityUseCase getIdentityUseCase = MockGetIdentityUseCase();
MockGetAuthClaimUseCase getAuthClaimUseCase = MockGetAuthClaimUseCase();
MockSignMessageUseCase signMessageUseCase = MockSignMessageUseCase();
MockIdentityRepository identityRepository = MockIdentityRepository();

// Data
GetAuthInputsParam param = GetAuthInputsParam(
    CommonMocks.challenge, CommonMocks.identifier, CommonMocks.privateKey);

// Tested instance
GetAuthInputsUseCase useCase = GetAuthInputsUseCase(getIdentityUseCase,
    getAuthClaimUseCase, signMessageUseCase, identityRepository);

@GenerateMocks([
  GetIdentityUseCase,
  GetAuthClaimUseCase,
  SignMessageUseCase,
  IdentityRepository
])
void main() {
  setUp(() {
    when(getIdentityUseCase.execute(param: anyNamed("param")))
        .thenAnswer((realInvocation) => Future.value(IdentityMocks.identity));
    when(signMessageUseCase.execute(param: anyNamed("param")))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.signature));
    when(getAuthClaimUseCase.execute(param: anyNamed("param")))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.authClaim));
    when(identityRepository.getAuthInputs(
            challenge: anyNamed("challenge"),
            authClaim: anyNamed("authClaim"),
            identity: anyNamed("identity"),
            signature: anyNamed("signature")))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.aBytes));
  });

  test(
    'Given a param, when I call execute, then I expect a bytes list to be returned',
    () async {
      // When
      expect(await useCase.execute(param: param), CommonMocks.aBytes);

      // Then
      var capturedIdentity =
          verify(getIdentityUseCase.execute(param: captureAnyNamed("param")))
              .captured
              .first;
      expect(capturedIdentity.did, param.did);
      expect(capturedIdentity.privateKey, param.privateKey);

      var capturedSign =
          verify(signMessageUseCase.execute(param: captureAnyNamed("param")))
              .captured
              .first;
      expect(capturedSign.privateKey, param.privateKey);
      expect(capturedSign.message, CommonMocks.challenge);

      var capturedAuthInputs = verify(identityRepository.getAuthInputs(
              challenge: captureAnyNamed("challenge"),
              authClaim: captureAnyNamed("authClaim"),
              identity: captureAnyNamed("identity"),
              signature: captureAnyNamed("signature")))
          .captured;
      expect(capturedAuthInputs[0], CommonMocks.challenge);
      expect(capturedAuthInputs[1], CommonMocks.authClaim);
      expect(capturedAuthInputs[2], IdentityMocks.identity);
      expect(capturedAuthInputs[3], CommonMocks.signature);
    },
  );

  test(
    'Given a param, when I call execute and an error occurred, then I expect an exception to be thrown',
    () async {
      // Given
      when(getAuthClaimUseCase.execute(param: anyNamed("param")))
          .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

      // When
      await expectLater(
          useCase.execute(param: param), throwsA(CommonMocks.exception));

      // Then
      var capturedIdentity =
          verify(getIdentityUseCase.execute(param: captureAnyNamed("param")))
              .captured
              .first;
      expect(capturedIdentity.did, param.did);
      expect(capturedIdentity.privateKey, param.privateKey);

      var capturedSign =
          verify(signMessageUseCase.execute(param: captureAnyNamed("param")))
              .captured
              .first;
      expect(capturedSign.privateKey, param.privateKey);
      expect(capturedSign.message, CommonMocks.challenge);

      verifyNever(identityRepository.getAuthInputs(
          challenge: captureAnyNamed("challenge"),
          authClaim: captureAnyNamed("authClaim"),
          identity: captureAnyNamed("identity"),
          signature: captureAnyNamed("signature")));
    },
  );
}
