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
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/request/contract_function_call_body_response.dart';

@Deprecated('Use ContractInvokeResponseMessage instead')
typedef ContractResponseIden3MessageEntity = ContractInvokeResponseMessage;

class ContractInvokeResponseMessage
    extends Iden3Message<ContractInvokeResponseBody> {
  ContractInvokeResponseMessage({
    required super.id,
    String? typ,
    @Deprecated('may be omitted, gonna be removed in the future') String? type,
    super.thid = '',
    required super.body,
    String? from,
    super.to,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(
          type: Iden3MessageType.proofContractInvokeResponse,
          typ: typ ?? '',
          from: from ?? '',
        );

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [ContractInvokeRequestMessage]
  factory ContractInvokeResponseMessage.fromJson(Map<String, dynamic> json) {
    final body = ContractInvokeResponseBody.fromJson(json['body']);
    return ContractInvokeResponseMessage(
      id: json['id'],
      typ: json['typ'] ?? '',
      thid: json['thid'] ?? '',
      body: body,
      from: json['from'] ?? '',
    );
  }

  @override
  String toString() => "[ContractInvokeResponseMessage] {${super.toString()}";

  @override
  bool operator ==(Object other) =>
      super == other && other is ContractInvokeResponseMessage;

  @override
  int get hashCode => runtimeType.hashCode;
}
