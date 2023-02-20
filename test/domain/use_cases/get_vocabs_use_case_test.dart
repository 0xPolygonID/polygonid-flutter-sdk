import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/fetch_schema_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/fetch_vocab_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_vocabs_use_case.dart';

import '../../common/iden3com_mocks.dart';
import 'get_vocabs_use_case_test.mocks.dart';

// Dependencies
MockFetchSchemaUseCase fetchSchemaUseCase = MockFetchSchemaUseCase();
MockFetchVocabUseCase fetchVocabUseCase = MockFetchVocabUseCase();

// Tested instance
GetVocabsUseCase useCase =
    GetVocabsUseCase(fetchSchemaUseCase, fetchVocabUseCase);

// Data
const Map<String, dynamic> schema = {
  "some": {"good": "schema"}
};
const Map<String, dynamic> vocab = {
  "some": {"good": "vocab"}
};
final exception = Exception();
final List<Iden3MessageEntity> messages = [
  Iden3commMocks.authRequest,
  Iden3commMocks.contractFunctionCallRequest
];
final expectations = [
  [vocab, vocab],
  [vocab]
];

@GenerateMocks([FetchSchemaUseCase, FetchVocabUseCase])
void main() {
  group(
    "Get vocabs",
    () {
      setUp(() {
        // Given
        reset(fetchSchemaUseCase);
        reset(fetchVocabUseCase);

        when(fetchSchemaUseCase.execute(param: anyNamed('param')))
            .thenAnswer((realInvocation) => Future.value(schema));

        when(fetchVocabUseCase.execute(param: anyNamed('param')))
            .thenAnswer((realInvocation) => Future.value(vocab));
      });

      test(
        'Given an Iden3MessageEntity, when I call execute, then I expect a list of Map<String, dynamic>',
        () async {
          for (int i = 0; i < messages.length; i++) {
            // When
            expect(await useCase.execute(param: messages[i]), expectations[i]);

            // Then
            expect(
                verify(fetchSchemaUseCase.execute(
                        param: captureAnyNamed('param')))
                    .callCount,
                messages[i].body.scope.length);

            var verifyVocab = verify(
                fetchVocabUseCase.execute(param: captureAnyNamed('param')));
            expect(verifyVocab.callCount, messages[i].body.scope.length);
            expect(verifyVocab.captured[0].schema, schema);
          }
        },
      );

      test(
        'Given an Iden3MessageEntity which is not supported, when I call execute, then I expect a UnsupportedIden3MsgTypeException to be thrown',
        () async {
          // When
          await useCase
              .execute(param: Iden3commMocks.fetchRequest)
              .then((_) => expect(true, false))
              .catchError((error) {
            expect(error, isA<UnsupportedIden3MsgTypeException>());
            expect(error.type, Iden3MessageType.issuance);
          });

          // Then
          verifyNever(
              fetchSchemaUseCase.execute(param: captureAnyNamed('param')));
          verifyNever(
              fetchVocabUseCase.execute(param: captureAnyNamed('param')));
        },
      );

      test(
        'Given a Iden3MessageEntity, when I call execute and an error occurred, I expect an empty array to be returned',
        () async {
          when(fetchSchemaUseCase.execute(param: anyNamed('param')))
              .thenAnswer((realInvocation) => Future.error(exception));

         await expectLater(useCase.execute(param: Iden3commMocks.authRequest), throwsA(exception));

          // Then
          verifyNever(
              fetchVocabUseCase.execute(param: captureAnyNamed('param')));
        },
      );
    },
  );
}
