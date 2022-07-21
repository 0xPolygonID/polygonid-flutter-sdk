import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/data/identity/mappers/hex_mapper.dart';

// Data
final privateKey = Uint8List.fromList("thePrivateKey".codeUnits);
const convertedKey = "746865507269766174654b6579";

// Tested instance
HexMapper mapper = HexMapper();

void main() {
  group("Map from", () {
    test(
        "Given a Uint8List, when I call mapFrom, then I expect a String to be returned",
        () {
      // When
      expect(mapper.mapFrom(privateKey), convertedKey);
    });

    test(
        "Given a hex String, when I call mapTo, then I expect Uint8List to be returned",
        () {
      // When
      expect(mapper.mapTo(convertedKey), privateKey);
    });
  });
}
