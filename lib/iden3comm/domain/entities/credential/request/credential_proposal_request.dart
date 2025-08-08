import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/credential_schema_info.dart';

/*
"body": {
    "credentials": [
      {
        "type": "LivenessProof",
        "context": "http://test.com"
      },
      {
        "type": "KYC",
        "context": "http://test.com"
      }
    ],
     "metadata": {
        "type": "TransactionInfo",
        "data": "json1"
     }
    "did_doc": {
      "@context": ["..."]
      "id" : "did:iden3:polygon:mumbai:x3HstHLj2rTp6HHXk2WczYP7w3rpCsRbwCMeaQ2H2",
      "services":[
        {
           "id": "did:iden3:polygon:mumbai:x3HstHLj2rTp6HHXk2WczYP7w3rpCsRbwCMeaQ2H2/mobile",
           "type":  "Iden3Mobile"
        },
        {
           "id": "did:iden3:polygon:mumbai:x3HstHLj2rTp6HHXk2WczYP7w3rpCsRbwCMeaQ2H2/push",
           "type":  "PushNotificationService"
        }
      ]
    }
  },
*/

typedef CredentialProposalRequest = ProposalRequestMessage;


/// Represents a credential proposal request message
/// https://iden3-communication.io/credentials/0.1/proposal-request
class ProposalRequestMessage
    extends Iden3MessageEntity<ProposalRequestMessageBody> {
  ProposalRequestMessage({
    required super.id,
    required super.typ,
    @Deprecated('may be omitted, gonna be removed in the future') String? type,
    required super.thid,
    @Deprecated('may be omitted, gonna be removed in the future') String? type,
    required super.from,
    required super.body,
    required super.to,
    super.nextRequest,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(type: Iden3MessageType.credentialProposalRequest);

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [ProposalRequestMessage]
  factory ProposalRequestMessage.fromJson(Map<String, dynamic> json) {
    return ProposalRequestMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      from: json['from'],
      to: json['to'],
      body: ProposalRequestMessageBody.fromJson(json['body']),
      nextRequest: json['next_request'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }

  @override
  String toString() =>
      "[CredentialProposalRequestMessage] {${super.toString()}}";

  @override
  bool operator ==(Object other) =>
      super == other && other is ProposalRequestMessage;

  @override
  int get hashCode => id.hashCode;
}

@Deprecated('Use ProposalRequestMessageBody instead')
typedef CredentialProposalBodyRequest = ProposalRequestMessageBody;

class ProposalRequestMessageBody {
  final List<ProposalRequestCredential> credentials;
  Map<String, dynamic>? didDoc;
  MetadataObject? metadata;

  ProposalRequestMessageBody({
    required this.credentials,
    this.metadata,
    this.didDoc,
  });

  factory ProposalRequestMessageBody.fromJson(Map<String, dynamic> json) {
    List<ProposalRequestCredential> credentials = (json['credentials'] as List)
        .map((item) => ProposalRequestCredential.fromJson(item))
        .toList();
    MetadataObject? metadata;
    if (json['metadata'] != null) {
      metadata = MetadataObject.fromJson(json['metadata']);
    }
    Map<String, dynamic>? didDoc;
    if (json['did_doc'] != null) {
      didDoc = json['did_doc'];
    }
    return ProposalRequestMessageBody(
      credentials: credentials,
      metadata: metadata,
      didDoc: didDoc,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'credentials': credentials.map((item) => item.toJson()).toList(),
      'metadata': metadata?.toJson(),
      'did_doc': didDoc,
    };
  }
}

@Deprecated('Use ProposalRequestCredential instead')
typedef CredentialObject = ProposalRequestCredential;

typedef ProposalRequestCredential = CredentialSchemaInfo;

/*
 {
        "type": "TransactionInfo",
        "data": "json1"
     }
*/
class MetadataObject {
  final String type;
  final String data;

  MetadataObject({required this.type, required this.data});

  factory MetadataObject.fromJson(Map<String, dynamic> json) {
    return MetadataObject(
      type: json['type'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'data': data,
    };
  }
}
