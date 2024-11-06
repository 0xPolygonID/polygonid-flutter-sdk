import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/payment/response/payment_request_data_proof.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/payment/response/payment_request_message_entity.dart';

class Iden3PaymentRailsERC20RequestV1Data extends PaymentRequestData {
  @override
  final String type;
  final List<String> context;
  final String tokenAddress;
  final String recipient;
  final String amount;
  final String currency;
  final String expirationDate;
  final String nonce;
  final String metadata;
  final List<String>? features;
  final List<PaymentRequestDataProof> proof;

  Iden3PaymentRailsERC20RequestV1Data({
    required this.type,
    required this.context,
    required this.tokenAddress,
    required this.recipient,
    required this.amount,
    required this.currency,
    required this.expirationDate,
    required this.nonce,
    required this.metadata,
    this.features,
    required this.proof,
  });

  factory Iden3PaymentRailsERC20RequestV1Data.fromJson(
      Map<String, dynamic> json) {
    return Iden3PaymentRailsERC20RequestV1Data(
      type: json['type'],
      context: List<String>.from(json['@context']),
      tokenAddress: json['tokenAddress'],
      recipient: json['recipient'],
      amount: json['amount'],
      currency: json['currency'],
      expirationDate: json['expirationDate'],
      nonce: json['nonce'],
      metadata: json['metadata'],
      features:
          json['features'] != null ? List<String>.from(json['features']) : null,
      proof: (json['proof'] as List<dynamic>)
          .map((e) => PaymentRequestDataProof.fromJson(e))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = {
      "@context": context,
      "type": type,
      "tokenAddress": tokenAddress,
      "recipient": recipient,
      "amount": amount,
      "currency": currency,
      "expirationDate": expirationDate,
      "nonce": nonce,
      "metadata": metadata,
      "proof": proof.map((e) => e.toJson()).toList(),
    };

    if (features != null) {
      json['features'] = features!;
    }

    return json;
  }
}
