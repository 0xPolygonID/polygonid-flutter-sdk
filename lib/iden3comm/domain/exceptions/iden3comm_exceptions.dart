import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/auth_request.dart';

import '../entities/iden3_message_entity.dart';
import '../entities/proof_request_entity.dart';

class UnsupportedIden3MsgTypeException implements Exception {
  final Iden3MessageType type;

  UnsupportedIden3MsgTypeException(this.type);
}

class InvalidIden3MsgTypeException implements Exception {
  final Iden3MessageType expected;
  final Iden3MessageType actual;

  InvalidIden3MsgTypeException(this.expected, this.actual);
}

class InvalidProofReqException implements Exception {}

class ProofsNotFoundException implements Exception {
  final List<ProofRequestEntity> proofRequests;

  ProofsNotFoundException(this.proofRequests);
}

class NullAuthenticateCallbackException implements Exception {
  final AuthRequest authRequest;

  NullAuthenticateCallbackException(this.authRequest);
}
