import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';

abstract class PolygonIdSdkErrorHandling {
  /// to enable stacktrace we need to call this method otherwise the stacktrace
  /// will not be saved
  void switchStacktrace({bool enabled = false});

  /// to get the stacktrace stream, so we can listen to it
  Stream<String> stacktraceStream();

  /// we can get the entire stacktrace of the latest flow execution
  String getStacktrace();

  /// to get the error stream, so we can listen to it
  Stream<String> errorTraceStream();

  /// to get the error of the latest flow execution
  String getErrorTrace();
}

@injectable
class ErrorHandling implements PolygonIdSdkErrorHandling {
  final StacktraceManager _stacktraceManager;

  ErrorHandling(this._stacktraceManager);

  ///
  void switchStacktrace({bool enabled = false}) {
    _stacktraceManager.isEnabled = enabled;
  }

  ///
  Stream<String> stacktraceStream() {
    return _stacktraceManager.stacktraceStream;
  }

  ///
  String getStacktrace() {
    return _stacktraceManager.stacktrace;
  }

  ///
  Stream<String> errorTraceStream() {
    return _stacktraceManager.errorStream;
  }

  ///
  String getErrorTrace() {
    return _stacktraceManager.errorTrace;
  }
}
