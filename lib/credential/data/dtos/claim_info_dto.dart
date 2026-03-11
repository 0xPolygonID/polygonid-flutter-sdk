import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'claim_proofs/claim_proof_dto.dart';

part 'claim_info_dto.g.dart';

typedef ClaimInfoDTO = W3CCredential;

@JsonSerializable(explicitToJson: true)
class W3CCredential extends Equatable {
  final String id;
  @JsonKey(name: '@context')
  final List<String> context;
  final List<String> type;
  final String? expirationDate;
  final RefreshService? refreshService;
  final DisplayMethod? displayMethod;
  final String? issuanceDate;
  final CredentialSubject credentialSubject;
  final CredentialStatus credentialStatus;
  final String issuer;
  final CredentialSchema credentialSchema;
  final List<ClaimProofDTO>? proof;

  const W3CCredential(
    this.id,
    this.context,
    this.type,
    this.expirationDate,
    this.issuanceDate,
    this.credentialSubject,
    this.credentialStatus,
    this.issuer,
    this.credentialSchema,
    this.proof,
    this.refreshService,
    this.displayMethod,
  );

  factory W3CCredential.fromJson(Map<String, dynamic> json) =>
      _$W3CCredentialFromJson(json);

  Map<String, dynamic> toJson() =>
      _$W3CCredentialToJson(this)..removeWhere((key, value) => value == null);

  @override
  List<Object?> get props => [
        id,
        context,
        type,
        expirationDate,
        issuanceDate,
        credentialSubject,
        credentialStatus,
        issuer,
        credentialSchema,
        proof,
        refreshService,
      ];
}

typedef RefreshServiceDTO = RefreshService;

/// If credential is refreshable, this is the data needed to refresh it
class RefreshService {
  final String id;
  final String type;

  const RefreshService(this.id, this.type);

  factory RefreshService.fromJson(Map<String, dynamic> json) {
    String id = json['id'] as String;
    String type = json['type'] as String;

    return RefreshService(id, type);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = {
      'id': id,
      'type': type,
    };

    return result;
  }

  @override
  List<Object?> get props => [id, type];

  @override
  String toString() {
    return 'RefreshServiceDTO{id: $id, type: $type}';
  }
}

typedef CredentialSubjectDTO = CredentialSubject;

class CredentialSubject extends Equatable {
  final String id;
  final String type;
  final Map<String, dynamic>? data;

  const CredentialSubject(this.id, this.type, this.data);

  /// There are dynamic field which depends on the [type]
  /// but since we don't want to set the possible [type] in stone, we unserialize
  /// them in [data] (removing the known fields)
  factory CredentialSubject.fromJson(Map<String, dynamic> json) {
    // Make a deep copy of the json to avoid modifying the original
    Map<String, dynamic> data = jsonDecode(jsonEncode(json));

    String id = json['id'] as String;
    String type = json['type'] as String;
    data.remove('id');
    data.remove('type');

    return CredentialSubject(id, type, data);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = {
      'id': id,
      'type': type,
    };

    data?.forEach((key, value) => result.putIfAbsent(key, () => value));

    return result;
  }

  @override
  List<Object?> get props => [id, type, data];
}

@JsonEnum()
enum CredentialStatusType {
  @JsonValue("SparseMerkleTreeProof")
  sparseMerkleTreeProof,
  @JsonValue("Iden3ReverseSparseMerkleTreeProof")
  reverseSparseMerkleTreeProof,
  @JsonValue("Iden3commRevocationStatusV1.0")
  iden3commRevocationStatusV1,
  @JsonValue("Iden3OnchainSparseMerkleTreeProof2023")
  iden3OnchainSparseMerkleTreeProof2023;

  bool get useRHS {
    switch (this) {
      case CredentialStatusType.reverseSparseMerkleTreeProof:
        return true;
      case CredentialStatusType.sparseMerkleTreeProof:
      case CredentialStatusType.iden3commRevocationStatusV1:
      case CredentialStatusType.iden3OnchainSparseMerkleTreeProof2023:
        return false;
    }
  }

  bool get onchain {
    switch (this) {
      case CredentialStatusType.iden3OnchainSparseMerkleTreeProof2023:
        return true;
      case CredentialStatusType.sparseMerkleTreeProof:
      case CredentialStatusType.reverseSparseMerkleTreeProof:
      case CredentialStatusType.iden3commRevocationStatusV1:
        return false;
    }
  }
}

typedef CredentialStatusDTO = CredentialStatus;

@JsonSerializable(explicitToJson: true)
class CredentialStatus extends Equatable {
  final String id;
  final int? revocationNonce;
  @JsonKey(name: 'type')
  final CredentialStatusType type;
  final CredentialStatus? statusIssuer;

  const CredentialStatus(
      this.id, this.revocationNonce, this.type, this.statusIssuer);

  factory CredentialStatus.fromJson(Map<String, dynamic> json) =>
      _$CredentialStatusFromJson(json);

  Map<String, dynamic> toJson() => _$CredentialStatusToJson(this)
    ..removeWhere((dynamic key, dynamic value) => key == null || value == null);

  @override
  List<Object?> get props => [id, revocationNonce, type, statusIssuer];
}

typedef CredentialSchemaDTO = CredentialSchema;

@JsonSerializable()
class CredentialSchema extends Equatable {
  final String id;
  final String type;

  const CredentialSchema(this.id, this.type);

  factory CredentialSchema.fromJson(Map<String, dynamic> json) =>
      _$CredentialSchemaFromJson(json);

  Map<String, dynamic> toJson() => _$CredentialSchemaToJson(this);

  @override
  List<Object?> get props => [id, type];
}

typedef DisplayMethodDTO = DisplayMethod;

@JsonSerializable()
class DisplayMethod {
  /// Contains url.
  final String id;
  final String type;

  DisplayMethod(this.id, this.type);

  factory DisplayMethod.fromJson(Map<String, dynamic> json) =>
      _$DisplayMethodFromJson(json);

  Map<String, dynamic> toJson() => _$DisplayMethodToJson(this);

  @override
  List<Object?> get props => [id, type];
}
