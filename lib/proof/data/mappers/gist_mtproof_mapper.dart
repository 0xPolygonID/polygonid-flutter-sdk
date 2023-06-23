import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hash_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/gist_mtproof_dto.dart';
import 'package:polygonid_flutter_sdk/proof/data/mappers/mtproof_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_mtproof_entity.dart';

class GistMTProofMapper extends Mapper<GistMTProofDTO, GistMTProofEntity> {
  final MTProofMapper _proofMapper;

  GistMTProofMapper(this._proofMapper);

  @override
  GistMTProofEntity mapFrom(GistMTProofDTO from) {
    return GistMTProofEntity(
      root: from.root,
      proof: _proofMapper.mapFrom(from.proof),
    );
  }

  @override
  GistMTProofDTO mapTo(GistMTProofEntity to) {
    return GistMTProofDTO(
      root: to.root,
      proof: _proofMapper.mapTo(to.proof),
    );
  }
}
