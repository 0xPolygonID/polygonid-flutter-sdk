enum InteractionType {
  connection,
  notification,
}

abstract class InteractionEntity {
  final int? id;
  final String from;
  final String to;
  final InteractionType type;

  InteractionEntity(
      {this.id, required this.from, required this.to, required this.type});

  Map<String, dynamic> toJson() => {
        'id': id,
        'from': from,
        'to': to,
        'type': type.toString(),
      };

  @override
  String toString() =>
      "[InteractionEntity] {id: $id, from: $from, to: $to, type: $type}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InteractionEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          from == other.from &&
          to == other.to &&
          type == other.type;

  @override
  int get hashCode => runtimeType.hashCode;
}
