import '../../../common/mappers/from_mapper.dart';
import '../../domain/entities/proof_entity.dart';
import '../dtos/proof_dto.dart';

class ProofEntityMapper extends FromMapper<ProofEntity, ProofDTO> {
  @override
  ProofDTO mapFrom(ProofEntity from) {
    return ProofDTO(
      existence: from.existence,
      siblings: [],
    );
  }
}
