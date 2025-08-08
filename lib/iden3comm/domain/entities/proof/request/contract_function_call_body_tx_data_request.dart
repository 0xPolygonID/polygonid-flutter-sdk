/*
{
  "contract_address": "0x516D8DBece16890d0670Dfd3Cb1740FcdF375B10",
  "method_id": "b68967e2",
  "chain_id": 80001,
  "network": "polygon-mumbai",
  "txHash": "0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef"
}
*/

import 'dart:convert';

import 'package:equatable/equatable.dart';

@Deprecated('Use ContractInvokeTransactionData instead')
typedef OnchainTransactionData = ContractInvokeTransactionData;
@Deprecated('Use ContractInvokeTransactionData instead')
typedef ContractFunctionCallBodyTxDataRequest = ContractInvokeTransactionData;

class ContractInvokeTransactionData with EquatableMixin {
  final String contractAddress;
  final String methodId;
  final int chainId;
  final String? network;
  final String? txHash;

  ContractInvokeTransactionData({
    required this.contractAddress,
    required this.methodId,
    required this.chainId,
    this.network,
    this.txHash,
  });

  factory ContractInvokeTransactionData.fromJson(Map<String, dynamic> json) {
    return ContractInvokeTransactionData(
      contractAddress: json['contract_address'],
      methodId: json['method_id'],
      chainId: json['chain_id'],
      network: json['network'],
      txHash: json['txHash'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'contract_address': contractAddress,
        'method_id': methodId,
        'chain_id': chainId,
        'network': network,
        if (txHash != null) 'txHash': txHash,
      };

  @override
  String toString() => "ContractInvokeTransactionData: ${jsonEncode(toJson())}";

  @override
  List<Object?> get props =>
      [contractAddress, methodId, chainId, network, txHash];
}
