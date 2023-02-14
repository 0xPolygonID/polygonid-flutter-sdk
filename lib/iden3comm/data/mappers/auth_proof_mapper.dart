import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hash_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/mappers/node_aux_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/proof_entity.dart';

class AuthProofMapper extends ToMapper<Map<String, dynamic>, ProofEntity> {
  final HashMapper _hashMapper;
  final NodeAuxMapper _nodeAuxMapper;

  AuthProofMapper(this._hashMapper, this._nodeAuxMapper);

  @override
  Map<String, dynamic> mapTo(ProofEntity to) {
    Map<String, dynamic> result = {
      "existence": to.existence,
      "siblings": to.siblings
          .map((hashEntity) => _hashMapper.mapTo(hashEntity).toString())
          .toList()
    };

    if (to.nodeAux != null) {
      result["node_aux"] = {"key": to.nodeAux!.key, "value": to.nodeAux!.value};
    }

    return result;
  }
}
