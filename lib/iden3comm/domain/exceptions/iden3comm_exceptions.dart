import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_request_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';

class UnsupportedIden3MsgTypeException implements Exception {
  final Iden3MessageType type;

  UnsupportedIden3MsgTypeException(this.type);
}

class InvalidIden3MsgTypeException implements Exception {
  final Iden3MessageType expected;
  final Iden3MessageType actual;

  InvalidIden3MsgTypeException(this.expected, this.actual);
}

class InvalidProofReqException implements Exception {
  final String message;

  InvalidProofReqException(this.message);
}

class ProofsNotFoundException implements Exception {
  final List<ProofRequestEntity> proofRequests;

  ProofsNotFoundException(this.proofRequests);
}

class CredentialsNotFoundException implements Exception {
  final List<ProofRequestEntity> proofRequests;

  CredentialsNotFoundException(this.proofRequests);
}

class UnsupportedSchemaException implements Exception {}

class NullAuthenticateCallbackException implements Exception {
  final AuthIden3MessageEntity authRequest;

  NullAuthenticateCallbackException(this.authRequest);
}

class FetchClaimException extends ErrorException {
  FetchClaimException(error) : super(error);
}

class FetchSchemaException extends ErrorException {
  FetchSchemaException(error) : super(error);
}

class UnsupportedFetchClaimTypeException extends ErrorException {
  UnsupportedFetchClaimTypeException(error) : super(error);
}

class GetConnectionsException extends ErrorException {
  GetConnectionsException(error) : super(error);
}
