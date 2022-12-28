import 'package:polygonid_flutter_sdk/proof/data/mappers/proof_mapper.dart';

import '../../../common/mappers/mapper.dart';
import '../../domain/entities/gist_proof_entity.dart';
import '../dtos/gist_proof_dto.dart';

class GistProofMapper extends Mapper<GistProofDTO, GistProofEntity> {
  final ProofMapper _proofMapper;

  GistProofMapper(this._proofMapper);

  @override
  GistProofEntity mapFrom(GistProofDTO from) {
    return GistProofEntity(
      root: from.root,
      proof: _proofMapper.mapFrom(from.proof),
    );
  }

  @override
  GistProofDTO mapTo(GistProofEntity from) {
    return GistProofDTO(
      root: from.root,
      proof: _proofMapper.mapTo(from.proof),
    );
  }
}
