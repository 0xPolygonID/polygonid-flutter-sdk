import '../../../common/mappers/from_mapper.dart';
import '../../domain/entities/node_entity.dart';
import '../dtos/node_dto.dart';

class NodeTypeMapper extends FromMapper<NodeDTO, NodeType> {
  @override
  NodeType mapFrom(NodeDTO from) {
    if (from.children.length == 3) {
      if (from.children[2].data ==
          "0100000000000000000000000000000000000000000000000000000000000000") {
        return NodeType.leaf;
      } else {
        return NodeType.state;
      }
    } else if (from.children.length == 2) {
      return NodeType.middle;
    } else {
      return NodeType.unknown;
    }
  }
}
