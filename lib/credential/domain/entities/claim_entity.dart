import 'package:equatable/equatable.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/display_type/display_type.dart';

typedef ClaimState = CredentialState;

enum CredentialState { active, expired, pending, revoked }

typedef ClaimEntity = CredentialEntity;

class CredentialEntity with EquatableMixin {
  final String id;
  final String issuer;
  final String did;
  final CredentialState state;
  final String? expiration;
  final String? issuanceDate;
  final Map<String, dynamic>? schema;
  final String type;
  final Map<String, dynamic> info;
  final DisplayType? displayType;

  final String credentialRawValue;

  CredentialEntity({
    required this.id,
    required this.issuer,
    required this.did,
    required this.state,
    this.expiration,
    this.issuanceDate,
    this.schema,
    required this.type,
    required this.info,
    this.displayType,
    required this.credentialRawValue,
  });

  factory CredentialEntity.fromJson(Map<String, dynamic> json) {
    return CredentialEntity(
      id: json['id'],
      issuer: json['issuer'],
      did: json['did'],
      state: CredentialState.values.firstWhere((e) => e.name == json['state']),
      expiration: json['expiration'],
      issuanceDate: json['issuanceDate'],
      schema: json['schema'],
      type: json['type'],
      info: json['info'],
      displayType: json['displayType'],
      credentialRawValue: json['credentialRawValue'],
    );
  }

  Map<String, dynamic> get credentialSubject {
    return info["credentialSubject"];
  }

  /// Whether this credential has passed its expiration date.
  ///
  /// Returns `false` when [expiration] is null (no expiration set) or when the
  /// date string cannot be parsed. This is a real-time check independent of the
  /// persisted [state] field, which may be stale.
  bool get isExpiredByDate {
    final exp = expiration;
    if (exp == null) return false;
    try {
      return DateTime.now().toUtc().isAfter(DateTime.parse(exp));
    } catch (_) {
      return false;
    }
  }

  List<String> get context {
    return info["@context"];
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'issuer': issuer,
        'did': did,
        'state': state.name,
        'expiration': expiration,
        'issuanceDate': issuanceDate,
        'schema': schema,
        'type': type,
        'info': info,
        'displayType': displayType?.toJson(),
        'credentialRawValue': credentialRawValue,
      };

  //copyWith method
  CredentialEntity copyWith({
    String? id,
    String? issuer,
    String? did,
    CredentialState? state,
    String? expiration,
    String? issuanceDate,
    Map<String, dynamic>? schema,
    String? type,
    Map<String, dynamic>? info,
    DisplayType? displayType,
    String? credentialRawValue,
  }) {
    return CredentialEntity(
      id: id ?? this.id,
      issuer: issuer ?? this.issuer,
      did: did ?? this.did,
      state: state ?? this.state,
      expiration: expiration ?? this.expiration,
      issuanceDate: issuanceDate ?? this.issuanceDate,
      schema: schema ?? this.schema,
      type: type ?? this.type,
      info: info ?? this.info,
      displayType: displayType ?? this.displayType,
      credentialRawValue: credentialRawValue ?? this.credentialRawValue,
    );
  }

  @override
  List<Object?> get props => [
        id,
        issuer,
        did,
        state,
        expiration,
        issuanceDate,
        schema,
        type,
        info,
        displayType,
        credentialRawValue,
      ];
}
