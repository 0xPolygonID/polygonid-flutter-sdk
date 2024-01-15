import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
}



/// Initialize the Flutter SDK wrapper
/// This method is called from the native side
@pragma('vm:entry-point')
Future<void> init(List? env) {
  WidgetsFlutterBinding.ensureInitialized();

  return PolygonIdSdk.init(
      env: env != null && env.isNotEmpty
          ? EnvEntity.fromJson(jsonDecode(env[0]))
          : null);
}
