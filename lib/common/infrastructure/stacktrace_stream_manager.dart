import 'dart:async';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';

const _stacktraceBoxName = 'stacktrace';

@lazySingleton
class StacktraceManager {
  bool isEnabled = false;

  String _errorTrace = '';
  String _stacktrace = '';

  var _stacktraceStreamController = StreamController<String>.broadcast();
  var _errorStreamController = StreamController<String>.broadcast();

  Stream<String> get stacktraceStream => _stacktraceStreamController.stream;

  Stream<String> get errorStream => _errorStreamController.stream;

  /// Get the stacktrace
  String get stacktrace {
    if (!_isBoxOpen()) return '';
    var box = Hive.box(_stacktraceBoxName);
    final _stacktrace = box.get(_stacktraceBoxName) ?? '';
    return _stacktrace;
  }

  /// Get the error trace
  String get errorTrace => _errorTrace;

  /// Add new trace to the stacktrace
  void addTrace(String stepDescription, {bool log = false}) {
    if (log) {
      logger().i(stepDescription);
    }

    if (!isEnabled || !_isBoxOpen()) return;

    // write string in an encrypted Hive box
    final box = Hive.box(_stacktraceBoxName);

    _stacktrace += stepDescription + '\n***\n***';
    box.put(_stacktraceBoxName, _stacktrace);
    _stacktraceStreamController.add(stepDescription);
  }

  void addError(String error) {
    _errorTrace += '\n***' + error + '\n***';
    _errorStreamController.add(error);
  }

  /// we reset the stream
  /// so we can use it again
  void reset() {
    _stacktraceStreamController.close();
    _errorStreamController.close();
    // we reset the stream
    _stacktraceStreamController = StreamController<String>.broadcast();
    _errorStreamController = StreamController<String>.broadcast();
  }

  /// Clear the stacktrace
  void clear() {
    return;
    _stacktrace = '';
    _errorTrace = '';
    _stacktraceStreamController.add('');
    _errorStreamController.add(_errorTrace);
    if (!isEnabled) {
      return;
    }

    if (_isBoxOpen()) {
      final box = Hive.box(_stacktraceBoxName);
      box.clear();
    }
  }

  void clearStacktrace() {
    _stacktrace = '';
    _errorTrace = '';
    _stacktraceStreamController.add('');
    _errorStreamController.add(_errorTrace);
    if (!isEnabled) {
      return;
    }

    if (_isBoxOpen()) {
      final box = Hive.box(_stacktraceBoxName);
      box.clear();
    }
  }

  /// Close streams
  void dispose() {
    _stacktraceStreamController.close();
    _errorStreamController.close();
  }

  bool _isBoxOpen() => Hive.isBoxOpen(_stacktraceBoxName);
}
