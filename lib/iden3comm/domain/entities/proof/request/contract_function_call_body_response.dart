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

import 'package:flutter/foundation.dart';
import 'package:polygonid_flutter_sdk/common/json.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/request/contract_function_call_body_tx_data_request.dart';

typedef ContractFunctionCallResponseBody = ContractInvokeResponseBody;

class ContractInvokeResponseBody implements JsonEncodable {
  final ContractInvokeTransactionData transactionData;
  final List<ProofScopeResponse> scope;
  final Map<String, dynamic>? didDoc;

  ContractInvokeResponseBody({
    required this.transactionData,
    required this.scope,
    this.didDoc,
  });

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [ContractInvokeRequestBody]
  factory ContractInvokeResponseBody.fromJson(Map<String, dynamic> json) {
    ContractInvokeTransactionData transactionData =
        ContractInvokeTransactionData.fromJson(json['transaction_data']);
    List<ProofScopeResponse> scope = (json['scope'] as List)
        .map((item) => ProofScopeResponse.fromJson(item))
        .toList();
    return ContractInvokeResponseBody(
      transactionData: transactionData,
      scope: scope,
      didDoc: json['did_doc'],
    );
  }

  Map<String, dynamic> toJson() => {
    'transaction_data': transactionData.toJson(),
    'scope': scope.map((item) => item.toJson()).toList(),
    'did_doc': didDoc,
  };

  @override
  String toString() =>
      "[ContractInvokeRequestBody] {transactionData: $transactionData, didDoc: $didDoc, scope: $scope}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContractInvokeResponseBody &&
          runtimeType == other.runtimeType &&
          transactionData == other.transactionData &&
          didDoc == other.didDoc &&
          listEquals(scope, other.scope);

  @override
  int get hashCode => runtimeType.hashCode;
}
