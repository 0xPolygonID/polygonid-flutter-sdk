import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/check_profile_validity_use_case.dart';

import '../../../../common/common_mocks.dart';

// Tested instance
CheckProfileValidityUseCase useCase = CheckProfileValidityUseCase();

void main() {
  test("Given param, when I call execute, I expect the process to complete",
      () async {
    // When
    await expectLater(
        useCase.execute(
            param: CheckProfileValidityParam(profileNonce: CommonMocks.nonce)),
        completes);
  });

  test(
      "Given param with invalid profileNonce, when I call execute, I expect an InvalidProfileNonceException to be thrown",
      () async {
    // When
    await useCase
        .execute(
            param: CheckProfileValidityParam(
                profileNonce: CommonMocks.negativeNonce))
        .then((value) => expect(true, false))
        .catchError((error) {
      expect(error, isA<InvalidProfileException>());
      expect(error.profileNonce, CommonMocks.negativeNonce);
    });
  });

  test(
      "Given param with a genesis profileNonce and we exclude it, when I call execute, I expect an InvalidProfileNonceException to be thrown",
      () async {
    // When
    await useCase
        .execute(
            param: CheckProfileValidityParam(
                profileNonce: CommonMocks.genesisNonce, excludeGenesis: true))
        .then((value) => expect(true, false))
        .catchError((error) {
      expect(error, isA<InvalidProfileException>());
      expect(error.profileNonce, CommonMocks.genesisNonce);
    });
  });
}
