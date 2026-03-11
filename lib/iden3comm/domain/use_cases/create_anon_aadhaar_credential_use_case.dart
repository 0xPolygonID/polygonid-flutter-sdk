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
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/self_issuance/self_issued_credential_params.dart';

class CreateAnonAadhaarCredentialParam {
  final String qrData;
  final int timeNow;
  final String profileDid;
  final SelfIssuedCredentialParams selfIssuedCredentialParams;
  Map<String, dynamic>? additionalFields;

  CreateAnonAadhaarCredentialParam({
    required this.qrData,
    required this.timeNow,
    required this.profileDid,
    required this.selfIssuedCredentialParams,
    required this.additionalFields,
  });
}

class CreateAnonAadhaarCredentialUseCase
    extends FutureUseCase<CreateAnonAadhaarCredentialParam, CredentialEntity> {
  final LibPolygonIdCoreCredentialDataSource _libPolygonIdCoreCredentialDS;
  final RemoteIden3commDataSource _remoteIden3commDataSource;
  final GetEnvUseCase _getEnvUseCase;
  final CredentialMapper _claimMapper;

  CreateAnonAadhaarCredentialUseCase(
    this._libPolygonIdCoreCredentialDS,
    this._remoteIden3commDataSource,
    this._getEnvUseCase,
    this._claimMapper,
  );

  @override
  Future<CredentialEntity> execute({
    required CreateAnonAadhaarCredentialParam param,
  }) async {
    final env = await _getEnvUseCase.execute();

    final credentialJson =
        _libPolygonIdCoreCredentialDS.createW3CCredentialFromAnonAadhaar(
      qrData: param.qrData,
      timeNow: param.timeNow,
      did: param.profileDid,
      selfIssuedCredentialParams: param.selfIssuedCredentialParams,
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
        "from": param.selfIssuedCredentialParams.issuerDid,
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
