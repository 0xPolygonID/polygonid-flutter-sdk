import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/mtproof_dto.dart';

class AuthProofMapper extends ToMapper<Map<String, dynamic>, MTProofEntity> {
  AuthProofMapper();

  @override
  Map<String, dynamic> mapTo(MTProofEntity to) {
    Map<String, dynamic> result = {
      "existence": to.existence,
      "siblings": to.siblings.map((hash) => hash.toString()).toList()
    };

    if (to.nodeAux != null) {
      result["node_aux"] = {"key": to.nodeAux!.key, "value": to.nodeAux!.value};
    }

    return result;
  }
}
