import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_request_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/offer_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/iden3_message_factory.dart';

import '../../common/iden3comm_mocks.dart';
import 'iden3_message_factory_test.mocks.dart';

// Mocks

final unknown = jsonEncode({
  'type': 'unknown',
  'body': 'unknown',
});

// Data
final messages = [
  Iden3commMocks.authRequestJson,
  Iden3commMocks.offerRequestJson,
  Iden3commMocks.fetchRequestJson,
  Iden3commMocks.contractFunctionCallRequestJson
];
final expectations = <Iden3Message>[
  Iden3commMocks.authRequest,
  Iden3commMocks.offerRequest,
  Iden3commMocks.fetchRequest,
  Iden3commMocks.contractFunctionCallRequest
];
const types = [
  Iden3MessageType.authRequest,
  Iden3MessageType.credentialOffer,
  Iden3MessageType.fetchRequest,
  Iden3MessageType.proofContractInvokeRequest
];

@GenerateMocks([
  StacktraceManager,
])
void main() {
  late Iden3MessageFactory factory;
  late StacktraceManager stacktraceManager;

  setUp(() {
    stacktraceManager = MockStacktraceManager();
    factory = Iden3MessageFactory(stacktraceManager);
  });

  test('parses authRequest message', () {
    final rawMessage =
        '{"type":"https://iden3-communication.io/authorization/1.0/request","id":"123","thid":"","from":"","body":{"callbackUrl":"","scope":[]}}';
    final msg = factory.createMessage(rawMessage: rawMessage);
    expect(msg, isA<AuthorizationRequestMessage>());
    expect(msg.id, '123');
  });

  test('throws on unsupported type', () {
    final rawMessage = '{"type":"unsupported-type","id":"123"}';
    expect(
      () => factory.createMessage(rawMessage: rawMessage),
      throwsA(isA<UnsupportedIden3MsgTypeException>()),
    );
  });

  test('throws on invalid json', () {
    final rawMessage = 'not a json';
    expect(
      () => factory.createMessage(rawMessage: rawMessage),
      throwsA(isA<FormatException>()),
    );
  });

  test('parses credentialOffer message', () {
    final rawMessage =
        '{"type":"https://iden3-communication.io/credentials/1.0/offer","id":"456","thid":"","from":"","to":"","body":{"url":"","credentials":[]}}';
    final msg = factory.createMessage(rawMessage: rawMessage);
    expect(msg, isA<CredentialsOfferMessage>());
    expect(msg.id, '456');
  });

  test('parse expected messages', () {
    for (int i = 0; i < messages.length; i++) {
      final rawMessage = messages[i];
      final expectedType = types[i];
      final expectedMessage = expectations[i];

      final msg = factory.createMessage(rawMessage: rawMessage);
      expect(msg, isA<Iden3Message>());
      expect(msg.type, expectedType);
      expect(msg.toJson(), expectedMessage.toJson());
    }
  });
}
