import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/add_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/smt/create_identity_state_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/create_identity_use_case.dart';

import '../../../common/common_mocks.dart';
import '../../../common/identity_mocks.dart';
import 'add_identity_use_case_test.mocks.dart';

// Data
var exception = Exception();
var param = AddIdentityParam(
    privateKey: CommonMocks.privateKey,
    blockchain: CommonMocks.blockchain,
    network: CommonMocks.network,
    profiles: CommonMocks.intValues);

// Dependencies
MockIdentityRepository identityRepository = MockIdentityRepository();
MockCreateIdentityUseCase createIdentityUseCase = MockCreateIdentityUseCase();
MockCreateIdentityStateUseCase createIdentityStateUseCase =
    MockCreateIdentityStateUseCase();

// Tested instance
AddIdentityUseCase useCase = AddIdentityUseCase(
  identityRepository,
  createIdentityUseCase,
  createIdentityStateUseCase,
);

@GenerateMocks([
  IdentityRepository,
  CreateIdentityUseCase,
  CreateIdentityStateUseCase,
])
void main() {
  setUp(() {
    reset(createIdentityUseCase);
    reset(identityRepository);
    reset(createIdentityStateUseCase);

    // Given
    when(createIdentityUseCase.execute(param: anyNamed('param'))).thenAnswer(
        (realInvocation) => Future.value(IdentityMocks.privateIdentity));
    when(identityRepository.getIdentity(genesisDid: anyNamed('genesisDid')))
        .thenAnswer((realInvocation) =>
            Future.error(UnknownIdentityException(CommonMocks.identifier)));
    when(identityRepository.storeIdentity(identity: anyNamed('identity')))
        .thenAnswer((realInvocation) => Future.value());
    when(createIdentityStateUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.value());
  });

  test(
      "Given a param which is not already associated with an identity, when I call execute, then I expect an identity to be returned",
      () async {
    // When
    expect(await useCase.execute(param: param), IdentityMocks.privateIdentity);

    // Then
    var captureCreate =
        verify(createIdentityUseCase.execute(param: captureAnyNamed('param')))
            .captured
            .first;
    expect(captureCreate.privateKey, CommonMocks.privateKey);
    expect(captureCreate.blockchain, CommonMocks.blockchain);
    expect(captureCreate.network, CommonMocks.network);
    expect(captureCreate.profiles, CommonMocks.intValues);

    expect(
        verify(identityRepository.getIdentity(
                genesisDid: captureAnyNamed('genesisDid')))
            .captured
            .first,
        CommonMocks.did);

    var capturedStore = verify(identityRepository.storeIdentity(
            identity: captureAnyNamed('identity')))
        .captured;
    expect(capturedStore[0], IdentityMocks.privateIdentity);

    var verifyState = verify(
        createIdentityStateUseCase.execute(param: captureAnyNamed('param')));
    expect(verifyState.callCount, CommonMocks.profiles.values.length);

    for (int i = 0; i < CommonMocks.profiles.values.length; i++) {
      expect(
          verifyState.captured[i].did, CommonMocks.profiles.values.toList()[i]);
      expect(verifyState.captured[i].privateKey, CommonMocks.privateKey);
    }
  });

  test(
      "Given a param and with an associated identity, when I call execute, then I expect an IdentityAlreadyExistsException to be thrown",
      () async {
    // Given
    when(identityRepository.getIdentity(genesisDid: anyNamed('genesisDid')))
        .thenAnswer(
            (realInvocation) => Future.value(IdentityMocks.privateIdentity));

    // When
    await useCase.execute(param: param).then((_) => null).catchError((error) {
      expect(error, isA<IdentityAlreadyExistsException>());
      expect(error.did, IdentityMocks.identity.did);
    });

    // Then
    var captureCreate =
        verify(createIdentityUseCase.execute(param: captureAnyNamed('param')))
            .captured
            .first;
    expect(captureCreate.privateKey, CommonMocks.privateKey);
    expect(captureCreate.blockchain, CommonMocks.blockchain);
    expect(captureCreate.network, CommonMocks.network);
    expect(captureCreate.profiles, CommonMocks.intValues);

    expect(
        verify(identityRepository.getIdentity(
                genesisDid: captureAnyNamed('genesisDid')))
            .captured
            .first,
        CommonMocks.did);

    verifyNever(identityRepository.storeIdentity(
        identity: captureAnyNamed('identity')));

    verifyNever(
        createIdentityStateUseCase.execute(param: captureAnyNamed('param')));
  });

  test(
      "Given a param, when I call execute and an error occurred, then I expect an exception to be thrown",
      () async {
    // Given
    when(createIdentityUseCase.execute(param: anyNamed('param')))
        .thenAnswer((realInvocation) => Future.error(exception));

    // When
    await expectLater(useCase.execute(param: param), throwsA(exception));

    // Then
    var captureCreate =
        verify(createIdentityUseCase.execute(param: captureAnyNamed('param')))
            .captured
            .first;
    expect(captureCreate.privateKey, CommonMocks.privateKey);
    expect(captureCreate.blockchain, CommonMocks.blockchain);
    expect(captureCreate.network, CommonMocks.network);
    expect(captureCreate.profiles, CommonMocks.intValues);

    verifyNever(identityRepository.getIdentity(
        genesisDid: captureAnyNamed('genesisDid')));

    verifyNever(identityRepository.storeIdentity(
        identity: captureAnyNamed('identity')));

    verifyNever(
        createIdentityStateUseCase.execute(param: captureAnyNamed('param')));
  });
}
