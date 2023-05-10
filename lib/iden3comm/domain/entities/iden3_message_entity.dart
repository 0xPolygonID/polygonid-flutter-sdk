enum Iden3MessageType { unknown, auth, offer, issuance, contractFunctionCall }

/// Represents an iden3 message.
abstract class Iden3MessageEntity {
  final String id;
  final String typ;
  final String type;
  final Iden3MessageType messageType;
  final String thid;
  abstract final body;
  final String from;
  final String? to;

  const Iden3MessageEntity(
      {required this.id,
      required this.typ,
      required this.type,
      this.messageType = Iden3MessageType.unknown,
      required this.thid,
      required this.from,
      this.to});

  @override
  String toString() =>
      "[Iden3MessageEntity] {id: $id, typ: $typ, type: $type, messageType: $messageType, thid: $thid, body: $body, from: $from, to: $to}";

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'typ': typ,
        'type': type,
        'messageType': messageType.name,
        'thid': thid,
        'body': body.toJson(),
        'from': from,
        'to': to,
      }..removeWhere(
          (dynamic key, dynamic value) => key == null || value == null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Iden3MessageEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          typ == other.typ &&
          type == other.type &&
          messageType == other.messageType &&
          thid == other.thid &&
          body == other.body &&
          from == other.from &&
          to == other.to;

  @override
  int get hashCode => runtimeType.hashCode;
}
