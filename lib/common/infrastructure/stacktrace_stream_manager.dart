import 'dart:async';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class StacktraceManager {
  bool isEnabled = false;
  static const String stacktraceBoxName = 'stacktrace';
  String _errorTrace = '';
  StreamController<String> _stacktraceStreamController =
      StreamController<String>.broadcast();

  StreamController<String> _errorStreamController =
      StreamController<String>.broadcast();

  Stream<String> get stacktraceStream => _stacktraceStreamController.stream;

  Stream<String> get errorStream => _errorStreamController.stream;

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
    _errorTrace = '';
    _stacktraceStreamController.add('');
    _errorStreamController.add(_errorTrace);
    if (!isEnabled) {
      return;
    }

    if (_isBoxOpen()) {
      var box = Hive.box(stacktraceBoxName);
      box.clear();
    }
  }

  /// we close the stream
  void dispose() {
    _stacktraceStreamController.close();
    _errorStreamController.close();
  }

  /// we add a new trace to the stacktrace stream
  void addTrace(String stepDescription) {
    if (!isEnabled || !_isBoxOpen()) return;
    //write string in an external txt file

    var box = Hive.box(stacktraceBoxName);

    String _stacktrace = box.get(stacktraceBoxName) ?? '';
    _stacktrace += stepDescription + '\n***\n***';
    box.put(stacktraceBoxName, _stacktrace);
    _stacktraceStreamController.add(stepDescription);
  }

  void addError(String error) {
    _errorTrace += '\n***' + error + '\n***';
    _errorStreamController.add(error);
  }

  /// get the stacktrace
  String get stacktrace {
    if (!_isBoxOpen()) return '';
    var box = Hive.box(stacktraceBoxName);
    String _stacktrace = box.get(stacktraceBoxName) ?? '';
    return _stacktrace;
  }

  /// get the error trace
  String get errorTrace => _errorTrace;

  ///
  bool _isBoxOpen() => Hive.isBoxOpen(stacktraceBoxName);
}
