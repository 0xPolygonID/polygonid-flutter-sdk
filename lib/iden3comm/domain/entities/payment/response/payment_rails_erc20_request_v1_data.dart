import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/payment/response/payment_rails_request_v1_data.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/payment/response/payment_request_data_proof.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/payment/response/payment_request_message_entity.dart';

class Iden3PaymentRailsERC20RequestV1Data
    extends Iden3PaymentRailsRequestV1Data {
  final String tokenAddress;
  final List<String>? features;

  @override
  PaymentRequestDataType get paymentRequestDataType =>
      PaymentRequestDataType.railsERC20V1;

  Iden3PaymentRailsERC20RequestV1Data({
    required super.type,
    required super.context,
    required super.recipient,
    required super.amount,
    required super.expirationDate,
    required super.nonce,
    required super.metadata,
    required super.proof,
    required this.tokenAddress,
    this.features,
  });

  factory Iden3PaymentRailsERC20RequestV1Data.fromJson(
      Map<String, dynamic> json) {
    return Iden3PaymentRailsERC20RequestV1Data(
      type: json['type'],
      context: List<String>.from(json['@context']),
      tokenAddress: json['tokenAddress'],
      recipient: json['recipient'],
      amount: json['amount'],
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
    final json = super.toJson();
    json['tokenAddress'] = tokenAddress;
    if (features != null) {
      json['features'] = features!;
    }
    return json;
  }
}
