import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';

class ProofGenerationException extends ErrorException {
  ProofGenerationException(error) : super(error);
}

class NullAtomicQueryInputsException implements Exception {
  final String? id;
  final String? errorMessage;

  NullAtomicQueryInputsException(this.id, {this.errorMessage});
}

class NullWitnessException implements Exception {
  final String? circuit;

  NullWitnessException(this.circuit);
}

class GenerateNonRevProofException extends ErrorException {
  GenerateNonRevProofException(error) : super(error);
}

class NullProofException implements Exception {
  final String? circuit;

  NullProofException(this.circuit);
}

class FetchGistProofException extends ErrorException {
  FetchGistProofException(error) : super(error);
}

class ProofInputsException implements Exception {
  final String? errorMessage;

  ProofInputsException(this.errorMessage);
}

class IdentityInputsException implements Exception {
  final String? errorMessage;

  IdentityInputsException(this.errorMessage);
}

class CircuitNotDownloadedException implements Exception {
  final String circuit;
  final String errorMessage;

  CircuitNotDownloadedException({
    required this.circuit,
    required this.errorMessage,
  });
}
