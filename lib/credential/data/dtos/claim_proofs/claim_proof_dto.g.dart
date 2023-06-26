// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_proof_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ClaimProofDTOToJson(ClaimProofDTO instance) =>
    <String, dynamic>{
      'stringify': instance.stringify,
      'hashCode': instance.hashCode,
      'type': instance.type,
      'issuerData': instance.issuer.toJson(),
      'coreClaim': instance.coreClaim,
      'props': instance.props,
    };

ClaimProofMTPDTO _$ClaimProofMTPDTOFromJson(Map<String, dynamic> json) =>
    ClaimProofMTPDTO(
      json['existence'] as bool,
      (json['siblings'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ClaimProofMTPDTOToJson(ClaimProofMTPDTO instance) =>
    <String, dynamic>{
      'existence': instance.existence,
      'siblings': instance.siblings,
    };

ClaimProofIssuerCredStatusDTO _$ClaimProofIssuerCredStatusDTOFromJson(
        Map<String, dynamic> json) =>
    ClaimProofIssuerCredStatusDTO(
      json['id'] as String,
      json['revocationNonce'] as int?,
      $enumDecode(_$ClaimProofIssuerCredStatusTypeEnumMap, json['type']),
      json['statusIssuer'] == null
          ? null
          : ClaimProofIssuerCredStatusDTO.fromJson(
              json['statusIssuer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClaimProofIssuerCredStatusDTOToJson(
        ClaimProofIssuerCredStatusDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'revocationNonce': instance.revocationNonce,
      'type': _$ClaimProofIssuerCredStatusTypeEnumMap[instance.type]!,
      'statusIssuer': instance.statusIssuer?.toJson(),
    };

const _$ClaimProofIssuerCredStatusTypeEnumMap = {
  ClaimProofIssuerCredStatusType.reverseSparseMerkleTreeProof:
      'Iden3ReverseSparseMerkleTreeProof',
  ClaimProofIssuerCredStatusType.sparseMerkleTreeProof: 'SparseMerkleTreeProof',
  ClaimProofIssuerCredStatusType.iden3OnchainSparseMerkleTreeProof2023:
      'Iden3OnchainSparseMerkleTreeProof2023',
};

ClaimProofIssuerStateDTO _$ClaimProofIssuerStateDTOFromJson(
        Map<String, dynamic> json) =>
    ClaimProofIssuerStateDTO(
      json['claimsTreeRoot'] as String,
      json['revocationTreeRoot'] as String?,
      json['rootOfRoots'] as String?,
      json['value'] as String,
    );

Map<String, dynamic> _$ClaimProofIssuerStateDTOToJson(
    ClaimProofIssuerStateDTO instance) {
  final val = <String, dynamic>{
    'claimsTreeRoot': instance.claimsTreeRoot,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('revocationTreeRoot', instance.revocationTreeRoot);
  writeNotNull('rootOfRoots', instance.rootOfRoots);
  val['value'] = instance.value;
  return val;
}

ClaimProofIssuerDTO _$ClaimProofIssuerDTOFromJson(Map<String, dynamic> json) =>
    ClaimProofIssuerDTO(
      json['id'] as String,
      ClaimProofIssuerStateDTO.fromJson(json['state'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClaimProofIssuerDTOToJson(
        ClaimProofIssuerDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state.toJson(),
    };
