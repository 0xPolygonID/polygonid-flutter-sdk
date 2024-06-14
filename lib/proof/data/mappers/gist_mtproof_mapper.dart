import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/gist_mtproof_dto.dart';

class GistMTProofMapper
    extends ToMapper<Map<String, dynamic>, GistMTProofEntity> {
  GistMTProofMapper();

  GistMTProofEntity mapFrom(GistMTProofEntity from) {
    return GistMTProofEntity(
      root: from.root,
      proof: from.proof,
    );
  }

  @override
  Map<String, dynamic> mapTo(GistMTProofEntity to) {
    Map<String, dynamic> result = {
      "root": to.root,
      "proof": {
        "existence": to.proof.existence,
        "siblings": to.proof.siblings,
      }
    };

    if (to.proof.nodeAux != null) {
      result["proof"]["node_aux"] = {
        "key": to.proof.nodeAux!.key,
        "value": to.proof.nodeAux!.value
      };
    }
    return result;
  }
}
