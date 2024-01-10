import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';

class CircuitTypeMapper extends ToMapper<CircuitType, String> {
  @override
  CircuitType mapTo(String to) {
    for (var e in CircuitType.values) {
      if (e.name == to) {
        return e;
      }
    }
    return CircuitType.unknown;
  }
}
