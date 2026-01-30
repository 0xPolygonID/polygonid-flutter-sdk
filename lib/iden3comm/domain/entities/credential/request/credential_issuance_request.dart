import 'package:polygonid_flutter_sdk/common/json.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:uuid/uuid.dart';

class CredentialIssuanceRequestMessage
    extends Iden3Message<CredentialIssuanceRequestMessageBody> {
  CredentialIssuanceRequestMessage({
    String? id,
    required super.typ,
    String? thid,
    required super.body,
    required super.from,
    super.to,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(
          id: id ?? const Uuid().v4(),
          type: Iden3MessageType.credentialIssuanceRequest,
          thid: thid ?? const Uuid().v4(),
        );

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [CredentialFetchRequestBody]
  factory CredentialIssuanceRequestMessage.fromJson(Map<String, dynamic> json) {
    final body = CredentialIssuanceRequestMessageBody.fromJson(json['body']);

    return CredentialIssuanceRequestMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      from: json['from'],
      to: json['to'],
      body: body,
    );
  }

  @override
  String toString() =>
      "[CredentialIssuanceRequestMessage] {${super.toString()}}";

  @override
  bool operator ==(Object other) =>
      super == other && other is CredentialIssuanceRequestMessage;

  @override
  int get hashCode => runtimeType.hashCode;
}

class CredentialIssuanceRequestMessageBody implements JsonEncodable {
  final Schema schema;
  final Map<String, dynamic> data;
  final int expiration;

  CredentialIssuanceRequestMessageBody({
    required this.schema,
    required this.data,
    required this.expiration,
  });

  factory CredentialIssuanceRequestMessageBody.fromJson(
      Map<String, dynamic> json) {
    return CredentialIssuanceRequestMessageBody(
      schema: Schema.fromJson(json['schema']),
      data: json['data'],
      expiration: json['expiration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'schema': schema.toJson(),
      'data': data,
      'expiration': expiration,
    };
  }
}

class Schema {
  final String? hash;
  final String url;
  final String type;

  Schema({
    required this.hash,
    required this.url,
    required this.type,
  });

  factory Schema.fromJson(Map<String, dynamic> json) {
    return Schema(
      hash: json['hash'],
      url: json['url'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hash': hash,
      'url': url,
      'type': type,
    };
  }
}
