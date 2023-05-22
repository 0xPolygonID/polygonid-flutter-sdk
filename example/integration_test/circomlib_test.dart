import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test circomlib functions', () {
    testWidgets('Can instantiate Pack Signature', (WidgetTester tester) async {
      final bjjLib = Platform.isAndroid
          ? DynamicLibrary.open("libbabyjubjub.so")
          : DynamicLibrary.process();
      final packSignature = bjjLib.lookupFunction<
          Pointer<Utf8> Function(Pointer<Utf8> packSignature),
          Pointer<Utf8> Function(
              Pointer<Utf8> packSignature)>('pack_signature');
      expect(packSignature, isA<Function>());
    });
  });
}
