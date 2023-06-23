import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3message_type_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3message_use_case.dart';

import '../../../common/common_mocks.dart';
import '../../../common/iden3comm_mocks.dart';
import 'get_iden3_message_use_case_test.mocks.dart';

// Data
final messages = [
  Iden3commMocks.authRequestJson,
  Iden3commMocks.offerRequestJson,
  Iden3commMocks.fetchRequestJson,
  Iden3commMocks.contractFunctionCallRequestJson
];
final expectations = [
  Iden3commMocks.authRequest,
  Iden3commMocks.offerRequest,
  Iden3commMocks.fetchRequest,
  Iden3commMocks.contractFunctionCallRequest
];
const types = [
  Iden3MessageType.authRequest,
  Iden3MessageType.credentialOffer,
  Iden3MessageType.credentialIssuanceResponse,
  Iden3MessageType.proofContractInvokeRequest
];

// Dependencies
MockGetIden3MessageTypeUseCase getIden3MessageTypeUseCase =
    MockGetIden3MessageTypeUseCase();

// Tested instance
GetIden3MessageUseCase useCase =
    GetIden3MessageUseCase(getIden3MessageTypeUseCase);

@GenerateMocks([GetIden3MessageTypeUseCase])
void main() {
  test(
    'Given a string, when I call execute, I expect a Iden3MessageType to be returned',
    () async {
      for (int i = 0; i < types.length; i++) {
        // Given
        reset(getIden3MessageTypeUseCase);
        when(getIden3MessageTypeUseCase.execute(param: anyNamed('param')))
            .thenAnswer((realInvocation) => Future.value(types[i]));

        // When
        expect(await useCase.execute(param: messages[i]), expectations[i]);
      }
    },
  );

  test(
    'Given a string with an unknown type, when I call execute, I expect a UnsupportedIden3MsgTypeException to be thrown',
    () async {
      reset(getIden3MessageTypeUseCase);
      when(getIden3MessageTypeUseCase.execute(param: anyNamed('param')))
          .thenAnswer(
              (realInvocation) => Future.value(Iden3MessageType.unknown));

      // When
      await useCase
          .execute(param: messages[0])
          .then((_) => expect(true, false))
          .catchError((error) {
        expect(error, isA<UnsupportedIden3MsgTypeException>());
        expect(error.type, Iden3MessageType.unknown);
      });
    },
  );

  test(
    'Given a string, when I call execute and an error occured, I expect that exception to be thrown',
    () async {
      reset(getIden3MessageTypeUseCase);
      when(getIden3MessageTypeUseCase.execute(param: anyNamed('param')))
          .thenAnswer((realInvocation) => Future.error(CommonMocks.exception));

      // When
      await useCase
          .execute(param: messages[0])
          .then((_) => expect(true, false))
          .catchError((error) {
        expect(error, CommonMocks.exception);
      });
    },
  );
}
