import 'package:polygonid_flutter_sdk/credential/domain/entities/rhs_node_entity.dart';

import '../../../common/mappers/from_mapper.dart';
import '../dtos/rhs_node_dto.dart';

class RhsNodeTypeMapper extends FromMapper<RhsNodeItemDTO, RhsNodeType> {
  @override
  RhsNodeType mapFrom(RhsNodeItemDTO from) {
    if (from.children.length == 3) {
      if (from.children[2] ==
          "0100000000000000000000000000000000000000000000000000000000000000") {
        return RhsNodeType.leaf;
      } else {
        return RhsNodeType.state;
      }
    } else if (from.children.length == 2) {
      return RhsNodeType.middle;
    } else {
      return RhsNodeType.unknown;
    }
  }
}
