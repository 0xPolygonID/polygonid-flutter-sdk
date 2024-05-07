import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_request_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';

class UnsupportedIden3MsgTypeException extends PolygonIdSDKException {
  final Iden3MessageType type;

  UnsupportedIden3MsgTypeException({
    required this.type,
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class InvalidIden3MsgTypeException extends PolygonIdSDKException {
  final Iden3MessageType expected;
  final Iden3MessageType actual;

  InvalidIden3MsgTypeException({
    required this.expected,
    required this.actual,
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class InvalidProofReqException extends PolygonIdSDKException {
  InvalidProofReqException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class ProofsNotCreatedException extends PolygonIdSDKException {
  final List<ProofRequestEntity> proofRequests;

  ProofsNotCreatedException({
    required this.proofRequests,
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class CredentialsNotFoundException extends PolygonIdSDKException {
  final List<ProofRequestEntity> proofRequests;

  CredentialsNotFoundException({
    required this.proofRequests,
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class UnsupportedSchemaException extends PolygonIdSDKException {
  final String schema;

  UnsupportedSchemaException({
    required this.schema,
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class NullAuthenticateCallbackException extends PolygonIdSDKException {
  final AuthIden3MessageEntity authRequest;

  NullAuthenticateCallbackException({
    required this.authRequest,
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class FetchClaimException extends PolygonIdSDKException {
  FetchClaimException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class FetchSchemaException extends PolygonIdSDKException {
  FetchSchemaException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class FetchDisplayTypeException extends PolygonIdSDKException {
  FetchDisplayTypeException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class UnsupportedFetchClaimTypeException extends PolygonIdSDKException {
  final String type;

  UnsupportedFetchClaimTypeException({
    required this.type,
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class GetConnectionsException extends PolygonIdSDKException {
  GetConnectionsException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class OperatorException extends PolygonIdSDKException {
  OperatorException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class GetAuthTokenException extends PolygonIdSDKException {
  GetAuthTokenException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class CheckProfileValidityException extends PolygonIdSDKException {
  CheckProfileValidityException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}
