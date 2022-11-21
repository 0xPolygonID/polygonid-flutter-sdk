enum Iden3MessageType { unknown, auth, offer, issuance, contractFunctionCall }

/// Represents an iden3 message.
class Iden3MessageEntity {
  final String id;
  final String typ;
  final Iden3MessageType type;
  final String thid;
  final Map<String, dynamic> body;
  final String from;
  final String? to;

  const Iden3MessageEntity(
      {required this.id,
      required this.typ,
      this.type = Iden3MessageType.unknown,
      required this.thid,
      required this.body,
      required this.from,
      this.to});

  @override
  String toString() =>
      "[Iden3MessageEntity] {id: $id, typ: $typ, type: $type, thid: $thid, body: $body, from: $from, to: $to}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Iden3MessageEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          typ == other.typ &&
          type == other.type &&
          thid == other.thid &&
          body == other.body &&
          from == other.from &&
          to == other.to;

  @override
  int get hashCode => runtimeType.hashCode;
}
