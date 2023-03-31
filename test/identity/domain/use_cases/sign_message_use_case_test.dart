import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/sign_message_use_case.dart';

import 'sign_message_use_case_test.mocks.dart';

// Data
const message = "theMessage";
const privateKey = "theIdentifier";
const result = "theSignature";
var exception = Exception();
final param = SignMessageParam(privateKey, message);

// Dependencies
MockIdentityRepository identityRepository = MockIdentityRepository();

// Tested instance
SignMessageUseCase useCase = SignMessageUseCase(identityRepository);

@GenerateMocks([IdentityRepository])
void main() {
  test(
      "Given a private key and a message, when I call execute, then I expect a String to be returned",
      () async {
    // Given
    when(identityRepository.signMessage(
            privateKey: anyNamed('privateKey'), message: anyNamed('message')))
        .thenAnswer((realInvocation) => Future.value(result));

    // When
    expect(await useCase.execute(param: param), result);

    // Then
    var signCaptured = verify(identityRepository.signMessage(
            privateKey: captureAnyNamed('privateKey'),
            message: captureAnyNamed('message')))
        .captured;
    expect(signCaptured[0], privateKey);
    expect(signCaptured[1], message);
  });

  test(
      "Given a private key and a message, when I call execute and an error occured, then I expect an exception to be thrown",
      () async {
    // Given
    when(identityRepository.signMessage(
            privateKey: anyNamed('privateKey'), message: anyNamed('message')))
        .thenAnswer((realInvocation) => Future.error(exception));

    // When
    await expectLater(useCase.execute(param: param), throwsA(exception));

    // Then
    var signCaptured = verify(identityRepository.signMessage(
            privateKey: captureAnyNamed('privateKey'),
            message: captureAnyNamed('message')))
        .captured;
    expect(signCaptured[0], privateKey);
    expect(signCaptured[1], message);
  });
}
