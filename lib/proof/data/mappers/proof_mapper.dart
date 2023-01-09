import '../../../common/mappers/mapper.dart';
import '../../../identity/data/mappers/node_hash_mapper.dart';
import '../../domain/entities/proof_entity.dart';
import '../dtos/proof_dto.dart';
import 'node_aux_mapper.dart';

class ProofMapper extends Mapper<ProofDTO, ProofEntity> {
  final NodeHashMapper _hashMapper;
  final NodeAuxMapper _nodeAuxMapper;

  ProofMapper(this._hashMapper, this._nodeAuxMapper);

  @override
  ProofEntity mapFrom(ProofDTO from) {
    return ProofEntity(
        existence: from.existence,
        siblings: from.siblings.map((dto) => _hashMapper.mapFrom(dto)).toList(),
        nodeAux: from.nodeAux != null
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
          from.nodeAux != null ? _nodeAuxMapper.mapTo(from.nodeAux!) : null,
    );
  }
}
