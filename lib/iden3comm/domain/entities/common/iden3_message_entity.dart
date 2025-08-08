import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/attachment.dart';

enum Iden3MessageType {
  authRequest("https://iden3-communication.io/authorization/1.0/request"),
  authResponse("https://iden3-communication.io/authorization/1.0/response"),
  credentialOffer("https://iden3-communication.io/credentials/1.0/offer"),
  onchainCredentialOffer(
      "https://iden3-communication.io/credentials/1.0/onchain-offer"),
  credentialIssuanceResponse(
      "https://iden3-communication.io/credentials/1.0/issuance-response"),
  proofContractInvokeRequest(
      "https://iden3-communication.io/proofs/1.0/contract-invoke-request"),
  proofContractInvokeResponse(
      "https://iden3-communication.io/proofs/1.0/contract-invoke-response"),
  credentialRefresh("https://iden3-communication.io/credentials/1.0/refresh"),
  credentialProposalRequest(
      "https://iden3-communication.io/credentials/0.1/proposal-request"),
  credentialProposal("https://iden3-communication.io/credentials/0.1/proposal"),
  credentialStatusUpdate(
      "https://iden3-communication.io/credentials/1.0/status-update"),
  paymentRequest(
      "https://iden3-communication.io/credentials/0.1/payment-request"),
  payment("https://iden3-communication.io/credentials/0.1/payment"),
  problemReport("https://didcomm.org/report-problem/2.0/problem-report"),
  attestationRequest("https://iden3-communication.io/attestation/0.1/request"),
  attestationResponse(
      "https://iden3-communication.io/attestation/0.1/response"),
  verificationRequest(
      "https://iden3-communication.io/passport/0.1/verification-request"),
  verificationResponse(
      "https://iden3-communication.io/passport/0.1/verification-response"),
  fetchRequest("https://iden3-communication.io/credentials/1.0/fetch-request"),
  unknown("");

  final String type;

  const Iden3MessageType(this.type);

  factory Iden3MessageType.fromType(String type) {
    return Iden3MessageType.values.firstWhere(
      (element) => element.type == type,
      orElse: () => Iden3MessageType.unknown,
    );
  }
}

/// Represents an iden3 protocol message.
/// https://identity.foundation/didcomm-messaging/spec/#message-headers
abstract class Iden3MessageEntity<T> extends Equatable {
  final String id;

  /// The type of the message, e.g. "application/iden3-zkp-json".
  final String? typ;

  /// The type of the message, e.g. "https://iden3-communication.io/authorization/1.0/request".
  final Iden3MessageType type;

  /// The thread id of the message, used to link messages in a conversation.
  // TODO: Make this optional according to protocol.
  final String thid;

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

  /// Optional next request, used for chaining messages.
  final Map<String, dynamic>? nextRequest;

  const Iden3MessageEntity({
    required this.id,
    this.typ,
    required this.type,
    required this.thid,
    required this.body,
    required this.from,
    this.to,
    this.nextRequest,
    this.createdTime,
    this.expiresTime,
    this.attachments = const [],
  });

  @Deprecated('Use type instead.')
  Iden3MessageType get messageType => type;

  @override
  String toString() => "Iden3MessageEntity: ${jsonEncode(toJson())}";

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'typ': typ,
      'type': type.name,
      'thid': thid,
      'body': (body as dynamic).toJson(),
      'from': from,
      'to': to,
      'created_time': createdTime,
      'expires_time': expiresTime,
      'next_request': nextRequest,
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
      nextRequest,
    ];
  }
}
