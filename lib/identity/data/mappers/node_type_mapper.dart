import '../../../common/mappers/mapper.dart';
import '../../domain/entities/node_entity.dart';
import '../dtos/node_dto.dart';

class NodeTypeMapper extends Mapper<NodeTypeDTO, NodeType> {
  @override
  NodeType mapFrom(NodeTypeDTO from) {
    switch (from) {
      case NodeTypeDTO.state:
        return NodeType.state;
      case NodeTypeDTO.leaf:
        return NodeType.leaf;
      case NodeTypeDTO.middle:
        return NodeType.middle;
      case NodeTypeDTO.unknown:
      default:
        return NodeType.unknown;
    }
  }

  @override
  NodeTypeDTO mapTo(NodeType to) {
    switch (to) {
      case NodeType.state:
        return NodeTypeDTO.state;
      case NodeType.leaf:
        return NodeTypeDTO.leaf;
      case NodeType.middle:
        return NodeTypeDTO.middle;
      case NodeType.unknown:
      default:
        return NodeTypeDTO.unknown;
    }
  }
}
