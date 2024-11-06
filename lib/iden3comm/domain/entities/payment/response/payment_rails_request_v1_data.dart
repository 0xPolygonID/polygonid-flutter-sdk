import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/payment/response/payment_request_data_proof.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/payment/response/payment_request_message_entity.dart';

class Iden3PaymentRailsRequestV1Data extends PaymentRequestData {
  @override
  final String type;
  final List<String> context;
  final String recipient;
  final String amount;
  final String currency;
  final String expirationDate;
  final String nonce;
  final String metadata;
  final List<PaymentRequestDataProof> proof;

  Iden3PaymentRailsRequestV1Data({
    required this.type,
    required this.context,
    required this.recipient,
    required this.amount,
    required this.currency,
    required this.expirationDate,
    required this.nonce,
    required this.metadata,
    required this.proof,
  });

  factory Iden3PaymentRailsRequestV1Data.fromJson(Map<String, dynamic> json) {
    return Iden3PaymentRailsRequestV1Data(
      type: json['type'],
      context: List<String>.from(json['@context']),
      recipient: json['recipient'],
      amount: json['amount'],
      currency: json['currency'],
      expirationDate: json['expirationDate'],
      nonce: json['nonce'],
      metadata: json['metadata'],
      proof: (json['proof'] as List<dynamic>)
          .map((e) => PaymentRequestDataProof.fromJson(e))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "@context": context,
      "type": type,
      "recipient": recipient,
      "amount": amount,
      "currency": currency,
      "expirationDate": expirationDate,
      "nonce": nonce,
      "metadata": metadata,
      "proof": proof.map((e) => e.toJson()).toList(),
    };
  }
}
