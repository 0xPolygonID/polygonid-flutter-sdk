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

class ContractFunctionCallBodyTxDataRequest {
  final String contractAddress; // required, ethereum contract address format
  final String methodId; // required, hex string, ethereum function selector
  final int chainId; // required, number of chain.
  final String? network;

  ContractFunctionCallBodyTxDataRequest(
      {required this.contractAddress,
      required this.methodId,
      required this.chainId,
      this.network});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [ContractFunctionCallBodyTxDataRequest]
  factory ContractFunctionCallBodyTxDataRequest.fromJson(
      Map<String, dynamic> json) {
    return ContractFunctionCallBodyTxDataRequest(
        contractAddress: json['contract_address'],
        methodId: json['method_id'],
        chainId: json['chain_id'],
        network: json['network']);
  }

  Map<String, dynamic> toJson() => {
        'contract_address': contractAddress,
        'method_id': methodId,
        'chain_id': chainId,
        'network': network,
      };

  @override
  String toString() =>
      "[ContractFunctionCallBodyTxDataRequest] {contractAddress: $contractAddress, methodId: $methodId, chainId: $chainId, network: $network}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContractFunctionCallBodyTxDataRequest &&
          runtimeType == other.runtimeType &&
          contractAddress == other.contractAddress &&
          methodId == other.methodId &&
          chainId == other.chainId &&
          network == other.network;

  @override
  int get hashCode => runtimeType.hashCode;
}
