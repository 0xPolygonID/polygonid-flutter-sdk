import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';

class ProofGenerationException extends ErrorException {
  ProofGenerationException(error) : super(error);
}

class NullAtomicQueryInputsException implements Exception {
  final String? id;

  NullAtomicQueryInputsException(this.id);
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
