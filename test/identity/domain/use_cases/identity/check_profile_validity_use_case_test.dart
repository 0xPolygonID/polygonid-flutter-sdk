import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/check_profile_validity_use_case.dart';

// Tested instance
CheckProfileValidityUseCase useCase = CheckProfileValidityUseCase();

void main() {
  test("Given param, when I call execute, I expect the process to complete",
      () async {
    // When
    await expectLater(
        useCase.execute(param: CheckProfileValidityParam(profileNonce: 1)),
        completes);
  });

  test(
      "Given param with invalid profileNonce, when I call execute, I expect an InvalidProfileNonceException to be thrown",
      () async {
    // When
    await useCase
        .execute(param: CheckProfileValidityParam(profileNonce: -1))
        .then((value) => expect(true, false))
        .catchError((error) {
      expect(error, isA<InvalidProfileException>());
      expect(error.profileNonce, -1);
    });
  });

  test(
      "Given param with a genesis profileNonce and we exclude it, when I call execute, I expect an InvalidProfileNonceException to be thrown",
      () async {
    // When
    await useCase
        .execute(
            param: CheckProfileValidityParam(
                profileNonce: 0, excludeGenesis: true))
        .then((value) => expect(true, false))
        .catchError((error) {
      expect(error, isA<InvalidProfileException>());
      expect(error.profileNonce, 0);
    });
  });
}
