import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:privadoid_sdk/privadoid_sdk.dart';

void main() {
  const MethodChannel channel = MethodChannel('privadoid_sdk');

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
    expect(await PrivadoIdSdk.platformVersion, '42');
  });

  test('generateNewClaim', () async {
    expect(await PrivadoIdSdk.newClaim("", ""), 'OK');
  });
}
