import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';

import '../../domain/entities/node_entity.dart';
import '../dtos/node_dto.dart';
import 'node_hash_mapper.dart';
import 'node_type_dto_mapper.dart';
import 'node_type_entity_mapper.dart';
import 'node_type_mapper.dart';

class NodeMapper extends Mapper<NodeDTO, NodeEntity> {
  final NodeTypeMapper _nodeTypeMapper;
  final NodeTypeEntityMapper _nodeTypeEntityMapper;
  final NodeTypeDTOMapper _nodeTypeDTOMapper;
  final NodeHashMapper _hashMapper;

  NodeMapper(this._nodeTypeMapper, this._nodeTypeEntityMapper,
      this._nodeTypeDTOMapper, this._hashMapper);

  @override
  NodeEntity mapFrom(NodeDTO from) {
    return NodeEntity(
        hash: _hashMapper.mapFrom(from.hash),
        children: from.children.map((dto) => _hashMapper.mapFrom(dto)).toList(),
        nodeType: _nodeTypeMapper
            .mapFrom(/*_nodeTypeDTOMapper.mapFrom(*/ from.type /*)*/));
  }

  @override
  NodeDTO mapTo(NodeEntity to) {
    return NodeDTO(
        hash: _hashMapper.mapTo(to.hash),
        children:
            to.children.map((entity) => _hashMapper.mapTo(entity)).toList(),
        type: _nodeTypeMapper
            .mapTo(/*_nodeTypeEntityMapper.mapFrom(*/ to.nodeType /*)*/));
  }
}
