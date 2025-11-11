import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document.dart';

enum InteractionType {
  offer,
  revocation,
  update,
  authRequest,
  credentialProposal,
}

enum InteractionState { received, opened, accepted, declined }

class InteractionEntity with EquatableMixin {
  final String id;
  final String from;
  final InteractionType type;
  final InteractionState state;
  final int timestamp;
  final String? message;
  final String? to;

  final String genesisDid;
  final BigInt profileNonce;

  final List<String> tags;
  final DIDDocument? didDocument;
  final Map<String, dynamic>? metadata;

  InteractionEntity({
    required this.id,
    required this.from,
    required this.to,
    required this.genesisDid,
    required this.profileNonce,
    required this.type,
    required this.state,
    required this.timestamp,
    required this.message,
    this.tags = const [],
    this.didDocument,
    this.metadata,
  });

  factory InteractionEntity.fromJson(Map<String, dynamic> json) {
    return InteractionEntity(
      id: json['id'],
      from: json['from'],
      to: json['to'],
      genesisDid: json['genesisDid'],
      profileNonce: BigInt.parse(json['profileNonce']),
      type: InteractionType.values.firstWhere(
        (type) => type.name == json['type'] || type.toString() == json['type'],
      ),
      state: InteractionState.values.firstWhere(
        (type) =>
            type.name == json['state'] || type.toString() == json['state'],
      ),
      timestamp: json['timestamp'],
      message: json['message'],
      tags:
          (json['tags'] as List<dynamic>?)
              ?.map((tag) => tag.toString())
              .toList() ??
          [],
      didDocument: json['didDocument'] != null
          ? DIDDocument.fromJson(json['didDocument'])
          : null,
      metadata: json['metadata'] != null
          ? Map<String, dynamic>.from(json['metadata'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'from': from,
    'type': type.toString(),
    'state': state.toString(),
    'timestamp': timestamp,
    'message': message,
    'to': to,
    'tags': tags,
    'genesisDid': genesisDid,
    'profileNonce': profileNonce.toString(),
    if (didDocument != null) 'didDocument': didDocument?.toJson(),
    if (metadata != null) 'metadata': metadata,
  };

  @override
  String toString() {
    return 'InteractionEntity ${jsonEncode(toJson())}';
  }

  @override
  List<Object?> get props => [
    id,
    from,
    type,
    state,
    timestamp,
    message,
    to,
    genesisDid,
    profileNonce,
    tags,
    didDocument,
  ];
}
