// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_proof_sm_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimProofSMDTO _$ClaimProofSMDTOFromJson(Map<String, dynamic> json) =>
    ClaimProofSMDTO(
      json['type'] as String,
      ClaimProofIssuerSMDTO.fromJson(
          json['issuerData'] as Map<String, dynamic>),
      json['coreClaim'] as String,
      ClaimProofMTPDTO.fromJson(json['mtp'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClaimProofSMDTOToJson(ClaimProofSMDTO instance) =>
    <String, dynamic>{
      'type': instance.type,
      'issuerData': instance.issuer.toJson(),
      'coreClaim': instance.coreClaim,
      'mtp': instance.mtp.toJson(),
    };

ClaimProofIssuerSMDTO _$ClaimProofIssuerSMDTOFromJson(
        Map<String, dynamic> json) =>
    ClaimProofIssuerSMDTO(
      json['id'] as String,
      ClaimProofIssuerStateSMDTO.fromJson(
          json['state'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClaimProofIssuerSMDTOToJson(
        ClaimProofIssuerSMDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state.toJson(),
    };

ClaimProofIssuerStateSMDTO _$ClaimProofIssuerStateSMDTOFromJson(
        Map<String, dynamic> json) =>
    ClaimProofIssuerStateSMDTO(
      json['claimsTreeRoot'] as String,
      json['value'] as String,
      json['blockNumber'] as int,
      json['blockTimestamp'] as int,
      json['revocationTreeRoot'] as String,
      json['rootOfRoots'] as String,
      json['txId'] as String,
    );

Map<String, dynamic> _$ClaimProofIssuerStateSMDTOToJson(
        ClaimProofIssuerStateSMDTO instance) =>
    <String, dynamic>{
      'claimsTreeRoot': instance.treeRoot,
      'value': instance.value,
      'blockNumber': instance.number,
      'blockTimestamp': instance.timestamp,
      'revocationTreeRoot': instance.revocationTree,
      'rootOfRoots': instance.root,
      'txId': instance.tx,
    };
