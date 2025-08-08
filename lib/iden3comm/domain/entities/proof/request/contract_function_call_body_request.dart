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

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/request/contract_function_call_body_tx_data_request.dart';

typedef ContractFunctionCallBodyRequest = ContractInvokeRequestBody;

class ContractInvokeRequestBody {
  final String? reason;
  final ContractInvokeTransactionData transactionData;
  final List<ZeroKnowledgeProofRequest> scope;
  final DIDDocument? didDoc;
  final List<String>? accept;

  ContractInvokeRequestBody({
    this.reason,
    required this.transactionData,
    required this.scope,
    this.didDoc,
    this.accept,
  });

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [ContractInvokeRequestBody]
  factory ContractInvokeRequestBody.fromJson(Map<String, dynamic> json) {
    ContractInvokeTransactionData transactionData =
        ContractInvokeTransactionData.fromJson(json['transaction_data']);
    final scope = (json['scope'] as List?)
            ?.map((item) => ZeroKnowledgeProofRequest.fromJson(item))
            .toList() ??
        [];

    final didDoc =
        json['did_doc'] != null ? DIDDocument.fromJson(json['did_doc']) : null;

    final accept =
        (json['accept'] as List?)?.map((item) => item as String).toList();

    return ContractInvokeRequestBody(
      transactionData: transactionData,
      reason: json['reason'],
      scope: scope,
      didDoc: didDoc,
      accept: accept,
    );
  }

  Map<String, dynamic> toJson() => {
        'reason': reason,
        'transaction_data': transactionData.toJson(),
        'scope': scope.map((item) => item.toJson()).toList(),
        if (didDoc != null) 'did_doc': didDoc?.toJson(),
        if (accept != null) 'accept': accept,
      };

  @override
  String toString() => "ContractInvokeRequestBody: ${jsonEncode(toJson())}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContractInvokeRequestBody &&
          runtimeType == other.runtimeType &&
          transactionData == other.transactionData &&
          reason == other.reason &&
          listEquals(scope, other.scope);

  @override
  int get hashCode => runtimeType.hashCode;
}
