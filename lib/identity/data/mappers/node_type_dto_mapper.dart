import '../../../common/mappers/from_mapper.dart';
import '../dtos/node_dto.dart';

class NodeTypeDTOMapper extends FromMapper<NodeDTO, NodeTypeDTO> {
  @override
  NodeTypeDTO mapFrom(NodeDTO from) {
    if (from.children.length == 3) {
      if (from.children[2].toJson()['data'] ==
          "0100000000000000000000000000000000000000000000000000000000000000") {
        return NodeTypeDTO.leaf;
      } else {
        return NodeTypeDTO.state;
      }
    } else if (from.children.length == 2) {
      return NodeTypeDTO.middle;
    } else {
      return NodeTypeDTO.unknown;
    }
  }
}
