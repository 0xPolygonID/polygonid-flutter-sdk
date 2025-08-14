import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/payment/response/payment_request_data_proof.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/payment/response/payment_request_message_entity.dart';

@Deprecated('Use Iden3PaymentRailsRequestV1 instead')
typedef Iden3PaymentRailsRequestV1Data = Iden3PaymentRailsRequestV1;

class Iden3PaymentRailsRequestV1 extends PaymentRequestData {
  @override
  final String type;
  final List<String> context;
  final String recipient;
  final String amount;
  final String expirationDate;
  final String nonce;
  final String metadata;
  final List<PaymentRequestDataProof> proof;

  @override
  PaymentRequestDataType get paymentRequestDataType =>
      PaymentRequestDataType.railsV1;

  Iden3PaymentRailsRequestV1({
    required this.type,
    required this.context,
    required this.recipient,
    required this.amount,
    required this.expirationDate,
    required this.nonce,
    required this.metadata,
    required this.proof,
  });

  factory Iden3PaymentRailsRequestV1.fromJson(Map<String, dynamic> json) {
    return Iden3PaymentRailsRequestV1(
      type: json['type'],
      context: List<String>.from(json['@context']),
      recipient: json['recipient'],
      amount: json['amount'],
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
      "expirationDate": expirationDate,
      "nonce": nonce,
      "metadata": metadata,
      "proof": proof.map((e) => e.toJson()).toList(),
    };
  }
}
