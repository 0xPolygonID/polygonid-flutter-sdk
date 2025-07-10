import 'package:flutter/foundation.dart';

enum InteractionType {
  offer,
  revocation,
  update,
  authRequest,
  credentialProposal,
}

enum InteractionState {
  received,
  opened,
  accepted,
  declined,
}

class InteractionEntity {
  final String id;
  final String from;
  final InteractionType type;
  final InteractionState state;
  final int timestamp;
  final String? message;
  final String? to;

  final String genesisDid;
  final BigInt profileNonce;

  final List<String>? tags;

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
    this.tags,
  });

  factory InteractionEntity.fromJson(Map<String, dynamic> json) {
    return InteractionEntity(
      id: json['id'],
      from: json['from'],
      to: json['to'],
      genesisDid: json['genesisDid'],
      profileNonce: BigInt.parse(json['profileNonce']),
      type: InteractionType.values.firstWhere((type) =>
          type.name == json['type'] || type.toString() == json['type']),
      state: InteractionState.values.firstWhere((type) =>
          type.name == json['state'] || type.toString() == json['state']),
      timestamp: json['timestamp'],
      message: json['message'],
      tags: (json['tags'] as List<dynamic>?)
          ?.map((tag) => tag.toString())
          .toList(),
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
      };

  @override
  String toString() {
    return 'InteractionEntity{id: $id, from: $from, type: $type, state: $state, timestamp: $timestamp, message: $message, to: $to, genesisDid: $genesisDid, profileNonce: $profileNonce, tags: $tags}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InteractionEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          from == other.from &&
          type == other.type &&
          state == other.state &&
          timestamp == other.timestamp &&
          message == other.message &&
          to == other.to &&
          genesisDid == other.genesisDid &&
          profileNonce == other.profileNonce &&
          listEquals(tags, other.tags);

  @override
  int get hashCode =>
      id.hashCode ^
      from.hashCode ^
      type.hashCode ^
      state.hashCode ^
      timestamp.hashCode ^
      message.hashCode ^
      to.hashCode ^
      genesisDid.hashCode ^
      profileNonce.hashCode ^
      tags.hashCode;
}
