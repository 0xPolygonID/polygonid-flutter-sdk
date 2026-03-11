import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/credential_schema_info.dart';
import 'package:uuid/uuid.dart';

/*
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
@Deprecated('Use ProposalMessage instead')
typedef CredentialProposal = ProposalMessage;

/// Represents a credential proposal message
/// https://iden3-communication.io/credentials/0.1/proposal
class ProposalMessage extends Iden3Message<ProposalMessageBody> {
  ProposalMessage({
    String? id,
    required super.typ,
    @Deprecated('may be omitted, gonna be removed in the future') String? type,
    String? thid,
    required super.body,
    required super.from,
    required super.to,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(
         id: id ?? const Uuid().v4(),
         type: Iden3MessageType.credentialProposal,
         thid: thid ?? const Uuid().v4(),
       );

  factory ProposalMessage.fromJson(Map<String, dynamic> json) {
    return ProposalMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      body: ProposalMessageBody.fromJson(json['body']),
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

class ProposalMessageBody implements JsonEncodable {
  final List<Proposal> proposals;

  ProposalMessageBody({required this.proposals});

  factory ProposalMessageBody.fromJson(Map<String, dynamic> json) {
    return ProposalMessageBody(
      proposals: List<Proposal>.from(
        json['proposals'].map((x) => Proposal.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "proposals": List<dynamic>.from(
        proposals.map((Proposal x) => x.toJson()),
      ),
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

@Deprecated('Use Proposal instead')
typedef CredentialProposalEntity = Proposal;

class Proposal {
  final List<ProposalRequestCredential> credentials;
  final String type;
  final String url;
  final String description;

  Proposal({
    required this.credentials,
    required this.type,
    required this.url,
    required this.description,
  });

  factory Proposal.fromJson(Map<String, dynamic> json) {
    return Proposal(
      credentials: List<ProposalRequestCredential>.from(
        json['credentials'].map((x) => ProposalRequestCredential.fromJson(x)),
      ),
      type: json['type'],
      url: json['url'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "credentials": List<dynamic>.from(
        credentials.map((ProposalRequestCredential x) => x.toJson()),
      ),
      "type": type,
      "url": url,
      "description": description,
    };
  }
}

@Deprecated('Use ProposalRequestCredential instead')
typedef CredentialProposalProposalCredential = ProposalRequestCredential;

typedef ProposalRequestCredential = CredentialSchemaInfo;
