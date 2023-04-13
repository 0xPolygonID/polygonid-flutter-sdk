import 'dart:convert';

import 'package:polygonid_flutter_sdk/sdk/polygon_id_channel.dart';

const String notificationKey = 'polygonIdNotification';

class ChannelPushNotificationDataSource {
  final PolygonIdChannel _channel;

  Stream<String> get notifications =>
      _channel.notifications.map<String>((event) {
        Map<String, dynamic> json = jsonDecode(event);

        return json.containsKey(notificationKey) ? json[notificationKey] : null;
      }).where((event) => event != null);

  ChannelPushNotificationDataSource(this._channel);
}
