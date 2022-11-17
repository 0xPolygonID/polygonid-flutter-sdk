import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';

import '../../domain/entities/node_entity.dart';
import '../dtos/node_dto.dart';
import 'hash_mapper.dart';
import 'node_type_mapper.dart';

class NodeMapper extends Mapper<NodeDTO, NodeEntity> {
  final NodeTypeMapper _nodeTypeMapper;
  final HashMapper _hashMapper;

  NodeMapper(this._nodeTypeMapper, this._hashMapper);

  @override
  NodeEntity mapFrom(NodeDTO from) {
    from.children.map((dto) => _hashMapper.mapFrom(dto));
    return NodeEntity(
        children: from.children.map((dto) => _hashMapper.mapFrom(dto)).toList(),
        nodeType: _nodeTypeMapper.mapFrom(from));
  }

  @override
  NodeDTO mapTo(NodeEntity to) {
    return NodeDTO(
      children: to.children.map((entity) => _hashMapper.mapTo(entity)).toList(),
    );
  }
}
