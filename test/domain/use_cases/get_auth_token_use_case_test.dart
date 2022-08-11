import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/domain/identity/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/domain/identity/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/domain/identity/use_cases/get_auth_token_use_case.dart';

import 'get_auth_token_use_case_test.mocks.dart';

// Data
const message = "theMessage";
const identifier = "theIdentifier";
const circuitId = "1";
final datFile = Uint8List(32);
final zKeyFile = Uint8List(32);
final circuitData = CircuitDataEntity(circuitId, datFile, zKeyFile);
final param = GetAuthTokenParam(identifier, circuitData, message);
const result = "token";
var exception = Exception();

// Dependencies
MockIdentityRepository identityRepository = MockIdentityRepository();

// Tested instance
GetAuthTokenUseCase useCase = GetAuthTokenUseCase(identityRepository);

@GenerateMocks([IdentityRepository])
void main() {
  test(
      "Given an identifier, a circuitData and a message, when I call execute, then I expect a String to be returned",
      () async {
    // Given
    when(identityRepository.getAuthToken(
            identifier: anyNamed('identifier'),
            circuitData: anyNamed('circuitData'),
            message: anyNamed('message')))
        .thenAnswer((realInvocation) => Future.value(result));

    // When
    expect(await useCase.execute(param: param), result);

    // Then
    var authCaptured = verify(identityRepository.getAuthToken(
            identifier: captureAnyNamed('identifier'),
            circuitData: captureAnyNamed('circuitData'),
            message: captureAnyNamed('message')))
        .captured;
    expect(authCaptured[0], identifier);
    expect(authCaptured[1], circuitData);
    expect(authCaptured[2], message);
  });

  test(
      "Given an identifier, a circuitData and a message, when I call execute and an error occurred, then I expect an exception to be thrown",
      () async {
    // Given
    when(identityRepository.getAuthToken(
            identifier: anyNamed('identifier'),
            circuitData: anyNamed('circuitData'),
            message: anyNamed('message')))
        .thenAnswer((realInvocation) => Future.error(exception));

    // When
    await expectLater(useCase.execute(param: param), throwsA(exception));

    // Then
    var authCaptured = verify(identityRepository.getAuthToken(
            identifier: captureAnyNamed('identifier'),
            circuitData: captureAnyNamed('circuitData'),
            message: captureAnyNamed('message')))
        .captured;
    expect(authCaptured[0], identifier);
    expect(authCaptured[1], circuitData);
    expect(authCaptured[2], message);
  });
}
