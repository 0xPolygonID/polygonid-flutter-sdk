abstract class PolygonIdSdkLogger {
  void d(dynamic message, [dynamic error, StackTrace? stackTrace]);

  void i(dynamic message, [dynamic error, StackTrace? stackTrace]);

  void w(dynamic message, [dynamic error, StackTrace? stackTrace]);

  void e(dynamic message, [dynamic error, StackTrace? stackTrace]);
}

// Avoid crashing if logger is not defined
class NoLogger extends PolygonIdSdkLogger {
  @override
  void d(message, [error, StackTrace? stackTrace]) {}

  @override
  void e(message, [error, StackTrace? stackTrace]) {}

  @override
  void i(message, [error, StackTrace? stackTrace]) {}

  @override
  void w(message, [error, StackTrace? stackTrace]) {}
}

class Domain {
  static bool logEnabled = false;
  static PolygonIdSdkLogger? logger;
}

PolygonIdSdkLogger logger() =>
    Domain.logEnabled ? Domain.logger ?? NoLogger() : NoLogger();

extension LogTimestampExtension on PolygonIdSdkLogger {
  void logTimestamp(Stopwatch stopwatch, String message, {String? tag}) {
    String log = message;
    if (tag != null) {
      log = '[$tag]: $log';
    }

    log += ' at ${stopwatch.elapsedMilliseconds} ms';
    i(log);
  }
}
