import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/connection_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/connection/get_connections_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

import '../../../../common/common_mocks.dart';
import '../../../../common/iden3comm_mocks.dart';
import '../../../../common/identity_mocks.dart';
import '../../../../identity/domain/use_cases/profile/add_profile_use_case_test.dart';
import 'get_connections_use_case_test.mocks.dart';

// Data
const privateKey = "thePrivateKey";
final GetConnectionsParam param = GetConnectionsParam(
    genesisDid: CommonMocks.did,
    privateKey: privateKey,
    profileNonce: CommonMocks.genesisNonce);
final GetConnectionsParam profileParam = GetConnectionsParam(
    genesisDid: CommonMocks.did,
    profileNonce: CommonMocks.nonce,
    privateKey: privateKey);
final connectionEntities = [
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
MockCheckProfileAndDidCurrentEnvUseCase checkProfileAndDidCurrentEnvUseCase =
    MockCheckProfileAndDidCurrentEnvUseCase();
// Tested instance
GetConnectionsUseCase useCase = GetConnectionsUseCase(
    iden3commRepository, checkProfileAndDidCurrentEnvUseCase);

@GenerateMocks([
  Iden3commRepository,
  CheckProfileAndDidCurrentEnvUseCase,
])
void main() {
  group("Get connections", () {
    setUp(() {
      reset(checkProfileAndDidCurrentEnvUseCase);
      reset(iden3commRepository);

      // Given
      when(iden3commRepository.getConnections(
        genesisDid: anyNamed('genesisDid'),
        profileNonce: anyNamed('profileNonce'),
        privateKey: anyNamed('privateKey'),
      )).thenAnswer(
          (realInvocation) => Future.value(Iden3commMocks.connectionEntities));
      when(checkProfileAndDidCurrentEnvUseCase.execute(
              param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.value(null));
    });

    test(
        "When I call execute, then I expect a list of ConnectionEntity to be returned",
        () async {
      // When
      expect(await useCase.execute(param: param), connectionEntities);

      // Then
      var captureCheck = verify(checkProfileAndDidCurrentEnvUseCase.execute(
              param: captureAnyNamed('param')))
          .captured
          .first;
      expect(captureCheck.did, CommonMocks.did);
      expect(captureCheck.privateKey, CommonMocks.privateKey);
      expect(captureCheck.profileNonce, CommonMocks.genesisNonce);

      var capturedGet = verify(iden3commRepository.getConnections(
              genesisDid: captureAnyNamed('genesisDid'),
              profileNonce: captureAnyNamed('profileNonce'),
              privateKey: captureAnyNamed('privateKey')))
          .captured;
      expect(capturedGet[0], CommonMocks.did);
      expect(capturedGet[1], CommonMocks.genesisNonce);
      expect(capturedGet[2], CommonMocks.privateKey);
    });

    test(
        "Given a non genesis profile, When I call execute, then I expect a list of ConnectionEntity to be returned",
        () async {
      // When
      expect(await useCase.execute(param: profileParam),
          Iden3commMocks.connectionEntities);

      // Then
      var captureCheck = verify(checkProfileAndDidCurrentEnvUseCase.execute(
              param: captureAnyNamed('param')))
          .captured
          .first;
      expect(captureCheck.did, CommonMocks.did);
      expect(captureCheck.privateKey, CommonMocks.privateKey);
      expect(captureCheck.profileNonce, CommonMocks.nonce);

      var capturedGet = verify(iden3commRepository.getConnections(
              genesisDid: captureAnyNamed('genesisDid'),
              profileNonce: captureAnyNamed('profileNonce'),
              privateKey: captureAnyNamed('privateKey')))
          .captured;
      expect(capturedGet[0], CommonMocks.did);
      expect(capturedGet[1], CommonMocks.nonce);
      expect(capturedGet[2], CommonMocks.privateKey);
    });

    test(
        "When I call execute and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(iden3commRepository.getConnections(
        genesisDid: captureAnyNamed('genesisDid'),
        profileNonce: captureAnyNamed('profileNonce'),
        privateKey: captureAnyNamed('privateKey'),
      )).thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(useCase.execute(param: param), throwsA(exception));

      // Then
      var captureCheck = verify(checkProfileAndDidCurrentEnvUseCase.execute(
              param: captureAnyNamed('param')))
          .captured
          .first;
      expect(captureCheck.did, CommonMocks.did);
      expect(captureCheck.privateKey, CommonMocks.privateKey);
      expect(captureCheck.profileNonce, CommonMocks.genesisNonce);

      var capturedGet = verify(iden3commRepository.getConnections(
        genesisDid: captureAnyNamed('genesisDid'),
        profileNonce: captureAnyNamed('profileNonce'),
        privateKey: captureAnyNamed('privateKey'),
      )).captured;
      expect(capturedGet[0], CommonMocks.did);
      expect(capturedGet[1], CommonMocks.genesisNonce);
      expect(capturedGet[2], CommonMocks.privateKey);
    });

    test(
        "Given a non genesis profile, When I call execute and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(iden3commRepository.getConnections(
        genesisDid: captureAnyNamed('genesisDid'),
        profileNonce: captureAnyNamed('profileNonce'),
        privateKey: captureAnyNamed('privateKey'),
      )).thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(
          useCase.execute(param: profileParam), throwsA(exception));

      // Then
      var captureCheck = verify(checkProfileAndDidCurrentEnvUseCase.execute(
              param: captureAnyNamed('param')))
          .captured
          .first;
      expect(captureCheck.did, CommonMocks.did);
      expect(captureCheck.privateKey, CommonMocks.privateKey);
      expect(captureCheck.profileNonce, CommonMocks.nonce);

      var capturedGet = verify(iden3commRepository.getConnections(
        genesisDid: captureAnyNamed('genesisDid'),
        profileNonce: captureAnyNamed('profileNonce'),
        privateKey: captureAnyNamed('privateKey'),
      )).captured;
      expect(capturedGet[0], CommonMocks.did);
      expect(capturedGet[1], CommonMocks.nonce);
      expect(capturedGet[2], CommonMocks.privateKey);
    });
  });
}
