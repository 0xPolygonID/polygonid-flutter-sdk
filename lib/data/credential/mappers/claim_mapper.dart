import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/data/credential/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/data/credential/dtos/credential_dto.dart';
import 'package:polygonid_flutter_sdk/domain/credential/entities/claim_entity.dart';

import 'claim_state_mapper.dart';

class ClaimMapper extends Mapper<ClaimDTO, ClaimEntity> {
  final ClaimStateMapper _claimStateMapper;

  ClaimMapper(this._claimStateMapper);

  @override
  ClaimEntity mapFrom(ClaimDTO from) {
    return ClaimEntity(
        id: from.id,
        issuer: from.issuer,
        identifier: from.identifier,
        state: _claimStateMapper.mapFrom(from.state),
        expiration: from.expiration,
        type: from.type,
        data: from.credential.toJson());
  }

  @override
  ClaimDTO mapTo(ClaimEntity to) {
    CredentialDTO credential = CredentialDTO.fromJson(to.data);

    return ClaimDTO(
        id: to.id,
        issuer: to.issuer,
        identifier: to.identifier,
        state: _claimStateMapper.mapTo(to.state),
        type: to.type,
        expiration: to.expiration,
        credential: credential);
  }
}
