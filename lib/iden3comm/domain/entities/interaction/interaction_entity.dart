enum InteractionType {
  connection,
  offer,
  revocation,
  update,
  authRequest,
}

class InteractionEntity {
  final int? id;
  final String from;
  final String genesisDid;
  final BigInt profileNonce;
  final InteractionType type;
  final int timestamp;
  final String message;

  InteractionEntity({
    this.id,
    required this.from,
    required this.genesisDid,
    required this.profileNonce,
    required this.type,
    required this.timestamp,
    required this.message,
  });

  factory InteractionEntity.fromJson(Map<String, dynamic> json) {
    return InteractionEntity(
      id: json['id'],
      from: json['from'],
      genesisDid: json['genesisDid'],
      profileNonce: BigInt.parse(json['profileNonce']),
      type: InteractionType.values
          .firstWhere((type) => type.toString() == json['type']),
      timestamp: json['timestamp'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'from': from,
        'genesisDid': genesisDid,
        'profileNonce': profileNonce.toString(),
        'type': type.toString(),
        'timestamp': timestamp,
        'message': message,
      };

  @override
  String toString() =>
      "[InteractionEntity] {id: $id, from: $from, genesisDid: $genesisDid, profileNonce: $profileNonce, type: $type, timestamp: $timestamp, message: $message}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InteractionEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          from == other.from &&
          genesisDid == other.genesisDid &&
          profileNonce == other.profileNonce &&
          type == other.type &&
          timestamp == other.timestamp &&
          message == other.message;

  @override
  int get hashCode => runtimeType.hashCode;
}
