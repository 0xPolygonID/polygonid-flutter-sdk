import 'dart:async';

import 'package:injectable/injectable.dart';

@lazySingleton
class StacktraceManager {
  bool isEnabled = false;
  String _stacktrace = '';
  String _errorTrace = '';
  StreamController<String> _stacktraceStreamController =
      StreamController<String>.broadcast();

  StreamController<String> _errorStreamController =
      StreamController<String>.broadcast();

  Stream<String> get stacktraceStream =>
      _stacktraceStreamController.stream;

  Stream<String> get errorStream =>
      _errorStreamController.stream;

  /// we reset the stream
  /// so we can use it again
  void reset() {
    _stacktraceStreamController.close();
    _errorStreamController.close();
    // we reset the stream
    _stacktraceStreamController = StreamController<String>.broadcast();
    _errorStreamController = StreamController<String>.broadcast();
  }

  /// we clear the stacktrace
  void clear() {
    _stacktrace = '';
    _errorTrace = '';
    _stacktraceStreamController.add(_stacktrace);
    _errorStreamController.add(_errorTrace);
  }

  /// we close the stream
  void dispose() {
    _stacktraceStreamController.close();
    _errorStreamController.close();
  }

  /// we add a new trace to the stacktrace stream
  void addTrace(String stepDescription) {
    if (!isEnabled) return;
    _stacktrace += stepDescription + '\n***\n***';
    _stacktraceStreamController.add(stepDescription);
  }

  void addError(String error) {
    _errorTrace += '\n***' + error + '\n***';
    _errorStreamController.add(error);
  }

  /// get the stacktrace
  String get stacktrace => _stacktrace;

  /// get the error trace
  String get errorTrace => _errorTrace;
}
