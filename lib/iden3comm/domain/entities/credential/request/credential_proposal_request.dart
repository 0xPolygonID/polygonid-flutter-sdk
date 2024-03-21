import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

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

/*
{
        "type": "LivenessProof",
        "context": "http://test.com"
      },
      {
        "type": "KYC",
        "context": "http://test.com"
      }
*/
class CredentialObject {
  final String type;
  final String context;

  CredentialObject({required this.type, required this.context});

  factory CredentialObject.fromJson(Map<String, dynamic> json) {
    return CredentialObject(
      type: json['type'],
      context: json['context'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'context': context,
    };
  }
}

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

class CredentialProposalBodyRequest {
  final List<CredentialObject> credentials;
  final MetadataObject? metadata;
  final Map<String, dynamic>? didDoc;

  CredentialProposalBodyRequest({
    required this.credentials,
    required this.metadata,
    required this.didDoc,
  });

  factory CredentialProposalBodyRequest.fromJson(Map<String, dynamic> json) {
    List<CredentialObject> credentials = (json['credentials'] as List)
        .map((item) => CredentialObject.fromJson(item))
        .toList();
    MetadataObject? metadata;
    if (json['metadata'] != null) {
      metadata = MetadataObject.fromJson(json['metadata']);
    }
    Map<String, dynamic>? didDoc;
    if (json['did_doc'] != null) {
      didDoc = json['did_doc'];
    }
    return CredentialProposalBodyRequest(
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

class CredentialProposalRequest
    extends Iden3MessageEntity<CredentialProposalBodyRequest> {
  CredentialProposalRequest({
    required super.id,
    required super.typ,
    required super.type,
    required super.thid,
    required super.from,
    required super.body,
    required super.to,
    super.nextRequest,
  }) : super(messageType: Iden3MessageType.credentialProposalRequest);

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [CredentialProposalRequest]
  factory CredentialProposalRequest.fromJson(Map<String, dynamic> json) {
    return CredentialProposalRequest(
      id: json['id'],
      typ: json['typ'],
      type: json['type'],
      thid: json['thid'],
      from: json['from'],
      to: json['to'],
      body: CredentialProposalBodyRequest.fromJson(json['body']),
      nextRequest: json['next_request'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }

  @override
  String toString() => "[CredentialProposalRequest] {${super.toString()}}";

  @override
  bool operator ==(Object other) =>
      super == other && other is CredentialProposalRequest;


}
