import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/node_aux_dto.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/node_aux_entity.dart';

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
