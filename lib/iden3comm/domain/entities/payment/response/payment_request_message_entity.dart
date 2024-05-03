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
class PaymentRequestEntity extends Iden3MessageEntity<PaymentProposalBody> {
  PaymentRequestEntity({
    required super.id,
    required super.typ,
    required super.type,
    required super.thid,
    required super.from,
    required super.to,
    required PaymentProposalBody body,
  }) : super(
          body: body,
          messageType: Iden3MessageType.paymentRequest,
        );

  factory PaymentRequestEntity.fromJson(Map<String, dynamic> json) {
    return PaymentRequestEntity(
      id: json['id'],
      typ: json['typ'],
      type: json['type'],
      thid: json['thid'],
      body: PaymentProposalBody.fromJson(json['body']),
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

class PaymentProposalBody {
  final List<PaymentProposal> payments;

  PaymentProposalBody({
    required this.payments,
  });

  factory PaymentProposalBody.fromJson(Map<String, dynamic> json) {
    return PaymentProposalBody(
      payments: List<PaymentProposal>.from(
        json['payments'].map((x) => PaymentProposal.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "payments": payments.map((e) => e.toJson()).toList(),
    };
  }
}

class PaymentProposal {
  final String type;
  final String description;

  final String agent;
  final String expiration;
  final List credentials;
  final PaymentProposalData data;

  PaymentProposal({
    required this.type,
    required this.description,
    required this.agent,
    required this.expiration,
    required this.credentials,
    required this.data,
  });

  factory PaymentProposal.fromJson(Map<String, dynamic> json) {
    return PaymentProposal(
      type: json['type'],
      description: json['description'],
      agent: json['agent'],
      expiration: json['expiration'],
      credentials: json['credentials'],
      data: PaymentProposalData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "description": description,
      "agent": agent,
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

class PaymentProposalData {
  final String type;
  final int amount;
  final String id;
  final String address;
  final String signature;

  PaymentProposalData({
    required this.type,
    required this.amount,
    required this.id,
    required this.address,
    required this.signature,
  });

  factory PaymentProposalData.fromJson(Map<String, dynamic> json) {
    return PaymentProposalData(
      type: json['type'],
      amount: json['amount'],
      id: json['id'],
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
