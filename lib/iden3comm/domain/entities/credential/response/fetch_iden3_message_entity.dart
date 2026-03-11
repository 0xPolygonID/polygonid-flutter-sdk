import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/response/fetch_body_request.dart';
import 'package:uuid/uuid.dart';

@Deprecated('Use CredentialFetchRequestMessage instead')
typedef FetchIden3MessageEntity = CredentialFetchRequestMessage;

class CredentialFetchRequestMessage
    extends Iden3Message<CredentialFetchRequestBody> {
  CredentialFetchRequestMessage({
    String? id,
    required super.typ,
    @Deprecated('may be omitted, gonna be removed in the future') String? type,
    String? thid,
    required super.from,
    required super.body,
    required super.to,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(
         id: id ?? const Uuid().v4(),
         type: Iden3MessageType.fetchRequest,
         thid: thid ?? const Uuid().v4(),
       );

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [CredentialFetchRequestBody]
  factory CredentialFetchRequestMessage.fromJson(Map<String, dynamic> json) {
    final body = CredentialFetchRequestBody.fromJson(json['body']);

    return CredentialFetchRequestMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      from: json['from'],
      to: json['to'],
      body: body,
    );
  }

  @override
  String toString() => "[CredentialFetchRequestMessage] {${super.toString()}}";

  @override
  bool operator ==(Object other) =>
      super == other && other is CredentialFetchRequestMessage;

  @override
  int get hashCode => runtimeType.hashCode;
}
