import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hash_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_proof_entity.dart';

class GistProofMapper extends ToMapper<Map<String, dynamic>, GistProofEntity> {
  final HashMapper _hashMapper;

  GistProofMapper(this._hashMapper);

  @override
  Map<String, dynamic> mapTo(GistProofEntity to) {
    Map<String, dynamic> result = {
      "root": to.root,
      "proof": {
        "existence": to.proof.existence,
        "siblings": to.proof.siblings
            .map((hashEntity) => _hashMapper.mapTo(hashEntity).toString())
            .toList()
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
