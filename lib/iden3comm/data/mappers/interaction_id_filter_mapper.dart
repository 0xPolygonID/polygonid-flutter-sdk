import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:sembast/sembast.dart';

class InteractionIdFilterMapper extends ToMapper<Filter, int> {
  @override
  Filter mapTo(int to) {
    return Filter.equals('id', to);
  }
}
