import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/id_filter_mapper.dart';
import 'package:sembast/sembast.dart';

// Data
const id = "theId";
final filter = Filter.equals('id', id);

// Tested instance
IdFilterMapper mapper = IdFilterMapper();

void main() {
  group("Map to", () {
    test(
        "Given an id, when I call mapTo, then I expect a Filter to be returned",
        () {
      // When
      expect(mapper.mapTo(id).toString(), filter.toString());
    });
  });
}
