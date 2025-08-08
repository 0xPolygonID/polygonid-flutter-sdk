/*
{
    "status": "success",
    "txHash": "0x123"
}
*/

import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

class VerificationResponseEntity
    extends Iden3MessageEntity<VerificationResponseBody> {
  VerificationResponseEntity({
    required super.id,
    required super.typ,
    required super.thid,
    required super.from,
    required super.body,
    super.to,
    super.nextRequest,
  }) : super(type: Iden3MessageType.verificationResponse);

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [VerificationResponseEntity]
  factory VerificationResponseEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    final body = VerificationResponseBody.fromJson(json['body']);
    return VerificationResponseEntity(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      from: json['from'],
      to: json['to'],
      body: body,
      nextRequest: json['next_request'],
    );
  }

  @override
  String toString() => "[VerificationResponseEntity] {${super.toString()}";

  @override
  bool operator ==(Object other) =>
      super == other && other is VerificationResponseEntity;

  @override
  int get hashCode => runtimeType.hashCode;
}

class VerificationResponseBody {
  final String status;
  final String? txHash;

  VerificationResponseBody({
    required this.status,
    this.txHash,
  });

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

  Map<String, dynamic> toJson() => {
        'status': status,
        'txHash': txHash,
      };

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
