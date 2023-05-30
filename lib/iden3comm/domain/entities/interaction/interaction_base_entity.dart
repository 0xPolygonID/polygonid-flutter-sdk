enum InteractionType {
  offer,
  revocation,
  update,
  authRequest,
}

enum InteractionState {
  received,
  opened,
  accepted,
  declined,
}

class InteractionBaseEntity {
  final String id;
  final String from;
  final InteractionType type;
  final InteractionState state;
  final int timestamp;
  final String message;

  InteractionBaseEntity({
    required this.id,
    required this.from,
    required this.type,
    this.state = InteractionState.received,
    required this.timestamp,
    required this.message,
  });

  factory InteractionBaseEntity.fromJson(Map<String, dynamic> json) {
    return InteractionBaseEntity(
      id: json['id'],
      from: json['from'],
      type: InteractionType.values.firstWhere((type) =>
          type.name == json['type'] || type.toString() == json['type']),
      state: InteractionState.values.firstWhere((type) =>
          type.name == json['state'] || type.toString() == json['state']),
      timestamp: json['timestamp'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'from': from,
        'type': type.toString(),
        'state': state.toString(),
        'timestamp': timestamp,
        'message': message,
      };

  @override
  String toString() =>
      "[InteractionBaseEntity] {id: $id, from: $from, type: $type, state: $state, timestamp: $timestamp, message: $message}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InteractionBaseEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          from == other.from &&
          type == other.type &&
          state == other.state &&
          timestamp == other.timestamp &&
          message == other.message;

  @override
  int get hashCode => runtimeType.hashCode;
}
