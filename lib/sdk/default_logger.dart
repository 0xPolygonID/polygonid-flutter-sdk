import 'package:logger/logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';

class DefaultLogger implements PolygonIdSdkLogger {
  final Logger _logger;

  DefaultLogger(this._logger);

  @override
  void d(message, [error, StackTrace? stackTrace]) {
    if (logEnabled) {
      _logger.d(message, error, stackTrace);
    }
  }

  @override
  void e(message, [error, StackTrace? stackTrace]) {
    if (logEnabled) {
      _logger.e(message, error, stackTrace);
    }
  }

  @override
  void i(message, [error, StackTrace? stackTrace]) {
    if (logEnabled) {
      _logger.i(message, error, stackTrace);
    }
  }

  @override
  void v(message, [error, StackTrace? stackTrace]) {
    if (logEnabled) {
      _logger.v(message, error, stackTrace);
    }
  }

  @override
  void w(message, [error, StackTrace? stackTrace]) {
    if (logEnabled) {
      _logger.w(message, error, stackTrace);
    }
  }

  @override
  void wtf(message, [error, StackTrace? stackTrace]) {
    if (logEnabled) {
      _logger.wtf(message, error, stackTrace);
    }
  }

  @override
  bool logEnabled = false;
}
