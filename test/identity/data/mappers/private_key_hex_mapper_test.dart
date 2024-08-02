import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/private_key/private_key_hex_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/private_key/private_key_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';

// Data
const string =
    "2e3ae520f2b58ab897ee9e10ee7c9db02e3ae520f2b58ab897ee9e10ee7c9db0";
final bytes = Uint8List.fromList([
  46,
  58,
  229,
  32,
  242,
  181,
  138,
  184,
  151,
  238,
  158,
  16,
  238,
  124,
  157,
  176,
  46,
  58,
  229,
  32,
  242,
  181,
  138,
  184,
  151,
  238,
  158,
  16,
  238,
  124,
  157,
  176
]);

const privateKey = string;
final convertedKey = bytes;
const longPrivateKey = privateKey + privateKey;

// Tested instance
PrivateKeyMapper mapper = PrivateKeyHexMapper();

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
