import 'package:flutter_test/flutter_test.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/filter_mapper.dart';
import 'package:sembast/sembast.dart';

// Data
const names = ["name", "name1", "name2", "name3", "name4", "name5"];
const values = [
  "value",
  "value1",
  "value2",
  "value3",
  "value4",
  ["value5", "value6", "value7"]
];
final filterEntities = [
  FilterEntity(
      operator: FilterOperator.equal, name: names[0], value: values[0]),
  FilterEntity(
      operator: FilterOperator.greater, name: names[1], value: values[1]),
  FilterEntity(
      operator: FilterOperator.lesser, name: names[2], value: values[2]),
  FilterEntity(
      operator: FilterOperator.greaterEqual, name: names[3], value: values[3]),
  FilterEntity(
      operator: FilterOperator.lesserEqual, name: names[4], value: values[4]),
  FilterEntity(
      operator: FilterOperator.inList, name: names[5], value: values[5]),
];
final filters = [
  Filter.equals(names[0], values[0]),
  Filter.greaterThan(names[1], values[1]),
  Filter.lessThan(names[2], values[2]),
  Filter.greaterThanOrEquals(names[3], values[3]),
  Filter.lessThanOrEquals(names[4], values[4]),
  Filter.inList(names[5], values[5] as List<Object>),
];

// Tested instance
FilterMapper mapper = FilterMapper();

void main() {
  group("Map to", () {
    test(
        "Given a FilterEntity, when I call mapTo, then I expect a Filter to be returned",
        () {
      // When
      for (int i = 0; i < names.length; i++) {
        expect(
            mapper.mapTo(filterEntities[i]).toString(), filters[i].toString());
      }
    });
  });
}
