import 'package:polygonid_flutter_sdk/common/json.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_info_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:uuid/uuid.dart';

class CredentialIssuanceMessage
    extends RequiredIden3Message<IssuanceMessageBody> {
  CredentialIssuanceMessage({
    String? id,
    required super.typ,
    String? thid,
    required super.body,
    required super.from,
    required super.to,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(
         id: id ?? const Uuid().v4(),
         type: Iden3MessageType.credentialIssuanceResponse,
         thid: thid ?? const Uuid().v4(),
       );

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [CredentialFetchRequestBody]
  factory CredentialIssuanceMessage.fromJson(Map<String, dynamic> json) {
    final body = IssuanceMessageBody.fromJson(json['body']);

    return CredentialIssuanceMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      from: json['from'],
      to: json['to'],
      body: body,
    );
  }

  @override
  String toString() => "[CredentialIssuanceMessage] {${super.toString()}}";

  @override
  bool operator ==(Object other) =>
      super == other && other is CredentialIssuanceMessage;

  @override
  int get hashCode => runtimeType.hashCode;
}

class IssuanceMessageBody implements JsonEncodable {
  final W3CCredential credential;

  IssuanceMessageBody({required this.credential});

  factory IssuanceMessageBody.fromJson(Map<String, dynamic> json) {
    return IssuanceMessageBody(
      credential: W3CCredential.fromJson(json['credential']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'credential': credential.toJson()};
  }
}
