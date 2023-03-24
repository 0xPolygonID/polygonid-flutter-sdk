import 'dart:async';
import 'package:injectable/injectable.dart';

@lazySingleton
class ProofGenerationStepsStreamManager {
  StreamController<String> _proofGenerationStepsStreamManagerController =
      StreamController<String>.broadcast();

  Stream<String> get proofGenerationStepsStream =>
      _proofGenerationStepsStreamManagerController.stream;

  /// we reset the stream
  /// so we can use it again
  void reset() {
    _proofGenerationStepsStreamManagerController.close();
    // we reset the stream
    _proofGenerationStepsStreamManagerController =
        StreamController<String>.broadcast();
  }

  /// we close the stream
  void dispose() {
    _proofGenerationStepsStreamManagerController.close();
  }

  /// we add a new step to the stream
  void add(String stepDescription) {
    _proofGenerationStepsStreamManagerController.add(stepDescription);
  }
}
