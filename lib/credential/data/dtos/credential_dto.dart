import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'credential_proofs/credential_proof_dto.dart';

part 'credential_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class CredentialDTO extends Equatable {
  final String id;
  final String? expiration;
  final bool? updatable;
  final int version;
  @JsonKey(name: 'rev_nonce')
  final int revNonce;
  final CredentialSubjectDTO credentialSubject;
  final CredentialStatusDTO credentialStatus;
  final CredentialSchemaDTO credentialSchema;
  @JsonKey(name: 'proof')
  final List<CredentialProofDTO> proofs;

  const CredentialDTO(
      this.id,
      this.expiration,
      this.updatable,
      this.version,
      this.revNonce,
      this.credentialSubject,
      this.credentialStatus,
      this.credentialSchema,
      this.proofs);

  factory CredentialDTO.fromJson(Map<String, dynamic> json) =>
      _$CredentialDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CredentialDTOToJson(this);

  @override
  List<Object?> get props => [
        id,
        expiration,
        updatable,
        version,
        revNonce,
        credentialSubject,
        credentialStatus,
        credentialSchema,
        proofs
      ];
}

class CredentialSubjectDTO extends Equatable {
  final int documentType;
  final String id;
  final String type;
  final Map<String, dynamic>? data;

  const CredentialSubjectDTO(this.documentType, this.id, this.type, this.data);

  /// There are dynamic field which depends on the [type]
  /// but since we don't want to set the possible [type] in stone, we unserialize
  /// them in [data] (removing the known fields)
  factory CredentialSubjectDTO.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? data = json;
    int documentType = json['documentType'] as int;
    String id = json['id'] as String;
    String type = json['type'] as String;
    data.remove('documentType');
    data.remove('id');
    data.remove('type');

    return CredentialSubjectDTO(documentType, id, type, data);
  }

  Map<String, dynamic> toJson() {
    var result = {
      'documentType': documentType,
      'id': id,
      'type': type,
    };

    data?.forEach((key, value) => result.putIfAbsent(key, () => value));

    return result;
  }

  @override
  List<Object?> get props => [documentType, id, type, data];
}

@JsonSerializable()
class CredentialStatusDTO extends Equatable {
  final String id;
  final String type;

  const CredentialStatusDTO(this.id, this.type);

  factory CredentialStatusDTO.fromJson(Map<String, dynamic> json) =>
      _$CredentialStatusDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CredentialStatusDTOToJson(this);

  @override
  List<Object?> get props => [id, type];
}

@JsonSerializable()
class CredentialSchemaDTO extends Equatable {
  @JsonKey(name: '@id')
  final String id;
  final String type;

  const CredentialSchemaDTO(this.id, this.type);

  factory CredentialSchemaDTO.fromJson(Map<String, dynamic> json) =>
      _$CredentialSchemaDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CredentialSchemaDTOToJson(this);

  @override
  List<Object?> get props => [id, type];
}
