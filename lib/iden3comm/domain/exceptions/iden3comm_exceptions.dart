import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_request_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';

class UnsupportedIden3MsgTypeException extends PolygonIdSDKException {
  final Iden3MessageType type;
  final Map<String, dynamic> message;

  UnsupportedIden3MsgTypeException({
    required this.type,
    required super.errorMessage,
    this.message = const {},
    super.error,
  });
}

class InvalidIden3MsgTypeException extends PolygonIdSDKException {
  final Iden3MessageType expected;
  final Iden3MessageType actual;

  InvalidIden3MsgTypeException({
    required this.expected,
    required this.actual,
    required super.errorMessage,
    super.error,
  });
}

class InvalidProofReqException extends PolygonIdSDKException {
  InvalidProofReqException({
    required super.errorMessage,
    super.error,
  });
}

class ProofsNotCreatedException extends PolygonIdSDKException {
  final List<ProofRequestEntity> proofRequests;

  ProofsNotCreatedException({
    required this.proofRequests,
    required super.errorMessage,
    super.error,
  });
}

class CredentialsNotFoundException extends PolygonIdSDKException {
  final List<ProofRequestEntity> proofRequests;

  CredentialsNotFoundException({
    required this.proofRequests,
    required super.errorMessage,
    super.error,
  });
}

class UnsupportedSchemaException extends PolygonIdSDKException {
  final String schema;

  UnsupportedSchemaException({
    required this.schema,
    required super.errorMessage,
    super.error,
  });
}

class NullAuthenticateCallbackException extends PolygonIdSDKException {
  final AuthIden3MessageEntity authRequest;

  NullAuthenticateCallbackException({
    required this.authRequest,
    required super.errorMessage,
    super.error,
  });
}

class FetchClaimException extends PolygonIdSDKException {
  FetchClaimException({
    required super.errorMessage,
    super.error,
  });
}

class FetchSchemaException extends PolygonIdSDKException {
  FetchSchemaException({
    required super.errorMessage,
    super.error,
  });
}

class FetchDisplayTypeException extends PolygonIdSDKException {
  FetchDisplayTypeException({
    required super.errorMessage,
    super.error,
  });
}

class UnsupportedFetchClaimTypeException extends PolygonIdSDKException {
  final String type;

  UnsupportedFetchClaimTypeException({
    required this.type,
    required super.errorMessage,
    super.error,
  });
}

class GetConnectionsException extends PolygonIdSDKException {
  GetConnectionsException({
    required super.errorMessage,
    super.error,
  });
}

class OperatorException extends PolygonIdSDKException {
  OperatorException({
    required super.errorMessage,
    super.error,
  });
}

class GetAuthTokenException extends PolygonIdSDKException {
  GetAuthTokenException({
    required super.errorMessage,
    super.error,
  });
}

class CheckProfileValidityException extends PolygonIdSDKException {
  CheckProfileValidityException({
    required super.errorMessage,
    super.error,
  });
}

class GetAuthChallengeException extends PolygonIdSDKException {
  GetAuthChallengeException({
    required super.errorMessage,
    super.error,
  });
}

class GetAuthInputsException extends PolygonIdSDKException {
  GetAuthInputsException({
    required super.errorMessage,
    super.error,
  });
}

class NoCredentialsFoundException extends PolygonIdSDKException {
  final ProofRequestEntity? proofRequest;

  NoCredentialsFoundException({
    this.proofRequest,
    required super.errorMessage,
    super.error,
  });
}

class ProofRequestsNotFoundException extends PolygonIdSDKException {
  final Iden3MessageEntity? message;

  ProofRequestsNotFoundException({
    this.message,
    required super.errorMessage,
    super.error,
  });
}
