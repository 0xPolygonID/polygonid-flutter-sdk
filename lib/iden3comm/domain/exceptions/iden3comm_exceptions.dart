import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_request_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';

class UnsupportedIden3MsgTypeException implements PolygonIdSDKException {
  final Iden3MessageType type;
  final String errorMessage;
  dynamic error;

  UnsupportedIden3MsgTypeException({
    required this.type,
    required this.errorMessage,
    this.error,
  });
}

class InvalidIden3MsgTypeException implements PolygonIdSDKException {
  final Iden3MessageType expected;
  final Iden3MessageType actual;
  final String errorMessage;
  dynamic error;

  InvalidIden3MsgTypeException({
    required this.expected,
    required this.actual,
    required this.errorMessage,
    this.error,
  });
}

class InvalidProofReqException implements PolygonIdSDKException {
  final String errorMessage;
  dynamic error;

  InvalidProofReqException({
    required this.errorMessage,
    this.error,
  });
}

class ProofsNotFoundException implements PolygonIdSDKException {
  final List<ProofRequestEntity> proofRequests;
  final String errorMessage;
  dynamic error;

  ProofsNotFoundException({
    required this.proofRequests,
    required this.errorMessage,
    this.error,
  });
}

class CredentialsNotFoundException implements PolygonIdSDKException {
  final List<ProofRequestEntity> proofRequests;
  final String errorMessage;
  dynamic error;

  CredentialsNotFoundException({
    required this.proofRequests,
    required this.errorMessage,
    this.error,
  });
}

class UnsupportedSchemaException implements PolygonIdSDKException {
  final String schema;
  final String errorMessage;
  dynamic error;

  UnsupportedSchemaException({
    required this.schema,
    required this.errorMessage,
    this.error,
  });
}

class NullAuthenticateCallbackException implements PolygonIdSDKException {
  final AuthIden3MessageEntity authRequest;
  final String errorMessage;
  dynamic error;

  NullAuthenticateCallbackException({
    required this.authRequest,
    required this.errorMessage,
    this.error,
  });
}

class FetchClaimException implements PolygonIdSDKException {
  final String errorMessage;
  dynamic error;

  FetchClaimException({
    required this.errorMessage,
    this.error,
  });
}

class FetchSchemaException implements PolygonIdSDKException {
  final String errorMessage;
  dynamic error;

  FetchSchemaException({
    required this.errorMessage,
    this.error,
  });
}

class FetchDisplayTypeException implements PolygonIdSDKException {
  final String errorMessage;
  dynamic error;

  FetchDisplayTypeException({
    required this.errorMessage,
    this.error,
  });
}

class UnsupportedFetchClaimTypeException implements PolygonIdSDKException {
  final String type;
  final String errorMessage;
  dynamic error;

  UnsupportedFetchClaimTypeException({
    required this.type,
    required this.errorMessage,
    this.error,
  });
}

class GetConnectionsException implements PolygonIdSDKException {
  final String errorMessage;
  dynamic error;

  GetConnectionsException({
    required this.errorMessage,
    this.error,
  });
}

class OperatorException implements PolygonIdSDKException {
  final String errorMessage;
  dynamic error;

  OperatorException({
    required this.errorMessage,
    this.error,
  });
}
