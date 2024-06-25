import 'package:flutter/foundation.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';

extension FutureExtension<T> on Future<T> {
  Future<T> printAwaitTime(String? title) async {
    final stopwatch = Stopwatch()..start();
    final result = await this;
    stopwatch.stop();

    title ??= 'Await time';

    final time = stopwatch.elapsedMilliseconds;
    final message = '$title : ${time}ms to complete';

    if (kDebugMode) {
      logger().i('$message: ${stopwatch.elapsedMilliseconds}ms');
    }
    return result;
  }
}
