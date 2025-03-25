import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/lib_pidcore_credential_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_info_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/remote_iden3comm_data_source.dart';

class CreatePassportCredentialParam {
  final String passportData;
  final String profileDid;
  final int revocationNonce;
  final String credentialStatusID;
  final String issuerDid;
  final String issuanceDate;
  final String linkNonce;
  Map<String, dynamic>? additionalFields;

  CreatePassportCredentialParam({
    required this.passportData,
    required this.profileDid,
    required this.revocationNonce,
    required this.credentialStatusID,
    required this.issuerDid,
    required this.issuanceDate,
    required this.linkNonce,
    required this.additionalFields,
  });
}

class CreatePassportCredentialUseCase
    extends FutureUseCase<CreatePassportCredentialParam, ClaimEntity> {
  final LibPolygonIdCoreCredentialDataSource _libPolygonIdCoreCredentialDS;
  final RemoteIden3commDataSource _remoteIden3commDataSource;
  final GetEnvUseCase _getEnvUseCase;
  final ClaimMapper _claimMapper;

  CreatePassportCredentialUseCase(
    this._libPolygonIdCoreCredentialDS,
    this._remoteIden3commDataSource,
    this._getEnvUseCase,
    this._claimMapper,
  );

  @override
  Future<ClaimEntity> execute({
    required CreatePassportCredentialParam param,
  }) async {
    final env = await _getEnvUseCase.execute();

    final credentialJson = _libPolygonIdCoreCredentialDS.credentialFromPassport(
      passportData: param.passportData,
      did: param.profileDid,
      revocationNonce: param.revocationNonce,
      credentialStatusID: param.credentialStatusID,
      issuerDid: param.issuerDid,
      issuanceDate: param.issuanceDate,
      linkNonce: param.linkNonce,
      config: jsonEncode(env.config.toJson()),
    );

    Map<String, dynamic> credentialJsonMap = jsonDecode(credentialJson);
    if (param.additionalFields != null) {
      credentialJsonMap.addAll(param.additionalFields!);
    }

    final credentialWithAdditionalFields = jsonEncode(credentialJsonMap);

    final claimJson = jsonDecode(credentialWithAdditionalFields);
    final claimInfoDto = ClaimInfoDTO.fromJson(claimJson);

    final claimDto = ClaimDTO(
      id: claimInfoDto.id,
      issuer: claimInfoDto.issuer,
      did: param.profileDid,
      type: claimInfoDto.credentialSubject.type,
      info: claimInfoDto,
      credentialRawValue: jsonEncode({
        "from": param.issuerDid,
        "body": claimJson,
        // TODO Maybe use some other type
        "type": "https://iden3-communication.io/credentials/1.0/offer",
      }),
    );

    final displayMethod = claimInfoDto.displayMethod;
    await Future.wait([
      _remoteIden3commDataSource
          .fetchSchema(url: claimInfoDto.credentialSchema.id)
          .then((schema) {
        claimDto.schema = schema;
        return claimDto;
      }).catchError((_) => claimDto),
      if (displayMethod != null)
        _remoteIden3commDataSource
            .fetchDisplayType(url: displayMethod.id)
            .then((displayType) {
          displayType['type'] = displayMethod.type;
          claimDto.displayType = displayType;
          return claimDto;
        }).catchError((_) {
          return claimDto;
        }),
    ]);

    return _claimMapper.mapFrom(claimDto);
  }
}
