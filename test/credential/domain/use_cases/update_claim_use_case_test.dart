import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/update_claim_use_case.dart';

import '../../../common/common_mocks.dart';
import 'update_claim_use_case_test.mocks.dart';

// Data
const id = "theId";
const issuer = "theIssuer";
const otherIssuer = "theOtherIssuer";
const identifier = "theIdentifier";
const state = CredentialState.active;
const expiration = "theExpiration";
const otherExpiration = "theOtherExpiration";
const type = "theType";
const data = {"some": "data"};
const otherData = {"some": "otherData"};
final exception = Exception();
const credentialRawValue = "theCredentialRawValue";

final UpdateClaimParam param = UpdateClaimParam(
    id: id,
    genesisDid: identifier,
    encryptionKey: CommonMocks.encryptionKey,
    issuer: otherIssuer,
    expiration: otherExpiration,
    data: otherData);

final claimEntity = CredentialEntity(
  issuer: issuer,
  did: identifier,
  expiration: expiration,
  info: data,
  type: type,
  state: CredentialState.active,
  id: id,
  credentialRawValue: credentialRawValue,
);

final otherClaimEntity = CredentialEntity(
  issuer: otherIssuer,
  did: identifier,
  expiration: otherExpiration,
  info: otherData,
  type: type,
  state: CredentialState.active,
  id: id,
  credentialRawValue: credentialRawValue,
);

// Dependencies
MockCredentialRepository credentialRepository = MockCredentialRepository();
MockStacktraceManager stacktraceManager = MockStacktraceManager();

// Tested instance
UpdateClaimUseCase useCase = UpdateClaimUseCase(
  credentialRepository,
  stacktraceManager,
);

@GenerateMocks([CredentialRepository, StacktraceManager])
void main() {
  group("Update credential", () {
    setUp(() {
      reset(credentialRepository);

      // Given
      when(credentialRepository.getCredential(
              genesisDid: anyNamed('genesisDid'),
              encryptionKey: anyNamed('encryptionKey'),
              claimId: anyNamed('claimId')))
          .thenAnswer((realInvocation) => Future.value(claimEntity));
      when(credentialRepository.saveCredentials(
              genesisDid: anyNamed('genesisDid'),
              encryptionKey: anyNamed('encryptionKey'),
              credentials: anyNamed('claims')))
          .thenAnswer((realInvocation) => Future.value(null));
    });

    test(
        "Given an UpdateClaimParam, when I call execute, then I expect an ClaimEntity to be returned",
        () async {
      // When
      expect(await useCase.execute(param: param), otherClaimEntity);

      // Then
      var capturedGet = verify(credentialRepository.getCredential(
              genesisDid: captureAnyNamed('genesisDid'),
              encryptionKey: captureAnyNamed('encryptionKey'),
              claimId: captureAnyNamed('claimId')))
          .captured;
      expect(capturedGet[0], identifier);
      expect(capturedGet[1], CommonMocks.encryptionKey);
      expect(capturedGet[2], id);

      var capturedSave = verify(credentialRepository.saveCredentials(
              genesisDid: captureAnyNamed('genesisDid'),
              encryptionKey: captureAnyNamed('encryptionKey'),
              credentials: captureAnyNamed('claims')))
          .captured;
      expect(capturedSave[0], identifier);
      expect(capturedSave[1], CommonMocks.encryptionKey);
      expect(capturedSave[2], [otherClaimEntity]);
    });

    test(
        "Given an UpdateClaimParam, when I call execute and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(credentialRepository.getCredential(
              genesisDid: anyNamed('genesisDid'),
              encryptionKey: anyNamed('encryptionKey'),
              claimId: anyNamed('claimId')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(useCase.execute(param: param), throwsA(exception));

      // Then
      var capturedGet = verify(credentialRepository.getCredential(
              genesisDid: captureAnyNamed('genesisDid'),
              encryptionKey: captureAnyNamed('encryptionKey'),
              claimId: captureAnyNamed('claimId')))
          .captured;
      expect(capturedGet[0], identifier);
      expect(capturedGet[1], CommonMocks.encryptionKey);
      expect(capturedGet[2], id);

      verifyNever(credentialRepository.saveCredentials(
          genesisDid: captureAnyNamed('genesisDid'),
          encryptionKey: captureAnyNamed('encryptionKey'),
          credentials: captureAnyNamed('claims')));
    });
  });
}
