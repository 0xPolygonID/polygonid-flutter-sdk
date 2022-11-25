/*
{
  "id": "c811849d-6bfb-4d85-936e-3d9759c7f105",
  "typ": "application/iden3comm-plain-json",
  "type": "https://iden3-communication.io/proofs/1.0/contract-invoke-request",
  "body": {
    "transaction_data": {
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

import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';

import 'contract_function_call_body_request.dart';

class ContractIden3MessageEntity extends Iden3MessageEntity {
  @override
  final ContractFunctionCallBodyRequest body;

  ContractIden3MessageEntity(
      {required String id, required String typ, required this.body})
      : super(
            from: '',
            id: id,
            type: Iden3MessageType.contractFunctionCall,
            thid: '',
            typ: typ);

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [ContractIden3MessageEntity]
  factory ContractIden3MessageEntity.fromJson(Map<String, dynamic> json) {
    ContractFunctionCallBodyRequest body =
        ContractFunctionCallBodyRequest.fromJson(json['body']);
    return ContractIden3MessageEntity(
      id: json['id'],
      typ: json['typ'],
      body: body,
    );
  }

  @override
  String toString() =>
      "[ContractIden3MessageEntity] {id: $id, typ: $typ, type: $type, thid: $thid, body: $body, from: $from}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContractIden3MessageEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          typ == other.typ &&
          type == other.type &&
          thid == other.thid &&
          body == other.body &&
          from == other.from;

  @override
  int get hashCode => runtimeType.hashCode;
}
