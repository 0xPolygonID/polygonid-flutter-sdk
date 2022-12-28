import '../../../common/mappers/mapper.dart';
import '../../../identity/data/mappers/hash_mapper.dart';
import '../../domain/entities/proof_entity.dart';
import '../dtos/proof_dto.dart';

class ProofMapper extends Mapper<ProofDTO, ProofEntity> {
  final HashMapper _hashMapper;

  ProofMapper(this._hashMapper);

  @override
  ProofEntity mapFrom(ProofDTO from) {
    return ProofEntity(
      existence: from.existence,
      siblings: from.siblings.map((dto) => _hashMapper.mapFrom(dto)).toList(),
    );
  }

  @override
  ProofDTO mapTo(ProofEntity from) {
    return ProofDTO(
      existence: from.existence,
      siblings:
          from.siblings.map((entity) => _hashMapper.mapTo(entity)).toList(),
    );
  }
}
