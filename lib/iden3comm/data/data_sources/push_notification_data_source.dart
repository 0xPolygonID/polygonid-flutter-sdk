import 'dart:convert';

import 'package:polygonid_flutter_sdk/sdk/polygon_id_channel.dart';

const String notificationKey = 'polygonIdNotification';

class ChannelPushNotificationDataSource {
  //final PolygonIdChannel _channel;

  /*Stream<Map<String, dynamic>> get notifications =>
      _channel.notifications.map<Map<String, dynamic>?>((event) {
        Map<String, dynamic> json = jsonDecode(event);

        return json.containsKey(notificationKey)
            ? json[notificationKey] as Map<String, dynamic>
            : null;
      }).where((event) => event != null) as Stream<Map<String, dynamic>>;*/

  //ChannelPushNotificationDataSource(this._channel);
}
