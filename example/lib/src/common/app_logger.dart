import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';

class AppLogger implements PolygonIdSdkLogger {
  final Logger _logger;

  AppLogger(this._logger);

  @override
  void d(message, [error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _logger.d(message, error: error, stackTrace: stackTrace);
    }
  }

  @override
  void e(message, [error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _logger.e(message, error: error, stackTrace: stackTrace);
    }
  }

  @override
  void i(message, [error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _logger.i(message, error: error, stackTrace: stackTrace);
    }
  }

  @override
  void v(message, [error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _logger.v(message, error: error, stackTrace: stackTrace);
    }
  }

  @override
  void w(message, [error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _logger.w(message, error: error, stackTrace: stackTrace);
    }
  }

  @override
  void wtf(message, [error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _logger.wtf(message, error: error, stackTrace: stackTrace);
    }
  }
}
