import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/state_identifier_mapper.dart';

// Data
const id = "4f";
const result = "d4";

// Tested instance
StateIdentifierMapper mapper = StateIdentifierMapper();

void main() {
  test("Given an id, when I call mapTo, then I expect a string to be returned",
      () {
    // When
    expect(mapper.mapTo(id), result);
  });
}
