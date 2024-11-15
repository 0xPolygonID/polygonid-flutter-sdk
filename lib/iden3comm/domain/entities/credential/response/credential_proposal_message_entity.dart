import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

/*
https://iden3-communication.io/credentials/0.1/proposal

{
	"id": "45f13336-80e3-41b6-8430-f80cc7e32979",
	"typ": "application/iden3comm-plain-json",
	"type": "https://iden3-communication.io/credentials/0.1/proposal",
	"thid": "45f13336-80e3-41b6-8430-f80cc7e32979",
	"body": {
		"proposals": [{
			"credentials": [{
				"type": "AnimaProofOfLife",
				"context": "https://raw.githubusercontent.com/anima-protocol/claims-polygonid/main/schemas/json-ld/pol-v1.json-ld"
			}],
			"type": "SynapsCredentialProposal",
			"url": "https://synaps-backend-test.polygonid.me/verification?session={{sessionID}}&did={{holderDid}}",
			"description": "Synaps credential proposal"
		}]
	},
	"from": "did:polygonid:polygon:amoy:2qTyfBq71SK1BLycaHT7GZ1vSdsY2HveczioQcYMXC",
	"to": "did:polygonid:polygon:amoy:2qRHzfG7yvULahKDg9eRNX4kTBJb6EZcCBLQoUKx8x"
}
*/
class CredentialProposal extends Iden3MessageEntity<CredentialProposalBody> {
  CredentialProposal({
    required super.id,
    required super.typ,
    required super.type,
    required super.thid,
    required super.body,
    required super.from,
    required super.to,
  }) : super(messageType: Iden3MessageType.credentialProposal);

  factory CredentialProposal.fromJson(Map<String, dynamic> json) {
    return CredentialProposal(
      id: json['id'],
      typ: json['typ'],
      type: json['type'],
      thid: json['thid'],
      body: CredentialProposalBody.fromJson(json['body']),
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

class CredentialProposalBody {
  final List<CredentialProposalProposal> proposals;

  CredentialProposalBody({
    required this.proposals,
  });

  factory CredentialProposalBody.fromJson(Map<String, dynamic> json) {
    return CredentialProposalBody(
      proposals: List<CredentialProposalProposal>.from(
          json['proposals'].map((x) => CredentialProposalProposal.fromJson(x))),
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
class CredentialProposalProposal {
  final List<CredentialProposalProposalCredential> credentials;
  final String type;
  final String url;
  final String description;

  CredentialProposalProposal({
    required this.credentials,
    required this.type,
    required this.url,
    required this.description,
  });

  factory CredentialProposalProposal.fromJson(Map<String, dynamic> json) {
    return CredentialProposalProposal(
      credentials: List<CredentialProposalProposalCredential>.from(
          json['credentials']
              .map((x) => CredentialProposalProposalCredential.fromJson(x))),
      type: json['type'],
      url: json['url'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "credentials": List<dynamic>.from(credentials
          .map((CredentialProposalProposalCredential x) => x.toJson())),
      "type": type,
      "url": url,
      "description": description,
    };
  }
}

/*
"credentials": [{
				"type": "AnimaProofOfLife",
				"context": "https://raw.githubusercontent.com/anima-protocol/claims-polygonid/main/schemas/json-ld/pol-v1.json-ld"
			}],
			*/
class CredentialProposalProposalCredential {
  final String type;
  final String context;

  CredentialProposalProposalCredential({
    required this.type,
    required this.context,
  });

  factory CredentialProposalProposalCredential.fromJson(
      Map<String, dynamic> json) {
    return CredentialProposalProposalCredential(
      type: json['type'],
      context: json['context'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "context": context,
    };
  }
}
