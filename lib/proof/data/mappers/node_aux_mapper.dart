import '../../../common/mappers/mapper.dart';
import '../../domain/entities/node_aux_entity.dart';
import '../dtos/node_aux_dto.dart';

class NodeAuxMapper extends Mapper<NodeAuxDTO, NodeAuxEntity> {
  @override
  NodeAuxEntity mapFrom(NodeAuxDTO from) {
    return NodeAuxEntity(
      key: from.key,
      value: from.value,
    );
  }

  @override
  NodeAuxDTO mapTo(NodeAuxEntity from) {
    return NodeAuxDTO(
      key: from.key,
      value: from.value,
    );
  }
}
