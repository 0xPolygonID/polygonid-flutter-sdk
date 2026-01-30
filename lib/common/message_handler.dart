import 'package:polygonid_flutter_sdk/common/common.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

class BasicHandlerOptions {
  final bool? allowExpiredMessages;
  final ProvingMethodAlg? messageProvingMethodAlg;
  final Map<String, String>? headers;

  BasicHandlerOptions({
    this.allowExpiredMessages,
    this.messageProvingMethodAlg,
    this.headers,
  });
}

/// iden3 Protocol message handler interface with generic context type
abstract interface class IProtocolMessageHandler {
  /// Handle message implementation
  ///
  /// [message] - The basic message to handle
  /// [context] - Strongly typed context with handler options
  /// Returns a [Future] that resolves to [Iden3Message] or null
  Future<Iden3Message?> handle(
    Iden3Message message,
    BasicHandlerOptions? context,
  );
}

abstract class AbstractMessageHandler implements IProtocolMessageHandler {
  AbstractMessageHandler? nextMessageHandler;

  @override
  Future<Iden3Message?> handle(
    Iden3Message message,
    BasicHandlerOptions? context,
  ) async {
    if (context?.allowExpiredMessages != true) {
      verifyExpiresTime(message);
    }
    final handler = this.nextMessageHandler;
    if (handler != null) {
      return handler.handle(message, context);
    }
    return Future.error(
      'Message handler not provided or message not supported',
    );
  }
}
