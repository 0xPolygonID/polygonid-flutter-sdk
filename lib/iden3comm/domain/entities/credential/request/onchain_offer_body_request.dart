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

import 'package:flutter/foundation.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/base.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/credential_offer_data.dart';

class OnchainOfferBodyRequest extends CredentialOfferBody {
  final OnchainTransactionData transactionData;

  OnchainOfferBodyRequest({
    required super.credentials,
    required this.transactionData,
  });

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [OnchainOfferBodyRequest]
  factory OnchainOfferBodyRequest.fromJson(Map<String, dynamic> json) {
    List<CredentialOfferData> credentials = (json['credentials'] as List)
        .map((item) => CredentialOfferData.fromJson(item))
        .toList();
    return OnchainOfferBodyRequest(
      credentials: credentials,
      transactionData:
          OnchainTransactionData.fromJson(json['transaction_data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'credentials': credentials.map((item) => item.toJson()).toList(),
        'transaction_data': transactionData.toJson(),
      };

  @override
  String toString() =>
      "[OfferBodyRequest] {credentials: $credentials, transactionData: $transactionData}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnchainOfferBodyRequest &&
          runtimeType == other.runtimeType &&
          listEquals(credentials, other.credentials) &&
          transactionData == other.transactionData;

  @override
  int get hashCode => runtimeType.hashCode;
}

class OnchainTransactionData {
  final String contractAddress;
  final String? methodId;
  final int? chainId;
  final String? network;

  OnchainTransactionData({
    required this.contractAddress,
    required this.methodId,
    required this.chainId,
    required this.network,
  });

  factory OnchainTransactionData.fromJson(Map<String, dynamic> json) {
    return OnchainTransactionData(
      contractAddress: json['contract_address'],
      methodId: json['method_id'],
      chainId: json['chain_id'],
      network: json['network'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'contract_address': contractAddress,
        'method_id': methodId,
        'chain_id': chainId,
        'network': network,
      };

  @override
  String toString() =>
      "[OnchainTransactionData] {contractAddress: $contractAddress, methodId: $methodId, chainId: $chainId, network: $network}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnchainTransactionData &&
          runtimeType == other.runtimeType &&
          contractAddress == other.contractAddress &&
          methodId == other.methodId &&
          chainId == other.chainId &&
          network == other.network;

  @override
  int get hashCode => runtimeType.hashCode;
}
