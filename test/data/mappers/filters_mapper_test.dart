import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:polygonid_flutter_sdk/data/credential/mappers/filter_mapper.dart';
import 'package:polygonid_flutter_sdk/data/credential/mappers/filters_mapper.dart';
import 'package:polygonid_flutter_sdk/domain/common/entities/FIlterEntity.dart';
import 'package:sembast/sembast.dart';

import 'filters_mapper_test.mocks.dart';

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
final filter = Filter.equals("", values[0]);

// Dependencies
MockFilterMapper filterMapper = MockFilterMapper();

// Tested instance
FiltersMapper mapper = FiltersMapper(filterMapper);

@GenerateMocks([FilterMapper])
void main() {
  group("Map to", () {
    test(
        "Given a FilterEntity, when I call mapTo, then I expect a Filter to be returned",
        () {
      // Given
      when(filterMapper.mapTo(any)).thenReturn(filter);

      // When
      expect(mapper.mapTo(filterEntities), isA<Filter>());

      var verifyFilter = verify(filterMapper.mapTo(captureAny));
      expect(verifyFilter.callCount, filterEntities.length);

      for (int i = 0; i < filterEntities.length; i++) {
        expect(verifyFilter.captured[i], filterEntities[i]);
      }
    });
  });
}
