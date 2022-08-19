import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/domain/common/entities/filter_entity.dart';
import 'package:sembast/sembast.dart';

class FilterMapper extends ToMapper<Filter, FilterEntity> {
  @override
  Filter mapTo(FilterEntity to) {
    switch (to.operator) {
      case FilterOperator.equal:
        return Filter.equals(to.name, to.value);
      case FilterOperator.greater:
        return Filter.greaterThan(to.name, to.value);
      case FilterOperator.lesser:
        return Filter.lessThan(to.name, to.value);
      case FilterOperator.greaterEqual:
        return Filter.greaterThanOrEquals(to.name, to.value);
      case FilterOperator.lesserEqual:
        return Filter.lessThanOrEquals(to.name, to.value);
      case FilterOperator.inList:
        return Filter.inList(to.name, to.value);
    }
  }
}
