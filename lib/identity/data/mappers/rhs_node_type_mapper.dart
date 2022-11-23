import 'package:polygonid_flutter_sdk/identity/domain/entities/rhs_node_entity.dart';

import '../../../common/mappers/from_mapper.dart';
import '../dtos/node_dto.dart';

class RhsNodeTypeMapper extends FromMapper<NodeDTO, RhsNodeType> {
  @override
  RhsNodeType mapFrom(NodeDTO from) {
    if (from.children.length == 3) {
      if (from.children[2].data ==
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
