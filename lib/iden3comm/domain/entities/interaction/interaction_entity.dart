enum InteractionType {
  connection,
  notification,
}

abstract class InteractionEntity {
  final int? id;
  final String from;
  final String genesisDid;
  final BigInt profileNonce;
  final InteractionType type;

  InteractionEntity({
    this.id,
    required this.from,
    required this.genesisDid,
    required this.profileNonce,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'from': from,
        'genesisDid': genesisDid,
        'profileNonce': profileNonce.toString(),
        'type': type.toString(),
      };

  @override
  String toString() =>
      "[InteractionEntity] {id: $id, from: $from, genesisDid: $genesisDid, profileNonce: $profileNonce, type: $type}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InteractionEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          from == other.from &&
          genesisDid == other.genesisDid &&
          profileNonce == other.profileNonce &&
          type == other.type;

  @override
  int get hashCode => runtimeType.hashCode;
}
