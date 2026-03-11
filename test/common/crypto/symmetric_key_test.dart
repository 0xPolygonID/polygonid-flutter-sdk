import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/common/crypto/symmetric.dart';

void main() {
  group('SymmetricKey equality and hashCode', () {
    test('keys with same bytes are equal and have same hashCode', () {
      final key1 = SymmetricKey(Uint8List.fromList([1, 2, 3, 4]));
      final key2 = SymmetricKey(Uint8List.fromList([1, 2, 3, 4]));
      expect(key1, equals(key2));
      expect(key1.hashCode, equals(key2.hashCode));
    });

    test('keys with different length are not equal', () {
      final key1 = SymmetricKey(Uint8List.fromList([1, 2, 3]));
      final key2 = SymmetricKey(Uint8List.fromList([1, 2, 3, 4]));
      expect(key1 == key2, isFalse);
    });

    test('keys with same length but different contents are not equal', () {
      final key1 = SymmetricKey(Uint8List.fromList([1, 2, 3, 4]));
      final key2 = SymmetricKey(Uint8List.fromList([1, 2, 3, 5]));
      expect(key1 == key2, isFalse);
    });

    test('fromUtf8 produces expected bytes and equality works', () {
      final key1 = SymmetricKey.fromUtf8('abcd');
      final key2 = SymmetricKey(Uint8List.fromList([97, 98, 99, 100])); // a,b,c,d
      expect(key1, equals(key2));
    });

    test('fromBase16 supports optional 0x prefix', () {
      final key1 = SymmetricKey.fromBase16('0x01020304');
      final key2 = SymmetricKey.fromBase16('01020304');
      expect(key1, equals(key2));
    });

    test('hashCode changes with content change (basic check)', () {
      final key1 = SymmetricKey(Uint8List.fromList([1, 2, 3, 4]));
      final key2 = SymmetricKey(Uint8List.fromList([4, 3, 2, 1]));
      expect(key1.hashCode == key2.hashCode && key1 != key2, isFalse, reason: 'Acceptable if collision occurs but unlikely.');
      // More direct expectation: typically these differ.
      if (key1.hashCode == key2.hashCode) {
        fail('Unexpected hash collision for distinct byte sequences');
      }
    });
  });
}

