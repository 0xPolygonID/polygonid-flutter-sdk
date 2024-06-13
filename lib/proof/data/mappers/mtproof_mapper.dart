import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hash_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/mtproof_dto.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/mtproof_entity.dart';

class MTProofMapper extends Mapper<MTProofDTO, MTProofEntity> {
  final HashMapper _hashMapper;

  MTProofMapper(this._hashMapper);

  @override
  MTProofEntity mapFrom(MTProofDTO from) {
    return MTProofEntity(
      existence: from.existence,
      siblings: from.siblings.map((dto) => _hashMapper.mapFrom(dto)).toList(),
      nodeAux: from.nodeAux,
    );
  }

  @override
  MTProofDTO mapTo(MTProofEntity from) {
    return MTProofDTO(
      existence: from.existence,
      siblings:
          from.siblings.map((entity) => _hashMapper.mapTo(entity)).toList(),
      nodeAux: from.nodeAux,
    );
  }
}
