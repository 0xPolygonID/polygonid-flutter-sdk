import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_stype.dart';

class TreeTypeMapper extends ToMapper<String, TreeType> {
  @override
  String mapTo(TreeType to) {
    switch (to) {
      case TreeType.claims:
        return claimsTreeStoreName;
      case TreeType.revocation:
        return revocationTreeStoreName;
      case TreeType.roots:
        return rootsTreeStoreName;
    }
  }
}
