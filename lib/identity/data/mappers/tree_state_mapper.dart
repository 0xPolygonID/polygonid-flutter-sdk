import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_state_entity.dart';

class TreeStateMapper extends ToMapper<Map<String, dynamic>, TreeStateEntity> {
  @override
  Map<String, dynamic> mapTo(TreeStateEntity to) {
    return {
      "state": to.hash,
      "claimsRoot": to.claimsTree.string(),
      "revocationRoot": to.revocationTree.string(),
      "rootOfRoots": to.rootsTree.string(),
    };
  }
}
