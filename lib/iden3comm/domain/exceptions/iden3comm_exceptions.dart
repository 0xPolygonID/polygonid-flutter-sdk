import '../entities/iden3_message_entity.dart';
import '../entities/proof_request_entity.dart';

class UnsupportedIden3MsgTypeException implements Exception {
  final Iden3MessageType type;

  UnsupportedIden3MsgTypeException(this.type);
}

class InvalidProofReqException implements Exception {}

class ProofsNotFoundException implements Exception {
  final List<ProofRequestEntity> proofRequests;

  ProofsNotFoundException(this.proofRequests);
}

class NullAuthenticateCallbackException implements Exception {
  final Iden3MessageEntity message;

  NullAuthenticateCallbackException(this.message);
}
