import 'dart:async';

import 'package:flutter/services.dart';

class PolygonIdChannel {
  //final MethodChannel _channel;

  /// Notifications
  /*final StreamController<String> _notificationsController =
      StreamController.broadcast();

  Stream<String> get notifications => _notificationsController.stream;

  PolygonIdChannel(this._channel) {
    _channel.setMethodCallHandler((call) {
      switch (call.method) {
        /// Notifications
        case 'onPushNotificationReceived':
          return Future(() => _notificationsController.add(call.arguments));

        default:
          throw PlatformException(
              code: 'not_implemented',
              message: 'Method ${call.method} not implemented');
      }
    });
  }*/
}
