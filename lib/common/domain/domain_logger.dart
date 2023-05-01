abstract class PolygonIdSdkLogger {
  void v(dynamic message, [dynamic error, StackTrace? stackTrace]);

  void d(dynamic message, [dynamic error, StackTrace? stackTrace]);

  void i(dynamic message, [dynamic error, StackTrace? stackTrace]);

  void w(dynamic message, [dynamic error, StackTrace? stackTrace]);

  void e(dynamic message, [dynamic error, StackTrace? stackTrace]);

  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]);
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
  void v(message, [error, StackTrace? stackTrace]) {}

  @override
  void w(message, [error, StackTrace? stackTrace]) {}

  @override
  void wtf(message, [error, StackTrace? stackTrace]) {}
}

class Domain {
  static PolygonIdSdkLogger? logger;
}

PolygonIdSdkLogger logger() => Domain.logger ?? NoLogger();
