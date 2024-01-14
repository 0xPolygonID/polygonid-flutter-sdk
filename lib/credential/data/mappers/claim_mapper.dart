import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/display_type_mapper.dart';

import '../../domain/entities/claim_entity.dart';
import '../dtos/claim_dto.dart';
import 'claim_info_mapper.dart';
import 'claim_state_mapper.dart';

class ClaimMapper extends Mapper<ClaimDTO, ClaimEntity> {
  final ClaimStateMapper _claimStateMapper;
  final ClaimInfoMapper _claimInfoMapper;
  final DisplayTypeMapper _displayTypeMapper;

  ClaimMapper(
    this._claimStateMapper,
    this._claimInfoMapper,
    this._displayTypeMapper,
  );

  @override
  ClaimEntity mapFrom(ClaimDTO from) {
    final displayType = from.displayType;
    return ClaimEntity(
      id: from.id,
      issuer: from.issuer,
      did: from.did,
      state: _claimStateMapper.mapFrom(from.state),
      expiration: from.expiration,
      schema: from.schema,
      type: from.type,
      info: _claimInfoMapper.mapFrom(from.info),
      displayType: from.displayType == null
          ? _displayTypeMapper.mapFrom(displayType)
          : null,
    );
  }

  @override
  ClaimDTO mapTo(ClaimEntity to) {
    final displayType = to.displayType;
    return ClaimDTO(
      id: to.id,
      issuer: to.issuer,
      did: to.did,
      state: _claimStateMapper.mapTo(to.state),
      type: to.type,
      expiration: to.expiration,
      schema: to.schema,
      info: _claimInfoMapper.mapTo(to.info),
      displayType:
          to.displayType == null ? null : _displayTypeMapper.mapTo(displayType),
    );
  }
}
