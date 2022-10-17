import '../entities/iden3_message_entity.dart';

class UnsupportedIden3MsgTypeException implements Exception {
  final Iden3MessageType type;

  UnsupportedIden3MsgTypeException(this.type);
}

class InvalidProofReqException implements Exception {}
