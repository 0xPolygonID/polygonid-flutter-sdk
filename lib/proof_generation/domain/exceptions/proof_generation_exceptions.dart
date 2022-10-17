import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';

class ProofGenerationException extends ErrorException {
  ProofGenerationException(error) : super(error);
}

class NullAtomicQueryInputsException implements Exception {
  final String? circuit;

  NullAtomicQueryInputsException(this.circuit);
}

class NullWitnessException implements Exception {
  final String? circuit;

  NullWitnessException(this.circuit);
}

class NullProofException implements Exception {
  final String? circuit;

  NullProofException(this.circuit);
}
