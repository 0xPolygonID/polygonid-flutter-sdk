import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/rhs_node_type_mapper.dart';

import '../../domain/entities/rhs_node_entity.dart';
import '../dtos/rhs_node_dto.dart';

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
    RhsNodeItemDTO node = RhsNodeItemDTO.fromJson(to.node);
    return RhsNodeDTO(
      node: node,
      status: to.status,
    );
  }
}
