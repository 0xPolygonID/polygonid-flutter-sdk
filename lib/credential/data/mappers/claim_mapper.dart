import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';

import '../../domain/entities/claim_entity.dart';
import '../dtos/claim_dto.dart';
import '../dtos/credential_dto.dart';
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
        schema: from.schema,
        vocab: from.vocab,
        type: from.type,
        credential: from.credential.toJson());
  }

  @override
  ClaimDTO mapTo(ClaimEntity to) {
    CredentialDTO credential = CredentialDTO.fromJson(to.credential);

    return ClaimDTO(
        id: to.id,
        issuer: to.issuer,
        identifier: to.identifier,
        state: _claimStateMapper.mapTo(to.state),
        type: to.type,
        expiration: to.expiration,
        schema: to.schema,
        vocab: to.vocab,
        credential: credential);
  }
}
