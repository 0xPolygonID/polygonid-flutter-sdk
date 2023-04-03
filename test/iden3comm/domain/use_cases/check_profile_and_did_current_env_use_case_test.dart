import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/check_profile_validity_use_case.dart';

import '../../../common/common_mocks.dart';
import 'check_profile_and_did_current_env_use_case_test.mocks.dart';

// Dependencies
MockCheckProfileValidityUseCase checkProfileValidityUseCase =
    MockCheckProfileValidityUseCase();
MockGetEnvUseCase getEnvUseCase = MockGetEnvUseCase();
MockGetDidIdentifierUseCase getDidIdentifierUseCase =
    MockGetDidIdentifierUseCase();

// Tested instance
CheckProfileAndDidCurrentEnvUseCase useCase =
    CheckProfileAndDidCurrentEnvUseCase(
        checkProfileValidityUseCase, getEnvUseCase, getDidIdentifierUseCase);

@GenerateMocks([
  CheckProfileValidityUseCase,
  GetEnvUseCase,
  GetDidIdentifierUseCase,
])
void main() {
  setUp(() {
    when(checkProfileValidityUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(null));
    when(getEnvUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.env));
    when(getDidIdentifierUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.did));
  });

  test("Given param, when I call execute, I expect the process to complete",
      () async {
    // When
    await expectLater(
        useCase.execute(
            param: CheckProfileAndDidCurrentEnvParam(
                did: CommonMocks.did,
                privateKey: CommonMocks.privateKey,
                profileNonce: 1)),
        completes);

    // Then
    expect(
        verify(checkProfileValidityUseCase.execute(
                param: captureAnyNamed('param')))
            .captured
            .first
            .profileNonce,
        1);
    verify(getEnvUseCase.execute(param: anyNamed('param')));

    var captureDidIdentifier =
        verify(getDidIdentifierUseCase.execute(param: captureAnyNamed('param')))
            .captured
            .first;
    expect(captureDidIdentifier.privateKey, CommonMocks.privateKey);
    expect(captureDidIdentifier.blockchain, CommonMocks.env.blockchain);
    expect(captureDidIdentifier.network, CommonMocks.env.network);
  });

  test(
      "Given param, when I call execute with a did from another env, I expect a DidNotMatchCurrentEnvException to be thrown",
      () async {
    // Given
    when(getDidIdentifierUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.id));

    // When
    await useCase
        .execute(
            param: CheckProfileAndDidCurrentEnvParam(
                did: CommonMocks.did,
                privateKey: CommonMocks.privateKey,
                profileNonce: 1))
        .then((_) => expect(true, false))
        .catchError((error) {
      expect(error, isA<DidNotMatchCurrentEnvException>());
      expect(error.did, CommonMocks.did);
      expect(error.rightDid, CommonMocks.id);
    });

    // Then
    expect(
        verify(checkProfileValidityUseCase.execute(
                param: captureAnyNamed('param')))
            .captured
            .first
            .profileNonce,
        1);
    verify(getEnvUseCase.execute(param: anyNamed('param')));

    var captureDidIdentifier =
        verify(getDidIdentifierUseCase.execute(param: captureAnyNamed('param')))
            .captured
            .first;
    expect(captureDidIdentifier.privateKey, CommonMocks.privateKey);
    expect(captureDidIdentifier.blockchain, CommonMocks.env.blockchain);
    expect(captureDidIdentifier.network, CommonMocks.env.network);
  });

  test(
      "Given param, when I call execute and an error occurred, I expect an exception to be thrown",
      () async {
    // Given
    when(getEnvUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

    // When
    await expectLater(
        useCase.execute(
            param: CheckProfileAndDidCurrentEnvParam(
                did: CommonMocks.did,
                privateKey: CommonMocks.privateKey,
                profileNonce: 1)),
        throwsA(CommonMocks.exception));

    // Then
    expect(
        verify(checkProfileValidityUseCase.execute(
                param: captureAnyNamed('param')))
            .captured
            .first
            .profileNonce,
        1);
    verify(getEnvUseCase.execute(param: anyNamed('param')));
    verifyNever(
        getDidIdentifierUseCase.execute(param: captureAnyNamed('param')));
  });
}
