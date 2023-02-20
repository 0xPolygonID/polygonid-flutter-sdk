import '../../../common/domain/error_exception.dart';
import '../entities/iden3_message_entity.dart';
import '../entities/proof_request_entity.dart';
import '../entities/request/auth/auth_iden3_message_entity.dart';

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
  final AuthIden3MessageEntity authRequest;

  NullAuthenticateCallbackException(this.authRequest);
}

class FetchClaimException extends ErrorException {
  FetchClaimException(error) : super(error);
}

class UnsupportedFetchClaimTypeException extends ErrorException {
  UnsupportedFetchClaimTypeException(error) : super(error);
}
