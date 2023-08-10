import 'dart:async';

import 'package:injectable/injectable.dart';

@lazySingleton
class StacktraceStreamManager {
  bool isEnabled = false;
  String _stacktrace = '';
  String _errorTrace = '';
  StreamController<String> _stacktraceStreamManagerController =
      StreamController<String>.broadcast();

  StreamController<String> _errorStreamManagerController =
      StreamController<String>.broadcast();

  Stream<String> get stacktraceStream =>
      _stacktraceStreamManagerController.stream;

  Stream<String> get errorStream =>
      _errorStreamManagerController.stream;

  /// we reset the stream
  /// so we can use it again
  void reset() {
    _stacktraceStreamManagerController.close();
    _errorStreamManagerController.close();
    // we reset the stream
    _stacktraceStreamManagerController = StreamController<String>.broadcast();
    _errorStreamManagerController = StreamController<String>.broadcast();
  }

  /// we clear the stacktrace
  void clear() {
    _stacktrace = '';
    _errorTrace = '';
    _stacktraceStreamManagerController.add(_stacktrace);
    _errorStreamManagerController.add(_errorTrace);
  }

  /// we close the stream
  void dispose() {
    _stacktraceStreamManagerController.close();
    _errorStreamManagerController.close();
  }

  /// we add a new trace to the stacktrace stream
  void addTrace(String stepDescription) {
    if (!isEnabled) return;
    _stacktrace += stepDescription + '\n***\n***';
    _stacktraceStreamManagerController.add(stepDescription);
  }

  void addError(String error) {
    _errorTrace += '\n***' + error + '\n***';
    _errorStreamManagerController.add(error);
  }

  /// get the stacktrace
  String get stacktrace => _stacktrace;

  /// get the error trace
  String get errorTrace => _errorTrace;
}
