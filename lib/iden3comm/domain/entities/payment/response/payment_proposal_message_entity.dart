import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

/*
https://iden3-communication.io/credentials/0.1/payment-proposal

{
  "id": "36f9e851-d713-4b50-8f8d-8a9382f138ca",
  "thid": "36f9e851-d713-4b50-8f8d-8a9382f138ca",
  "typ": "application/iden3comm-plain-json",
  "type": "https://iden3-communication.io/credentials/0.1/payment-proposal",
  "body": {
     "proposals": [
      {
       "credentials": [
        {
         "type": "AML",
         "context": "http://test.com"
        }
       ],
       "type":"PaymentRequest",
       "expiration": "timestamp",
       "description":"you can pass the verification on our KYC provider by following the next link",
     }
	  ]
  },
  "to": "did:polygonid:polygon:mumbai:2qJUZDSCFtpR8QvHyBC4eFm6ab9sJo5rqPbcaeyGC4",
  "from": "did:iden3:polygon:mumbai:x3HstHLj2rTp6HHXk2WczYP7w3rpCsRbwCMeaQ2H2"
}
*/
class PaymentProposal extends Iden3MessageEntity<CredentialProposalBody> {
  CredentialProposal({
    required String id,
    required String typ,
    required String type,
    required String thid,
    required PaymentProposalBody body,
    required String from,
    required String to,
  }) : super(
          id: id,
          typ: typ,
          type: type,
          thid: thid,
          body: body,
          from: from,
          to: to,
        );

  factory CredentialProposal.fromJson(Map<String, dynamic> json) {
    return CredentialProposal(
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
      "id": id,
      "typ": typ,
      "type": type,
      "thid": thid,
      "body": body.toJson(),
      "from": from,
      "to": to,
    };
  }
}

class PaymentProposalBody {
  // TODO:
  final String proposals;

  PaymentProposalBody({
    required this.proposals,
  });

  factory PaymentProposalBody.fromJson(Map<String, dynamic> json) {
    return CredentialProposalBody(
      // TODO:
      // proposals: List<CredentialProposalProposal>.from(
      //     json['proposals'].map((x) => CredentialProposalProposal.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "proposals": List<dynamic>.from(
          proposals.map((CredentialProposalProposal x) => x.toJson())),
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