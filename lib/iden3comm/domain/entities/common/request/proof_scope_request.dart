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
  "id": "627a0eb7-2b7b-40aa-aa2b-f201a2b4b709",
  "typ": "application/iden3comm-plain-json",
  "type": "https://iden3-communication.io/authorization/1.0/request",
  "thid": "627a0eb7-2b7b-40aa-aa2b-f201a2b4b709",
  "body": {
    "callbackUrl": "https://verifier-v2.polygonid.me/api/callback?sessionId=590414",
    "reason": "test flow",
    "scope": [
      {
        "id": 1,
        "circuitId": "credentialAtomicQuerySigV2",
        "query": {
          "allowedIssuers": [
            "*"
          ],
          "context": "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v3.json-ld",
          "credentialSubject": {
            "birthday": {
              "$lt": 20000101
            }
          },
          "type": "KYCAgeCredential"
        }
      }
    ]
  },
  "from": "did:polygonid:polygon:mumbai:2qDyy1kEo2AYcP3RT4XGea7BtxsY285szg6yP9SPrs"
}

*/

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_query_request.dart';

class ProofScopeRequest {
  final int id;
  final String circuitId;
  final bool? optional;
  final ProofScopeQueryRequest query;

  ProofScopeRequest({
    required this.id,
    required this.circuitId,
    this.optional,
    required this.query,
  });

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [ProofScopeRequest]
  factory ProofScopeRequest.fromJson(Map<String, dynamic> json) {
    ProofScopeQueryRequest query =
        ProofScopeQueryRequest.fromJson(json['query']);
    return ProofScopeRequest(
      id: json['id'],
      circuitId: json['circuitId'],
      optional: json['optional'],
      query: query,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'circuitId': circuitId,
        'optional': optional,
        'query': query.toJson(),
      }..removeWhere(
          (dynamic key, dynamic value) => key == null || value == null);

  @override
  String toString() =>
      "[ProofScopeRequest] {id: $id, circuitId: $circuitId, optional: $optional, query: $query}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProofScopeRequest &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          circuitId == other.circuitId &&
          optional == other.optional &&
          query == other.query;

  @override
  int get hashCode => runtimeType.hashCode;
}
