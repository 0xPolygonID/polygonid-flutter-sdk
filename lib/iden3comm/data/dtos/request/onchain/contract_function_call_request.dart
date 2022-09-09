/*
{
  "id": "c811849d-6bfb-4d85-936e-3d9759c7f105",
  "typ": "application/iden3comm-plain-json",
  "type": "https://iden3-communication.io/proofs/1.0/contract-invoke-request",
  "body": {
    "transcation_data": {
      "contract_address": "0x516D8DBece16890d0670Dfd3Cb1740FcdF375B10",
      "method_id": "b68967e2",
      "chain_id": 80001,
      "network": "polygon-mumbai"
    },
    "reason": "airdrop participation",
    "scope": [
      {
        "id": 1,
        "circuit_id": "credentialAtomicQueryMTP",
        "rules": {
          "query": {
            "allowed_issuers": [
              "*"
            ],
            "req": {
              "birthday": {
                "$lt": 20000101
              }
            },
            "schema": {
              "url": "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json-ld/kyc-v2.json-ld",
              "type": "KYCAgeCredential"
            }
          }
        }
      }
    ]
  }
}
*/

import 'contract_function_call_body_request.dart';

class ContractFunctionCallRequest {
  final String? id;
  final String? typ;
  final String? type;
  final ContractFunctionCallBodyRequest? body;

  ContractFunctionCallRequest({this.id, this.typ, this.type, this.body});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [ContractFunctionCallRequest]
  factory ContractFunctionCallRequest.fromJson(Map<String, dynamic> json) {
    ContractFunctionCallBodyRequest body =
        ContractFunctionCallBodyRequest.fromJson(json['body']);
    return ContractFunctionCallRequest(
      id: json['id'],
      typ: json['typ'],
      type: json['type'],
      body: body,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'typ': typ,
        'type': type,
        'body': body!.toJson(),
      };
}
