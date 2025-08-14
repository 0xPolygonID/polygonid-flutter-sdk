import 'dart:convert';

import 'package:equatable/equatable.dart';

/*
{
  "type": "AnimaProofOfLife",
  "context": "https://raw.githubusercontent.com/anima-protocol/claims-polygonid/main/schemas/json-ld/pol-v1.json-ld"
},
*/

/// Represents information about a credential schema.
class CredentialSchemaInfo extends Equatable {
  /// The type of the credential schema.
  final String type;

  /// The context in which the credential schema is used.
  final String context;

  /// Creates a new [CredentialSchemaInfo] instance.
  const CredentialSchemaInfo({
    required this.type,
    required this.context,
  });

  /// Creates a [CredentialSchemaInfo] from a JSON map.
  factory CredentialSchemaInfo.fromJson(Map<String, dynamic> json) {
    return CredentialSchemaInfo(
      type: json['type'] as String,
      context: json['context'] as String,
    );
  }

  /// Converts this [CredentialSchemaInfo] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'context': context,
    };
  }

  @override
  List<Object?> get props => [type, context];

  @override
  String toString() {
    return 'CredentialSchemaInfo: ${jsonEncode(toJson())}';
  }
}
