import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:sembast/sembast.dart';

import '../../../domain/entities/filter_entity.dart';

class FilterMapper extends ToMapper<Filter, FilterEntity> {
  @override
  Filter mapTo(FilterEntity to) {
    switch (to.operator) {
      case FilterOperator.equal:
        return Filter.equals(to.name, to.value);
      case FilterOperator.equalsAnyInList:
        return Filter.equals(to.name, to.value, anyInList: true);
      case FilterOperator.greater:
        return Filter.greaterThan(to.name, to.value);
      case FilterOperator.lesser:
        return Filter.lessThan(to.name, to.value);
      case FilterOperator.greaterEqual:
        return Filter.greaterThanOrEquals(to.name, to.value);
      case FilterOperator.lesserEqual:
        return Filter.lessThanOrEquals(to.name, to.value);
      case FilterOperator.inList:
        try {
          List<dynamic> dynamicList = to.value as List<dynamic>;
          List<Object> objectList = dynamicList.map((item) => item as Object)
              .toList();
          Filter filter = Filter.inList(to.name, objectList);
          return filter;
        } catch (e) {
          return Filter.inList(to.name, to.value as List<Object>);
        }
      case FilterOperator.or:
        return Filter.or((to.value as List<FilterEntity>)
            .map((filter) => mapTo(filter))
            .toList());
      case FilterOperator.nonEqual:
        return Filter.notEquals(to.name, to.value);
    }
  }
}
