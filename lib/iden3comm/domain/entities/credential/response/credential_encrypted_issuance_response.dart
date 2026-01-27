import 'package:equatable/equatable.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/attachment.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/jose/jwe.dart';

class CredentialEncryptedIssuanceResponse
    extends Iden3Message<CredentialEncryptedIssuanceResponseBody> {
  CredentialEncryptedIssuanceResponse({
    required super.id,
    required super.typ,
    required super.thid,
    required super.body,
    required super.from,
    required super.to,
    required super.createdTime,
    required super.expiresTime,
    required super.attachments,
  }) : super(type: Iden3MessageType.credentialEncryptedIssuanceResponse);

  factory CredentialEncryptedIssuanceResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return CredentialEncryptedIssuanceResponse(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      body: CredentialEncryptedIssuanceResponseBody.fromJson(json['body']),
      from: json['from'],
      to: json['to'],
      createdTime: json['created_time'],
      expiresTime: json['expires_time'],
      attachments:
          (json['attachments'] as List<dynamic>?)
              ?.map((e) => Attachment.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class CredentialEncryptedIssuanceResponseBody with EquatableMixin {
  final String id;
  final String context;
  final String type;
  final JsonWebEncryption data;
  final List<Map<String, dynamic>> proof;

  CredentialEncryptedIssuanceResponseBody({
    required this.id,
    required this.context,
    required this.type,
    required this.data,
    required this.proof,
  });

  factory CredentialEncryptedIssuanceResponseBody.fromJson(
    Map<String, dynamic> json,
  ) {
    return CredentialEncryptedIssuanceResponseBody(
      id: json['id'],
      context: json['context'],
      type: json['type'],
      data: JsonWebEncryption.fromJson(json['data']),
      proof: (json['proof'] as List<dynamic>)
          .map((p) => p as Map<String, dynamic>)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'context': context,
      'type': type,
      'data': data.toJson(),
      'proof': proof,
    };
  }

  @override
  List<Object?> get props => [id, context, type, data, proof];
}
