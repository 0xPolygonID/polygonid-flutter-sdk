// ignore_for_file: deprecated_member_use_from_same_package
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/private_key/private_key_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/private_key/private_key_symbols_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';

// Data
const privateKey = "thePrivateKey";
final convertedKey = Uint8List.fromList([
  116,
  104,
  101,
  80,
  114,
  105,
  118,
  97,
  116,
  101,
  75,
  101,
  121,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
]);
const longPrivateKey =
    "thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long, thePrivateKey which is very long";

// Tested instance
PrivateKeyMapper mapper = PrivateKeySymbolsMapper();

void main() {
  group("Map from", () {
    test(
        "Given a string, when I call map, then I expect a Uint8List to be returned",
        () {
      // When
      expect(mapper.mapFrom(privateKey), convertedKey);
    });

    test(
        "Given a string which is null, when I call map, then I expect a null to be returned",
        () {
      // When
      expect(mapper.mapFrom(null), null);
    });

    test(
        "Given a string which is too long, when I call map, then I expect a TooLongPrivateKeyException to be thrown",
        () {
      bool hasThrown = false;
      // When
      try {
        mapper.mapFrom(longPrivateKey);
      } catch (e) {
        // Then
        expect(e, isA<TooLongPrivateKeyException>());
        hasThrown = true;
      }

      expect(hasThrown, true);
    });
  });
}
