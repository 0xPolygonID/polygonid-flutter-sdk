import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/update_claim_use_case.dart';

import 'update_claim_use_case_test.mocks.dart';

// Data
const id = "theId";
const issuer = "theIssuer";
const otherIssuer = "theOtherIssuer";
const identifier = "theIdentifier";
const state = ClaimState.active;
const expiration = "theExpiration";
const otherExpiration = "theOtherExpiration";
const type = "theType";
const data = {"some": "data"};
const otherData = {"some": "otherData"};
final exception = Exception();

final UpdateClaimParam param = UpdateClaimParam(
    id: id, issuer: otherIssuer, expiration: otherExpiration, data: otherData);

final claimEntity = ClaimEntity(
    issuer: issuer,
    identifier: identifier,
    expiration: expiration,
    info: data,
    type: type,
    state: ClaimState.active,
    id: id);

final otherClaimEntity = ClaimEntity(
    issuer: otherIssuer,
    identifier: identifier,
    expiration: otherExpiration,
    info: otherData,
    type: type,
    state: ClaimState.active,
    id: id);

// Dependencies
MockCredentialRepository credentialRepository = MockCredentialRepository();

// Tested instance
UpdateClaimUseCase useCase = UpdateClaimUseCase(credentialRepository);

@GenerateMocks([CredentialRepository])
void main() {
  group("Update claim", () {
    setUp(() {
      reset(credentialRepository);

      // Given
      when(credentialRepository.getClaim(id: anyNamed('id')))
          .thenAnswer((realInvocation) => Future.value(claimEntity));
      when(credentialRepository.updateClaim(claim: anyNamed('claim')))
          .thenAnswer((realInvocation) => Future.value(otherClaimEntity));
    });

    test(
        "Given an UpdateClaimParam, when I call execute, then I expect an ClaimEntity to be returned",
        () async {
      // When
      expect(await useCase.execute(param: param), otherClaimEntity);

      // Then
      expect(
          verify(credentialRepository.getClaim(id: captureAnyNamed('id')))
              .captured
              .first,
          id);
      expect(
          verify(credentialRepository.updateClaim(
                  claim: captureAnyNamed('claim')))
              .captured
              .first,
          otherClaimEntity);
    });

    test(
        "Given an UpdateClaimParam, when I call execute and an error occurred, then I expect an exception to be thrown",
        () async {
      // Given
      when(credentialRepository.getClaim(id: anyNamed('id')))
          .thenAnswer((realInvocation) => Future.error(exception));

      // When
      await expectLater(useCase.execute(param: param), throwsA(exception));

      // Then
      expect(
          verify(credentialRepository.getClaim(id: captureAnyNamed('id')))
              .captured
              .first,
          id);
      verifyNever(
          credentialRepository.updateClaim(claim: captureAnyNamed('claim')));
    });
  });
}
