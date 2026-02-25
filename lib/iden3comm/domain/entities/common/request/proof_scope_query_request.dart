/*
{
  "type": "https://iden3-communication.io/authorization-response/v1",
  "data": {
    "scope": [
      {
        "type": "zeroknowledge",
        "circuit_id": "auth",
        "pub_signals": [
          "383481829333688262229762912714748186426235428103586432827469388069546950656",
          "12345"
        ],
        "proof_data": {
          "pi_a": [
            "14146277947056297753840642586002829867111675410988595047766001252156753371528",
            "14571022849315211248046007113544986624773029852663683182064313232057584750907",
            "1"
          ],
          "pi_b": [
            [
              "16643510334478363316178974136322830670001098048711963846055396047727066595515",
              "10398230582752448515583571758866992012509398625081722188208617704185602394573"
            ],
            [
              "6754852150473185509183929580585027939167256175425095292505368999953776521762",
              "4988338043999536569468301597030911639875135237017470300699903062776921637682"
            ],
            [
              "1",
              "0"
            ]
          ],
          "pi_c": [
            "17016608018243685488662035612576776697709541343999980909476169114486580874935",
            "1344455328868272682523157740509602348889110849570014394831093852006878298645",
            "1"
          ],
          "protocol": "groth16"
        }
      }
    ]
  }
}

{
  "type": "https://iden3-communication.io/authorization-request/v1",
  "data": {
    "callbackURL": "https://verifier-v2.polygonid.me/api/callback",
    "audience": "1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ",
    "scope": [
      {
        "circuit_id": "auth",
        "rules": {
          "challenge": 664204
        }
      },
      {
        "circuit_id": "credentialAtomicQueryMTP",
        "type": "zeroknowledge",
        "rules": {
          "query": {
            "schema": {
              "type": "KYCAgeCredential",
              "url": "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld"
            },
            "allowedIssuers": "11VJCASgkkuEMvQJ7iKHqZtPbj1i51JpcqGpf5kMP",
            "challenge": 664204,
            "req": {
              "birthday": {
                "$lt": 20000101
              }
            }
          }
        }
      }
    ]
  }
}

{
  "type": "https://iden3-communication.io/authorization-request/v1",
  "data": {
    "callbackUrl": "https://auth-demo.idyllicvision.com/callback?id=27887",
    "audience": "1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ",
    "scope": [
      {
        "circuit_id": "auth",
        "type": "zeroknowledge",
        "rules": {
          "audience": "1125GJqgw6YEsKFwj63GY87MMxPL9kwDKxPUiwMLNZ",
          "challenge": 27887
        }
      }
    ]
  }
}



*/

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:polygonid_flutter_sdk/common/utils/number_extension.dart';

typedef ProofScopeQueryRequest = ZeroKnowledgeProofQuery;

class ZeroKnowledgeProofQuery {
  final List<String> allowedIssuers;
  final String context;
  final Map<String, dynamic>? credentialSubject;
  final String? proofType;
  final bool? skipClaimRevocationCheck;
  final int? groupId;
  final String type;

  // Local field to check if the query is empty.
  final bool empty;

  const ZeroKnowledgeProofQuery({
    required this.allowedIssuers,
    required this.context,
    this.credentialSubject,
    this.proofType,
    this.skipClaimRevocationCheck,
    this.groupId,
    required this.type,
  }) : empty = false;

  const ZeroKnowledgeProofQuery.empty()
    : allowedIssuers = const ['*'],
      context = "",
      credentialSubject = null,
      proofType = null,
      skipClaimRevocationCheck = null,
      groupId = null,
      type = '',
      empty = true;

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [ProofScopeRulesQueryRequest]
  factory ZeroKnowledgeProofQuery.fromJson(Map<String, dynamic> json) {
    return ZeroKnowledgeProofQuery(
      allowedIssuers: List<String>.from(json['allowedIssuers']),
      context: json['context'],
      proofType: json['proofType'],

      credentialSubject: (json['credentialSubject'] as Map<String, dynamic>?)
          ?.deepDoubleToInt(),
      skipClaimRevocationCheck: json['skipClaimRevocationCheck'],
      groupId: json['groupId'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => {
    'allowedIssuers': allowedIssuers,
    'context': context,
    'type': type,
    'credentialSubject': credentialSubject,
    'skipClaimRevocationCheck': skipClaimRevocationCheck,
    'proofType': proofType,
    'groupId': groupId,
  }..removeWhere((dynamic key, dynamic value) => key == null || value == null);

  @override
  String toString() =>
      "[ProofScopeRulesQueryRequest] {allowedIssuers: $allowedIssuers, credentialSubject: $credentialSubject, context: $context, type: $type, skipClaimRevocationCheck: $skipClaimRevocationCheck, proofType: $proofType, groupId: $groupId}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZeroKnowledgeProofQuery &&
          runtimeType == other.runtimeType &&
          listEquals(allowedIssuers, other.allowedIssuers) &&
          context == other.context &&
          type == other.type &&
          proofType == other.proofType &&
          skipClaimRevocationCheck == other.skipClaimRevocationCheck &&
          groupId == other.groupId &&
          const DeepCollectionEquality().equals(
            credentialSubject,
            other.credentialSubject,
          );

  @override
  int get hashCode => runtimeType.hashCode;

  ZeroKnowledgeProofQuery copyWith({
    List<String>? allowedIssuers,
    String? context,
    Map<String, dynamic>? credentialSubject,
    String? proofType,
    bool? skipClaimRevocationCheck,
    int? groupId,
    String? type,
  }) {
    return ZeroKnowledgeProofQuery(
      allowedIssuers: allowedIssuers ?? this.allowedIssuers,
      context: context ?? this.context,
      credentialSubject: credentialSubject ?? this.credentialSubject,
      proofType: proofType ?? this.proofType,
      skipClaimRevocationCheck:
          skipClaimRevocationCheck ?? this.skipClaimRevocationCheck,
      groupId: groupId ?? this.groupId,
      type: type ?? this.type,
    );
  }
}
