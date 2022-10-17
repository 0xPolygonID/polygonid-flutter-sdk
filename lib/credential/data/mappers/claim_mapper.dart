import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';

import '../../domain/entities/claim_entity.dart';
import '../dtos/claim_dto.dart';
import 'claim_info_mapper.dart';
import 'claim_state_mapper.dart';

class ClaimMapper extends Mapper<ClaimDTO, ClaimEntity> {
  final ClaimStateMapper _claimStateMapper;
  final ClaimInfoMapper _claimInfoMapper;

  ClaimMapper(this._claimStateMapper, this._claimInfoMapper);

  @override
  ClaimEntity mapFrom(ClaimDTO from) {
    return ClaimEntity(
        id: from.id,
        issuer: from.issuer,
        identifier: from.identifier,
        state: _claimStateMapper.mapFrom(from.state),
        expiration: from.expiration,
        schema: from.schema,
        vocab: from.vocab,
        type: from.type,
        info: _claimInfoMapper.mapFrom(from.info));
  }

  @override
  ClaimDTO mapTo(ClaimEntity to) {
    return ClaimDTO(
        id: to.id,
        issuer: to.issuer,
        identifier: to.identifier,
        state: _claimStateMapper.mapTo(to.state),
        type: to.type,
        expiration: to.expiration,
        schema: to.schema,
        vocab: to.vocab,
        info: _claimInfoMapper.mapTo(to.info));
  }
}
