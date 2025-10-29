import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/attachment.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/protocol_message_type.dart';

const String messageTypePlain = "application/iden3comm-plain-json";
const String messageTypeZkp = "application/iden3-zkp-json";
const String messageTypeEnc = "application/iden3comm-encrypted-json";
const String messageTypeSigned = "application/iden3comm-signed-json";

enum Iden3MessageType {
  /// Authorization
  authRequest(ProtocolMessageType.authorizationRequestMessageType),
  authResponse(ProtocolMessageType.authorizationResponseMessageType),
  credentialOffer(ProtocolMessageType.credentialOfferMessageType),
  onchainCredentialOffer(ProtocolMessageType.credentialOnchainOfferMessageType),
  credentialIssuanceRequest(
      ProtocolMessageType.credentialIssuanceRequestMessageType),
  credentialIssuanceResponse(
      ProtocolMessageType.credentialIssuanceResponseMessageType),
  credentialEncryptedIssuanceResponse(
      ProtocolMessageType.credentialEncryptedIssuanceResponseType),
  proofContractInvokeRequest(
      ProtocolMessageType.contractInvokeRequestMessageType),
  proofContractInvokeResponse(
      ProtocolMessageType.contractInvokeResponseMessageType),
  credentialRefresh(ProtocolMessageType.credentialRefreshMessageType),
  credentialProposalRequest(ProtocolMessageType.proposalRequestMessageType),
  credentialProposal(ProtocolMessageType.proposalMessageType),
  credentialStatusUpdate(ProtocolMessageType.credentialStatusUpdateMessageType),
  paymentRequest(ProtocolMessageType.paymentRequestMessageType),
  payment(ProtocolMessageType.paymentMessageType),
  problemReport(ProtocolMessageType.problemReportMessageType),
  attestationRequest(ProtocolMessageType.attestationRequestMessageType),
  attestationResponse(ProtocolMessageType.attestationResponseMessageType),
  verificationRequest(ProtocolMessageType.verificationRequestMessageType),
  verificationResponse(ProtocolMessageType.verificationResponseMessageType),
  fetchRequest(ProtocolMessageType.credentialFetchRequestMessageType),
  resourceRequest(ProtocolMessageType.resourcePermissionRequestMessageType),
  resourcePermissionsUpdateRequest(
      ProtocolMessageType.resourcePermissionsUpdateRequestMessageType),
  resourcePermissionsUpdate(
      ProtocolMessageType.resourcePermissionsUpdateMessageType),
  resourceDelivery(ProtocolMessageType.resourceDeliveryMessageType),
  permissionsRequestsList(
      ProtocolMessageType.resourcePermissionsRequestsListFetchMessageType),
  permissionsList(ProtocolMessageType.resourcePermissionsListMessageType),
  permissionsListFetch(
      ProtocolMessageType.resourcePermissionsListFetchMessageType),
  unknown("");

  final String type;

  const Iden3MessageType(this.type);

  factory Iden3MessageType.fromType(String type) {
    return Iden3MessageType.values.firstWhere(
      (element) => element.type == type,
      orElse: () => Iden3MessageType.unknown,
    );
  }

  static Iden3MessageType fromJson(String json) {
    return Iden3MessageType.fromType(json);
  }

  String toJson() => type;

  @override
  String toString() => type;
}

@Deprecated('Use Iden3Message instead')
typedef Iden3MessageEntity<T> = Iden3Message<T>;

/// Represents an iden3 protocol message.
/// https://identity.foundation/didcomm-messaging/spec/#message-headers
abstract class Iden3Message<T> extends Equatable {
  final String id;

  /// The type of the message, e.g. "application/iden3-zkp-json".
  final String? typ;

  /// The type of the message, e.g. "https://iden3-communication.io/authorization/1.0/request".
  final Iden3MessageType type;

  /// The thread id of the message, used to link messages in a conversation.
  final String? thid;

  /// The body of the message, which contains the actual data. Depends on the message type.
  final T body;

  /// The sender of the message, usually a DID.
  // TODO: Make this optional according to protocol.
  final String from;

  /// The recipient of the message, usually a DID.
  final String? to;

  /// The time when the message was created, represented as a Unix timestamp, seconds.
  final int? createdTime;

  /// The time when the message expires, represented as a Unix timestamp, seconds.
  final int? expiresTime;

  /// Attachments for the message, if any.
  final List<Attachment> attachments;

  const Iden3Message({
    required this.id,
    required this.typ,
    required this.type,
    required this.thid,
    required this.body,
    required this.from,
    required this.to,
    required this.createdTime,
    required this.expiresTime,
    required this.attachments,
  });

  @Deprecated('Use type instead')
  Iden3MessageType get messageType => type;

  @override
  String toString() => "Iden3Message: ${jsonEncode(toJson())}";

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'typ': typ,
      'type': type.type,
      'thid': thid,
      'body': (body as dynamic).toJson(),
      'from': from,
      'to': to,
      'created_time': createdTime,
      'expires_time': expiresTime,
      'attachments': attachments.map((e) => e.toJson()).toList(),
    }..removeWhere((_, value) => value == null);
  }

  @override
  List<Object?> get props {
    return [
      id,
      typ,
      type,
      thid,
      body,
      from,
      to,
      createdTime,
      expiresTime,
      attachments,
    ];
  }
}
