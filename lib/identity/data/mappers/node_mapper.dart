import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';

import '../../domain/entities/node_entity.dart';
import '../dtos/node_dto.dart';
import 'node_type_dto_mapper.dart';
import 'node_type_entity_mapper.dart';
import 'node_type_mapper.dart';

class NodeMapper extends Mapper<NodeDTO, NodeEntity> {
  final NodeTypeMapper _nodeTypeMapper;
  final NodeTypeEntityMapper _nodeTypeEntityMapper;
  final NodeTypeDTOMapper _nodeTypeDTOMapper;

  NodeMapper(
    this._nodeTypeMapper,
    this._nodeTypeEntityMapper,
    this._nodeTypeDTOMapper,
  );

  @override
  NodeEntity mapFrom(NodeDTO from) {
    return NodeEntity(
      hash: from.hash,
      children: from.children,
      nodeType: _nodeTypeMapper.mapFrom(from.type),
    );
  }

  @override
  NodeDTO mapTo(NodeEntity to) {
    return NodeDTO(
      hash: to.hash,
      children: to.children,
      type: _nodeTypeMapper.mapTo(to.nodeType),
    );
  }
}
