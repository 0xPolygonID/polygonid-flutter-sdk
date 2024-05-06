import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';

class ProofGenerationException extends PolygonIdSDKException {
  ProofGenerationException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class NullAtomicQueryInputsException extends PolygonIdSDKException {
  final String? id;

  NullAtomicQueryInputsException({
    required this.id,
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class NullWitnessException extends PolygonIdSDKException {
  final String? circuit;

  NullWitnessException({
    required this.circuit,
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class GenerateNonRevProofException extends PolygonIdSDKException {
  GenerateNonRevProofException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class NullProofException extends PolygonIdSDKException {
  final String? circuit;

  NullProofException({
    required this.circuit,
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class FetchGistProofException extends PolygonIdSDKException {
  FetchGistProofException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class ProofInputsException extends PolygonIdSDKException {
  ProofInputsException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class CredentialInputsException extends PolygonIdSDKException {
  CredentialInputsException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class IdentityInputsException extends PolygonIdSDKException {
  IdentityInputsException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}

class CircuitNotDownloadedException extends PolygonIdSDKException {
  CircuitNotDownloadedException({
    required String errorMessage,
    dynamic error,
  }) : super(errorMessage: errorMessage, error: error);
}
