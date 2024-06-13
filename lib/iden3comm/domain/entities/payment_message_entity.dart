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
    return Payment(
      id: json['id'],
      type: json['type'],
      paymentData: PaymentData.fromJson(json['paymentData']),
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

class PaymentData {
  final String txId;

  PaymentData({
    required this.txId,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      txId: json['txId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "txId": txId,
    };
  }
}
