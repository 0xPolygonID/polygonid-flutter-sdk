import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';

class ProofGenerationException extends PolygonIdSDKException {
  ProofGenerationException({
    required super.errorMessage,
    super.error,
  });
}

class NullAtomicQueryInputsException extends PolygonIdSDKException {
  final String? id;

  NullAtomicQueryInputsException({
    required this.id,
    required super.errorMessage,
    super.error,
  });
}

class NullWitnessException extends PolygonIdSDKException {
  final String? circuit;

  NullWitnessException({
    required this.circuit,
    required super.errorMessage,
    super.error,
  });
}

class GenerateNonRevProofException extends PolygonIdSDKException {
  GenerateNonRevProofException({
    required super.errorMessage,
    super.error,
  });
}

class NullProofException extends PolygonIdSDKException {
  final String? circuit;

  NullProofException({
    required this.circuit,
    required super.errorMessage,
    super.error,
  });
}

class FetchGistProofException extends PolygonIdSDKException {
  FetchGistProofException({
    required super.errorMessage,
    super.error,
  });
}

class ProofInputsException extends PolygonIdSDKException {
  ProofInputsException({
    required super.errorMessage,
    super.error,
  });
}

class CredentialInputsException extends PolygonIdSDKException {
  CredentialInputsException({
    required super.errorMessage,
    super.error,
  });
}

class IdentityInputsException extends PolygonIdSDKException {
  IdentityInputsException({
    required super.errorMessage,
    super.error,
  });
}

class CircuitNotDownloadedException extends PolygonIdSDKException {
  final String circuit;

  CircuitNotDownloadedException({
    required this.circuit,
    required super.errorMessage,
    super.error,
  });
}
