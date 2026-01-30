/*
{
    "status": "success",
    "txHash": "0x123"
}
*/

import 'package:polygonid_flutter_sdk/common/json.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

@Deprecated('Use VerificationResponseMessage instead')
typedef VerificationResponseEntity = VerificationResponseMessage;

class VerificationResponseMessage
    extends Iden3Message<VerificationResponseBody> {
  VerificationResponseMessage({
    required super.id,
    required super.typ,
    @Deprecated('may be omitted, gonna be removed in the future') String? type,
    super.thid,
    required super.from,
    required super.body,
    super.to,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(type: Iden3MessageType.verificationResponse);

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [VerificationResponseMessage]
  factory VerificationResponseMessage.fromJson(Map<String, dynamic> json) {
    final body = VerificationResponseBody.fromJson(json['body']);
    return VerificationResponseMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      from: json['from'],
      to: json['to'],
      body: body,
    );
  }

  @override
  String toString() => "[VerificationResponseMessage] {${super.toString()}";

  @override
  bool operator ==(Object other) =>
      super == other && other is VerificationResponseMessage;

  @override
  int get hashCode => runtimeType.hashCode;
}

class VerificationResponseBody implements JsonEncodable {
  final String status;
  final String? txHash;

  VerificationResponseBody({required this.status, this.txHash});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [OfferBodyRequest]
  factory VerificationResponseBody.fromJson(Map<String, dynamic> json) {
    return VerificationResponseBody(
      status: json['status'],
      txHash: json['txHash'],
    );
  }

  Map<String, dynamic> toJson() => {'status': status, 'txHash': txHash};

  @override
  String toString() =>
      "[VerificationResponseBody] {status: $status, txHash: $txHash}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VerificationResponseBody &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          txHash == other.txHash;

  @override
  int get hashCode => runtimeType.hashCode;
}
