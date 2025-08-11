import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/display_type_mapper.dart';

import '../../domain/entities/claim_entity.dart';
import '../dtos/claim_dto.dart';
import 'claim_info_mapper.dart';
import 'claim_state_mapper.dart';

typedef ClaimMapper = CredentialMapper;

class CredentialMapper extends Mapper<CredentialDTO, CredentialEntity> {
  final CredentialStateMapper _credentialStateMapper;
  final CredentialInfoMapper _credentialInfoMapper;
  final DisplayTypeMapper _displayTypeMapper;

  CredentialMapper(
    this._credentialStateMapper,
    this._credentialInfoMapper,
    this._displayTypeMapper,
  );

  @override
  CredentialEntity mapFrom(CredentialDTO from) {
    final displayType = from.displayType;
    return CredentialEntity(
      id: from.id,
      issuer: from.issuer,
      did: from.did,
      state: _credentialStateMapper.mapFrom(from.state),
      expiration: from.expiration,
      issuanceDate: from.issuanceDate,
      schema: from.schema,
      type: from.type,
      info: _credentialInfoMapper.mapFrom(from.info),
      displayType:
          displayType != null ? _displayTypeMapper.mapFrom(displayType) : null,
      credentialRawValue: from.credentialRawValue,
    );
  }

  @override
  CredentialDTO mapTo(CredentialEntity to) {
    final displayType = to.displayType;
    return CredentialDTO(
      id: to.id,
      issuer: to.issuer,
      did: to.did,
      state: _credentialStateMapper.mapTo(to.state),
      type: to.type,
      expiration: to.expiration,
      schema: to.schema,
      info: _credentialInfoMapper.mapTo(to.info),
      displayType:
          displayType != null ? _displayTypeMapper.mapTo(displayType) : null,
      credentialRawValue: to.credentialRawValue,
    );
  }
}
