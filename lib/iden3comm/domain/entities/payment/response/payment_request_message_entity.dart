import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

/*
https://iden3-communication.io/credentials/0.1/payment-request

{
  "id": "36f9e851-d713-4b50-8f8d-8a9382f138ca",
  "thid": "36f9e851-d713-4b50-8f8d-8a9382f138ca",
  "typ": "application/iden3comm-plain-json",
  "type": "https://iden3-communication.io/credentials/0.1/payment-request",
  "body": {
     "payments": [
      {
       "credentials": [
        {
         "type": "AML",
         "context": "http://test.com"
        }
       ],
       "type": "PaymentRequest",
       "data": {
	       "type": "Iden3PaymentCryptoV1",
	       "amount": 10,
	       "id": "ox",
	       "address": "0xpay1",
	       "signature": "sig"
       },
       "agent": "https://issuer.com",
       "expiration": "timestamp",
       "description": "you can pass the verification on our KYC provider by following the next link"
     }
	  ]
  },
  "to": "did:polygonid:polygon:mumbai:2qJUZDSCFtpR8QvHyBC4eFm6ab9sJo5rqPbcaeyGC4",
  "from": "did:iden3:polygon:mumbai:x3HstHLj2rTp6HHXk2WczYP7w3rpCsRbwCMeaQ2H2"
}
*/
class PaymentRequestEntity extends Iden3MessageEntity<PaymentRequestBody> {
  PaymentRequestEntity({
    required super.id,
    required super.typ,
    required super.type,
    required super.thid,
    required super.from,
    required super.to,
    required super.body,
  }) : super(messageType: Iden3MessageType.paymentRequest);

  factory PaymentRequestEntity.fromJson(Map<String, dynamic> json) {
    return PaymentRequestEntity(
      id: json['id'],
      typ: json['typ'],
      type: json['type'],
      thid: json['thid'],
      body: PaymentRequestBody.fromJson(json['body']),
      from: json['from'],
      to: json['to'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      "body": body.toJson(),
    };
  }
}

class PaymentRequestBody {
  final String agent;
  final List<PaymentRequest> payments;

  PaymentRequestBody({
    required this.agent,
    required this.payments,
  });

  factory PaymentRequestBody.fromJson(Map<String, dynamic> json) {
    return PaymentRequestBody(
      agent: json['agent'],
      payments: List<PaymentRequest>.from(
        json['payments'].map((x) => PaymentRequest.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "agent": agent,
      "payments": payments.map((e) => e.toJson()).toList(),
    };
  }
}

class PaymentRequest {
  final List credentials;
  final String type;
  final PaymentRequestData data;
  final String expiration;
  final String description;

  PaymentRequest({
    required this.credentials,
    required this.type,
    required this.data,
    required this.description,
    required this.expiration,
  });

  factory PaymentRequest.fromJson(Map<String, dynamic> json) {
    return PaymentRequest(
      type: json['type'],
      description: json['description'],
      expiration: json['expiration'],
      credentials: json['credentials'],
      data: PaymentRequestData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "description": description,
      "expiration": expiration,
      "credentials": credentials,
      "data": data.toJson(),
    };
  }
}

/*
"proposals": [{
			"credentials": [{
				"type": "AnimaProofOfLife",
				"context": "https://raw.githubusercontent.com/anima-protocol/claims-polygonid/main/schemas/json-ld/pol-v1.json-ld"
			}],
			"type": "SynapsCredentialProposal",
			"url": "https://synaps-backend-test.polygonid.me/verification?session={{sessionID}}&did={{holderDid}}",
			"description": "Synaps credential proposal"
		}]
*/

class PaymentRequestData {
  final String type;
  final String amount;
  final String id;
  final String? chainId;
  final String? address;
  final String? signature;

  PaymentRequestData({
    required this.type,
    required this.amount,
    required this.id,
    required this.chainId,
    required this.address,
    required this.signature,
  });

  factory PaymentRequestData.fromJson(Map<String, dynamic> json) {
    return PaymentRequestData(
      type: json['type'],
      amount: json['amount'],
      id: json['id'],
      chainId: json['chainId'],
      address: json['address'],
      signature: json['signature'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "amount": amount,
      "id": id,
      "address": address,
      "signature": signature,
    };
  }
}
