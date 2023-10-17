// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iden3comm_vp_proof_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Iden3commVPProofDTO _$Iden3commVPProofDTOFromJson(Map<String, dynamic> json) =>
    Iden3commVPProofDTO(
      context:
          (json['@context'] as List<dynamic>).map((e) => e as String).toList(),
      type: json['@type'] as String,
      verifiableCredential:
          json['verifiableCredential'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$Iden3commVPProofDTOToJson(
        Iden3commVPProofDTO instance) =>
    <String, dynamic>{
      '@context': instance.context,
      '@type': instance.type,
      'verifiableCredential': instance.verifiableCredential,
    };
