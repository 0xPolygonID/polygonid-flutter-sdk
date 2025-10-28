import 'package:equatable/equatable.dart';

/// Sample
/// ``` "vp":{
///       "@context": ["https://www.w3.org/2018/credentials/v1"]
///       "type": "VerifiablePresentation",
///       "verifiableCredential": {
///         "@context": [
///           "https://www.w3.org/2018/credentials/v1",
///           "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v3.json-ld",
///         ]
///         "type": [ "VerifiableCredential","KYCAgeCredential"],
///         "credentialSubject":{
///           "type: "KYCAgeCredential",
///           "birthday": 19960424
///         }
///       }
///     }
/// ```
class Iden3commVPProof with EquatableMixin {
  final List<String> context;
  final String type;
  final Map<String, dynamic> verifiableCredential;

  const Iden3commVPProof({
    required this.context,
    required this.type,
    required this.verifiableCredential,
  });

  factory Iden3commVPProof.fromJson(Map<String, dynamic> json) {
    return Iden3commVPProof(
      context: (json['@context'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      // TODO: Remove this once clib is updated.
      type: (json['type'] as String?) ?? (json['@type'] as String),
      verifiableCredential:
          (json['verifiableCredential'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    '@context': context,
    'type': type,
    'verifiableCredential': verifiableCredential,
  };

  @override
  String toString() =>
      "[Iden3commVPProof] {type: $type, context: $context, verifiableCredential: $verifiableCredential}";

  @override
  List<Object?> get props => [context, type, verifiableCredential];
}
