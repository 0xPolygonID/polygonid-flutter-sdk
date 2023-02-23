import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_credential_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_vocabs_use_case.dart';

import '../../../common/iden3comm_mocks.dart';
import 'get_vocabs_use_case_test.mocks.dart';

// Dependencies
MockIden3commCredentialRepository iden3commCredentialRepository =
    MockIden3commCredentialRepository();

// Tested instance
GetVocabsUseCase useCase = GetVocabsUseCase(iden3commCredentialRepository);

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

@GenerateMocks([Iden3commCredentialRepository])
void main() {
  group(
    "Get vocabs",
    () {
      setUp(() {
        // Given
        reset(iden3commCredentialRepository);

        when(iden3commCredentialRepository.fetchSchema(url: anyNamed('url')))
            .thenAnswer((realInvocation) => Future.value(schema));

        when(iden3commCredentialRepository.fetchVocab(
                schema: anyNamed('schema'), type: anyNamed('type')))
            .thenAnswer((realInvocation) => Future.value(vocab));
      });

      test(
        'Given an Iden3MessageEntity, when I call execute, then I expect a list of Map<String, dynamic>',
        () async {
          for (int i = 0; i < messages.length; i++) {
            // When
            expect(await useCase.execute(param: messages[i]), expectations[i]);

            // Then
            var verifySchema = verify(iden3commCredentialRepository.fetchSchema(
                url: captureAnyNamed('url')));
            expect(verifySchema.callCount, messages[i].body.scope.length);

            for (int j = 0; j < messages[i].body.scope.length; j++) {
              expect(verifySchema.captured[j],
                  messages[i].body.scope[j].query.context);
            }

            var verifyVocab = verify(iden3commCredentialRepository.fetchVocab(
                schema: captureAnyNamed('schema'),
                type: captureAnyNamed('type')));
            int count = messages[i].body.scope.length;
            expect(verifyVocab.callCount, count);

            for (int j = 0; j < messages[i].body.scope.length; j++) {
              expect(verifyVocab.captured[j * count], schema);
              expect(verifyVocab.captured[j * count + 1],
                  messages[i].body.scope[j].query.type);
            }
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
          verifyNever(iden3commCredentialRepository.fetchSchema(
              url: captureAnyNamed('url')));
          verifyNever(iden3commCredentialRepository.fetchVocab(
              schema: captureAnyNamed('schema'),
              type: captureAnyNamed('type')));
        },
      );

      test(
        'Given a Iden3MessageEntity, when I call execute and an error occurred, I expect an empty array to be returned',
        () async {
          when(iden3commCredentialRepository.fetchSchema(url: anyNamed('url')))
              .thenAnswer((realInvocation) => Future.error(exception));

          expect(await useCase.execute(param: Iden3commMocks.authRequest), []);

          // Then
          var verifySchema = verify(iden3commCredentialRepository.fetchSchema(
              url: captureAnyNamed('url')));
          expect(verifySchema.callCount, 2);
          verifyNever(iden3commCredentialRepository.fetchVocab(
              schema: captureAnyNamed('schema'),
              type: captureAnyNamed('type')));
        },
      );
    },
  );
}
