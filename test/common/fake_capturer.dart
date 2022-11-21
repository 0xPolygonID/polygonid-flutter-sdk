import 'package:flutter_test/flutter_test.dart';

/// Custom impl of a capture on fake
abstract class FakeCapturer extends Fake {
  Map<String, List<dynamic>> captures = {};

  int callCount(String name) => captures[name]?.length ?? 0;

  void resetCaptures() {
    captures.clear();
  }

  void capture(String name, {dynamic value}) {
    captures[name] ??= [];
    captures[name]!.add(value);
  }
}
