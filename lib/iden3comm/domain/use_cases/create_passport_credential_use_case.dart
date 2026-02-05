import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/lib_pidcore_credential_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_info_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/remote_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/protocol_message_type.dart';

class CreatePassportCredentialParam {
  final String passportData;
  final String dg2Hash;
  final String profileDid;
  final int revocationNonce;
  final String credentialStatusID;
  final String issuerDid;
  final int issuanceDate;
  final String linkNonce;
  final String circuitId;
  Map<String, dynamic>? additionalFields;

  CreatePassportCredentialParam({
    required this.passportData,
    required this.dg2Hash,
    required this.profileDid,
    required this.revocationNonce,
    required this.credentialStatusID,
    required this.issuerDid,
    required this.issuanceDate,
    required this.linkNonce,
    required this.circuitId,
    required this.additionalFields,
  });
}

class CreatePassportCredentialUseCase
    extends FutureUseCase<CreatePassportCredentialParam, CredentialEntity> {
  final LibPolygonIdCoreCredentialDataSource _libPolygonIdCoreCredentialDS;
  final RemoteIden3commDataSource _remoteIden3commDataSource;
  final GetEnvUseCase _getEnvUseCase;
  final CredentialMapper _claimMapper;

  CreatePassportCredentialUseCase(
    this._libPolygonIdCoreCredentialDS,
    this._remoteIden3commDataSource,
    this._getEnvUseCase,
    this._claimMapper,
  );

  @override
  Future<CredentialEntity> execute({
    required CreatePassportCredentialParam param,
  }) async {
    final env = await _getEnvUseCase.execute();

    final credentialJson =
        _libPolygonIdCoreCredentialDS.createW3CCredentialFromPassport(
      passportData: param.passportData,
      dg2Hash: param.dg2Hash,
      did: param.profileDid,
      revocationNonce: param.revocationNonce,
      credentialStatusID: param.credentialStatusID,
      issuerDid: param.issuerDid,
      issuanceDate: param.issuanceDate,
      linkNonce: param.linkNonce,
      circuitId: param.circuitId,
      config: jsonEncode(env.config.toJson()),
    );

    Map<String, dynamic> credentialJsonMap = jsonDecode(credentialJson);
    if (param.additionalFields != null) {
      credentialJsonMap.addAll(param.additionalFields!);
    }

    final credentialWithAdditionalFields = jsonEncode(credentialJsonMap);

    final claimJson = jsonDecode(credentialWithAdditionalFields);
    final claimInfoDto = W3CCredential.fromJson(claimJson);

    final claimDto = CredentialDTO(
      id: claimInfoDto.id,
      issuer: claimInfoDto.issuer,
      did: param.profileDid,
      type: claimInfoDto.credentialSubject.type,
      info: claimInfoDto,
      credentialRawValue: jsonEncode({
        "type": ProtocolMessageType.credentialOfferMessageType,
        "from": param.issuerDid,
        "body": {
          'credential': claimJson,
        },
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
            .fetchDisplayType(displayMethod: displayMethod)
            .then((displayType) {
          claimDto.displayType = displayType;
          return claimDto;
        }).catchError((_) {
          return claimDto;
        }),
    ]);

    return _claimMapper.mapFrom(claimDto);
  }
}
