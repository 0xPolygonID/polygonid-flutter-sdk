import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hash_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/mappers/node_aux_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/proof_dto.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/proof_entity.dart';

class ProofMapper extends Mapper<ProofDTO, ProofEntity> {
  final HashMapper _hashMapper;
  final NodeAuxMapper _nodeAuxMapper;

  ProofMapper(this._hashMapper, this._nodeAuxMapper);

  @override
  ProofEntity mapFrom(ProofDTO from) {
    return ProofEntity(
        existence: from.existence,
        siblings: from.siblings.map((dto) => _hashMapper.mapFrom(dto)).toList(),
        node_aux: from.nodeAux != null
            ? _nodeAuxMapper.mapFrom(from.nodeAux!)
            : null);
  }

  @override
  ProofDTO mapTo(ProofEntity from) {
    return ProofDTO(
      existence: from.existence,
      siblings:
          from.siblings.map((entity) => _hashMapper.mapTo(entity)).toList(),
      nodeAux:
          from.node_aux != null ? _nodeAuxMapper.mapTo(from.node_aux!) : null,
    );
  }
}
