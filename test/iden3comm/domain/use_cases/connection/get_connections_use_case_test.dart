import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/connection_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/connection/get_connections_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

import '../../../../common/common_mocks.dart';
import '../../../../common/iden3comm_mocks.dart';
import '../../../../common/identity_mocks.dart';
import 'get_connections_use_case_test.mocks.dart';

// Data
const identifier = "theIdentifier";
const privateKey = "thePrivateKey";
final GetConnectionsParam param = GetConnectionsParam(
    did: identifier,
    privateKey: privateKey,
    profileNonce: CommonMocks.genesisNonce);
final GetConnectionsParam profileParam = GetConnectionsParam(
    did: identifier, profileNonce: CommonMocks.nonce, privateKey: privateKey);
final profilesConnectionEntities = [
  ConnectionEntity(
    from: CommonMocks.did,
    to: CommonMocks.did,
    interactions: [],
  ),
  ConnectionEntity(
    from: CommonMocks.did,
    to: CommonMocks.did,
    interactions: [],
  ),
  ConnectionEntity(
    from: CommonMocks.did,
    to: CommonMocks.did,
    interactions: [],
  ),
  ConnectionEntity(
    from: CommonMocks.did,
    to: CommonMocks.did,
    interactions: [],
  ),
  ConnectionEntity(
    from: CommonMocks.did,
    to: CommonMocks.did,
    interactions: [],
  ),
  ConnectionEntity(
    from: CommonMocks.did,
    to: CommonMocks.did,
    interactions: [],
  )
];
var exception = Exception();

// Dependencies
MockIden3commRepository iden3commRepository = MockIden3commRepository();
MockGetCurrentEnvDidIdentifierUseCase getCurrentEnvDidIdentifierUseCase =
    MockGetCurrentEnvDidIdentifierUseCase();
MockGetIdentityUseCase getIdentityUseCase = MockGetIdentityUseCase();

// Tested instance
GetConnectionsUseCase useCase = GetConnectionsUseCase(
    iden3commRepository, getCurrentEnvDidIdentifierUseCase, getIdentityUseCase);

@GenerateMocks([
  Iden3commRepository,
  GetCurrentEnvDidIdentifierUseCase,
  GetIdentityUseCase
])
void main() {
  group("Get connections", () {
    setUp(() {
      reset(getCurrentEnvDidIdentifierUseCase);
      reset(getIdentityUseCase);
      reset(iden3commRepository);

      // Given
      when(iden3commRepository.getConnections(
        did: anyNamed('did'),
        privateKey: anyNamed('privateKey'),
      )).thenAnswer(
          (realInvocation) => Future.value(Iden3commMocks.connectionEntities));
      when(getCurrentEnvDidIdentifierUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.value(CommonMocks.did));
      when(getIdentityUseCase.execute(param: anyNamed('param'))).thenAnswer(
          (realInvocation) => Future.value(IdentityMocks.privateIdentity));
    });

    test(
        "When I call execute, then I expect a list of ConnectionEntity to be returned",
        () async {
      // When
      expect(await useCase.execute(param: param), profilesConnectionEntities);

      // Then
      var capturedDid = verify(getCurrentEnvDidIdentifierUseCase.execute(
              param: captureAnyNamed('param')))
          .captured
          .first;
      expect(capturedDid.privateKey, privateKey);
      expect(capturedDid.profileNonce, CommonMocks.genesisNonce);

      var getIdentityCapture =
          verify(getIdentityUseCase.execute(param: captureAnyNamed('param')))
              .captured
              .first;
      expect(getIdentityCapture.genesisDid, CommonMocks.did);

      var capturedGet = verify(iden3commRepository.getConnections(
              did: captureAnyNamed('did'),
              privateKey: captureAnyNamed('privateKey')))
          .captured;
      expect(capturedGet[0], CommonMocks.profiles[CommonMocks.genesisNonce]);
      expect(capturedGet[1], privateKey);
    });

    test(
        "Given a non genesis profile, When I call execute, then I expect a list of ConnectionEntity to be returned",
        () async {
      // When
      expect(await useCase.execute(param: profileParam),
          Iden3commMocks.connectionEntities);

      // Then
      var capturedDid = verify(getCurrentEnvDidIdentifierUseCase.execute(
              param: captureAnyNamed('param')))
          .captured
          .first;
      expect(capturedDid.privateKey, privateKey);
      expect(capturedDid.profileNonce, CommonMocks.nonce);

      verifyNever(getIdentityUseCase.execute(param: captureAnyNamed('param')));

      var capturedGet = verify(iden3commRepository.getConnections(
              did: captureAnyNamed('did'),
              privateKey: captureAnyNamed('privateKey')))
          .captured;
      expect(capturedGet[0], CommonMocks.did);
      expect(capturedGet[1], privateKey);
    });

    test(
        "When I call execute and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(iden3commRepository.getConnections(
        did: captureAnyNamed('did'),
        privateKey: captureAnyNamed('privateKey'),
      )).thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(useCase.execute(param: param), throwsA(exception));

      // Then
      var capturedDid = verify(getCurrentEnvDidIdentifierUseCase.execute(
              param: captureAnyNamed('param')))
          .captured
          .first;
      expect(capturedDid.privateKey, privateKey);

      var getIdentityCapture =
          verify(getIdentityUseCase.execute(param: captureAnyNamed('param')))
              .captured
              .first;
      expect(getIdentityCapture.genesisDid, CommonMocks.did);

      var capturedGet = verify(iden3commRepository.getConnections(
        did: captureAnyNamed('did'),
        privateKey: captureAnyNamed('privateKey'),
      )).captured;
      expect(capturedGet[0], CommonMocks.profiles[CommonMocks.genesisNonce]);
      expect(capturedGet[1], privateKey);
    });

    test(
        "Given a non genesis profile, When I call execute and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(iden3commRepository.getConnections(
        did: captureAnyNamed('did'),
        privateKey: captureAnyNamed('privateKey'),
      )).thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(
          useCase.execute(param: profileParam), throwsA(exception));

      // Then
      var capturedDid = verify(getCurrentEnvDidIdentifierUseCase.execute(
              param: captureAnyNamed('param')))
          .captured
          .first;
      expect(capturedDid.privateKey, privateKey);

      verifyNever(getIdentityUseCase.execute(param: captureAnyNamed('param')));

      var capturedGet = verify(iden3commRepository.getConnections(
        did: captureAnyNamed('did'),
        privateKey: captureAnyNamed('privateKey'),
      )).captured;
      expect(capturedGet[0], CommonMocks.did);
      expect(capturedGet[1], privateKey);
    });
  });
}
