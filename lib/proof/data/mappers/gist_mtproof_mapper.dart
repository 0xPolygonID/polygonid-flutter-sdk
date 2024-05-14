import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hash_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/gist_mtproof_dto.dart';
import 'package:polygonid_flutter_sdk/proof/data/mappers/mtproof_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_mtproof_entity.dart';

class GistMTProofMapper
    extends ToMapper<Map<String, dynamic>, GistMTProofEntity> {
  final MTProofMapper _proofMapper;
  final HashMapper _hashMapper;

  GistMTProofMapper(this._proofMapper, this._hashMapper);

  GistMTProofEntity mapFrom(GistMTProofDTO from) {
    return GistMTProofEntity(
      root: from.root,
      proof: _proofMapper.mapFrom(from.proof),
    );
  }

  @override
  Map<String, dynamic> mapTo(GistMTProofEntity to) {
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
