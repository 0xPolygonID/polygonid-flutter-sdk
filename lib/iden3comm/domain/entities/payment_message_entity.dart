import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

/*
https://iden3-communication.io/credentials/0.1/payment

{
  "id": "36f9e851-d713-4b50-8f8d-8a9382f138ca",
  "thid": "36f9e851-d713-4b50-8f8d-8a9382f138ca",
  "typ": "application/iden3comm-plain-json",
  "type": "https://iden3-communication.io/credentials/0.1/payment",
  "body": {
     "payments": [
      {
       "id":"123",
       "type":"Iden3PaymentCryptoV1",
        "paymentData":{ // base on defined type
				    "txId": "0xPay2",
				}
     }
	  ]
  },
  "to": "did:polygonid:polygon:mumbai:2qJUZDSCFtpR8QvHyBC4eFm6ab9sJo5rqPbcaeyGC4",
  "from": "did:iden3:polygon:mumbai:x3HstHLj2rTp6HHXk2WczYP7w3rpCsRbwCMeaQ2H2"
}
*/

class PaymentMessageEntity extends Iden3MessageEntity<PaymentBody> {
  PaymentMessageEntity({
    required super.id,
    required super.typ,
    required super.type,
    required super.thid,
    required super.from,
    required super.to,
    required super.body,
  }) : super(messageType: Iden3MessageType.payment);

  factory PaymentMessageEntity.fromJson(Map<String, dynamic> json) {
    return PaymentMessageEntity(
      id: json['id'],
      typ: json['typ'],
      type: json['type'],
      thid: json['thid'],
      body: PaymentBody.fromJson(json['body']),
      from: json['from'],
      to: json['to'],
    );
  }
}

class PaymentBody {
  final List<Payment> payments;

  PaymentBody({
    required this.payments,
  });

  factory PaymentBody.fromJson(Map<String, dynamic> json) {
    return PaymentBody(
      payments:
          List<Payment>.from(json['payments'].map((x) => Payment.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "payments": payments.map((e) => e.toJson()).toList(),
    };
  }
}

class Payment {
  final String id;
  final String type;
  final PaymentData paymentData;

  Payment({
    required this.id,
    required this.type,
    required this.paymentData,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    final String type = json['type'];
    PaymentData paymentData;

    switch (type) {
      case 'Iden3PaymentCryptoV1':
        paymentData = Iden3PaymentCryptoV1Data.fromJson(json['paymentData']);
        break;
      case 'Iden3PaymentRailsV1':
        paymentData = Iden3PaymentRailsV1Data.fromJson(json['paymentData']);
        break;
      case 'Iden3PaymentRailsERC20V1':
        paymentData =
            Iden3PaymentRailsERC20V1Data.fromJson(json['paymentData']);
        break;
      default:
        throw Exception('Unknown payment type: $type');
    }

    return Payment(
      id: json['id'],
      type: type,
      paymentData: paymentData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type": type,
      "paymentData": paymentData.toJson(),
    };
  }
}

abstract class PaymentData {
  Map<String, dynamic> toJson();
}

class Iden3PaymentCryptoV1Data extends PaymentData {
  final String txId;

  Iden3PaymentCryptoV1Data({required this.txId});

  factory Iden3PaymentCryptoV1Data.fromJson(Map<String, dynamic> json) {
    return Iden3PaymentCryptoV1Data(txId: json['txId']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'txId': txId};
  }
}

class Iden3PaymentRailsV1Data extends PaymentData {
  final String txId;
  final String chainId;

  Iden3PaymentRailsV1Data({required this.txId, required this.chainId});

  factory Iden3PaymentRailsV1Data.fromJson(Map<String, dynamic> json) {
    return Iden3PaymentRailsV1Data(
      txId: json['txId'],
      chainId: json['chainId'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'txId': txId,
      'chainId': chainId,
    };
  }
}

class Iden3PaymentRailsERC20V1Data extends PaymentData {
  final String txId;
  final String chainId;
  final String tokenAddress;

  Iden3PaymentRailsERC20V1Data({
    required this.txId,
    required this.chainId,
    required this.tokenAddress,
  });

  factory Iden3PaymentRailsERC20V1Data.fromJson(Map<String, dynamic> json) {
    return Iden3PaymentRailsERC20V1Data(
      txId: json['txId'],
      chainId: json['chainId'],
      tokenAddress: json['tokenAddress'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'txId': txId,
      'chainId': chainId,
      'tokenAddress': tokenAddress,
    };
  }
}
