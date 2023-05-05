import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/tree_state_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hash_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_state_entity.dart';

class TreeStateMapper extends Mapper<TreeStateDTO, TreeStateEntity> {
  @override
  TreeStateEntity mapFrom(TreeStateDTO from) {
    return TreeStateEntity(
      state: from.state,
      claimsTreeRoot: from.claimsTreeRoot,
      revocationTreeRoot: from.revocationTreeRoot,
      rootOfRoots: from.rootOfRoots,
    );
  }

  @override
  TreeStateDTO mapTo(TreeStateEntity to) {
    return TreeStateDTO(
      state: to.state,
      claimsTreeRoot: to.claimsTreeRoot,
      revocationTreeRoot: to.revocationTreeRoot,
      rootOfRoots: to.rootOfRoots,
    );
  }
}
