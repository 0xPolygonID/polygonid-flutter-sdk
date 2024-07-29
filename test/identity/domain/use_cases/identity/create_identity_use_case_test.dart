import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/create_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_public_keys_use_case.dart';

import '../../../../common/common_mocks.dart';
import 'create_identity_use_case_test.mocks.dart';

// Data
var exception = Exception();
var param = CreateIdentityParam(
  privateKey: CommonMocks.privateKey,
  profiles: CommonMocks.bigIntValues,
);
var paramNoProfiles = CreateIdentityParam(
  privateKey: CommonMocks.privateKey,
);
var noProfiles = {BigInt.zero: CommonMocks.did};
var profiles = {BigInt.zero: CommonMocks.did};

PrivateIdentityEntity expected = PrivateIdentityEntity(
    did: CommonMocks.did,
    publicKey: CommonMocks.pubKeys,
    profiles: profiles,
    privateKey: CommonMocks.privateKey);

PrivateIdentityEntity expectedNoProfiles = PrivateIdentityEntity(
    did: CommonMocks.did,
    publicKey: CommonMocks.pubKeys,
    profiles: noProfiles,
    privateKey: CommonMocks.privateKey);

// Dependencies
MockGetPublicKeysUseCase getPublicKeysUseCase = MockGetPublicKeysUseCase();
MockGetCurrentEnvDidIdentifierUseCase getCurrentEnvDidIdentifierUseCase =
    MockGetCurrentEnvDidIdentifierUseCase();
MockStacktraceManager stacktraceManager = MockStacktraceManager();

// Tested instance
CreateIdentityUseCase useCase = CreateIdentityUseCase(
  getPublicKeysUseCase,
  getCurrentEnvDidIdentifierUseCase,
  stacktraceManager,
);

@GenerateMocks([
  GetPublicKeysUseCase,
  GetCurrentEnvDidIdentifierUseCase,
  StacktraceManager,
])
void main() {
  setUp(() {
    reset(getPublicKeysUseCase);
    reset(getCurrentEnvDidIdentifierUseCase);

    for (BigInt id in CommonMocks.bigIntValues) {
      profiles[id] = CommonMocks.did;
    }

    // Given
    when(getPublicKeysUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.pubKeys));
    when(getCurrentEnvDidIdentifierUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value(CommonMocks.did));
  });

  test(
      "Given a param, when I call execute, then I expect an identity to be returned",
      () async {
    // When
    expect(await useCase.execute(param: param), expected);

    // Then
    expect(
        verify(getPublicKeysUseCase.execute(param: captureAnyNamed('param')))
            .captured
            .first,
        CommonMocks.privateKey);

    var capturedGetDid = verify(getCurrentEnvDidIdentifierUseCase.execute(
            param: captureAnyNamed('param')))
        .captured;
    expect(capturedGetDid.length, CommonMocks.intValues.length + 1);
    expect(capturedGetDid.first.privateKey, CommonMocks.privateKey);
    expect(capturedGetDid.first.profileNonce, CommonMocks.genesisNonce);

    for (int i = 1; i < CommonMocks.bigIntValues.length + 1; i++) {
      expect(capturedGetDid[i].privateKey, CommonMocks.privateKey);
      expect(capturedGetDid[i].profileNonce, CommonMocks.bigIntValues[i - 1]);
    }
  });

  test(
      "Given a param without profiles, when I call execute, then I expect an identity to be returned",
      () async {
    // When
    expect(await useCase.execute(param: paramNoProfiles), expectedNoProfiles);

    // Then
    expect(
        verify(getPublicKeysUseCase.execute(param: captureAnyNamed('param')))
            .captured
            .first,
        CommonMocks.privateKey);

    var capturedGetDid = verify(getCurrentEnvDidIdentifierUseCase.execute(
            param: captureAnyNamed('param')))
        .captured;
    expect(capturedGetDid.length, 1);
    expect(capturedGetDid.first.privateKey, CommonMocks.privateKey);
    expect(capturedGetDid.first.profileNonce, CommonMocks.genesisNonce);
  });

  test(
      "Given a param, when I call execute and an error occurred, then I expect an exception to be thrown",
      () async {
    // Given
    when(getCurrentEnvDidIdentifierUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

    // When
    await expectLater(
        useCase.execute(param: param), throwsA(CommonMocks.exception));

    // Then
    expect(
        verify(getPublicKeysUseCase.execute(param: captureAnyNamed('param')))
            .captured
            .first,
        CommonMocks.privateKey);

    var capturedGetDid = verify(getCurrentEnvDidIdentifierUseCase.execute(
            param: captureAnyNamed('param')))
        .captured;
    expect(capturedGetDid.length, 1);
    expect(capturedGetDid.first.privateKey, CommonMocks.privateKey);
    expect(capturedGetDid.first.profileNonce, CommonMocks.genesisNonce);
  });
}
