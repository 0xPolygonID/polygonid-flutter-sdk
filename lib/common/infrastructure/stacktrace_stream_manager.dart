import 'dart:async';

import 'package:injectable/injectable.dart';

@lazySingleton
class StacktraceStreamManager {
  bool isEnabled = false;
  String _stacktrace = '';
  StreamController<String> _stacktraceStreamManagerController =
      StreamController<String>.broadcast();

  Stream<String> get stacktraceStream =>
      _stacktraceStreamManagerController.stream;

  /// we reset the stream
  /// so we can use it again
  void reset() {
    _stacktraceStreamManagerController.close();
    // we reset the stream
    _stacktraceStreamManagerController = StreamController<String>.broadcast();
  }

  /// we clear the stacktrace
  void clear() {
    _stacktrace = '';
    _stacktraceStreamManagerController.add(_stacktrace);
  }

  /// we close the stream
  void dispose() {
    _stacktraceStreamManagerController.close();
  }

  /// we add a new trace to the stacktrace stream
  void addTrace(String stepDescription) {
    if (!isEnabled) return;
    _stacktrace += stepDescription + '\n***\n***\n***';
    _stacktraceStreamManagerController.add(_stacktrace);
  }
}
