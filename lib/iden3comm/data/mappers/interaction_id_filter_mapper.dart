import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:sembast/sembast.dart';

class InteractionIdFilterMapper extends ToMapper<Filter, String> {
  @override
  Filter mapTo(String to) {
    return Filter.equals('id', to);
  }
}
