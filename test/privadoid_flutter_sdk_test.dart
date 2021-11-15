import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privadoid_flutter_sdk/privadoid_flutter_sdk.dart';

void main() {
  const MethodChannel channel = MethodChannel('privadoid_flutter_sdk');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await PrivadoidFlutterSdk.platformVersion, '42');
  });
}
