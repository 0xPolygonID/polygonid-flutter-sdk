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

import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/request/contract_function_call_body_request.dart';

@Deprecated('Use ContractInvokeRequestMessage instead')
typedef ContractIden3MessageEntity = ContractInvokeRequestMessage;

class ContractInvokeRequestMessage
    extends Iden3Message<ContractInvokeRequestBody> {
  ContractInvokeRequestMessage({
    required super.id,
    super.typ,
    @Deprecated('may be omitted, gonna be removed in the future') String? type,
    String? thid,
    required super.body,
    String? from,
    super.to,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(
          type: Iden3MessageType.proofContractInvokeRequest,
          thid: thid ?? '',
          from: from ?? '',
        );

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [ContractInvokeRequestMessage]
  factory ContractInvokeRequestMessage.fromJson(Map<String, dynamic> json) {
    ContractInvokeRequestBody body =
        ContractInvokeRequestBody.fromJson(json['body']);
    return ContractInvokeRequestMessage(
      id: json['id'],
      typ: json['typ'] ?? '',
      thid: json['thid'] ?? '',
      body: body,
      from: json['from'] ?? '',
    );
  }

  @override
  String toString() => "[ContractInvokeRequestMessage] {${super.toString()}";

  @override
  bool operator ==(Object other) =>
      super == other && other is ContractInvokeRequestMessage;

  @override
  int get hashCode => runtimeType.hashCode;
}
