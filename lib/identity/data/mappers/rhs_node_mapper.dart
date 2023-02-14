import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';

import '../../domain/entities/rhs_node_entity.dart';
import '../dtos/node_dto.dart';
import '../dtos/rhs_node_dto.dart';
import 'rhs_node_type_mapper.dart';

class RhsNodeMapper extends Mapper<RhsNodeDTO, RhsNodeEntity> {
  final RhsNodeTypeMapper _rhsNodeTypeMapper;

  RhsNodeMapper(this._rhsNodeTypeMapper);

  @override
  RhsNodeEntity mapFrom(RhsNodeDTO from) {
    return RhsNodeEntity(
        node: from.node.toJson(),
        status: from.status,
        nodeType: _rhsNodeTypeMapper.mapFrom(from.node));
  }

  @override
  RhsNodeDTO mapTo(RhsNodeEntity to) {
    NodeDTO node = NodeDTO.fromJson(to.node);
    return RhsNodeDTO(
      node: node,
      status: to.status,
    );
  }
}
