enum Iden3MessageType {
  unknown,
  authRequest,
  authResponse,
  credentialOffer,
  onchainCredentialOffer,
  credentialIssuanceResponse,
  proofContractInvokeRequest,
  credentialRefresh,
  credentialProposalRequest,
  credentialStatusUpdate;
}

/// Represents an iden3 message.
abstract class Iden3MessageEntity<T> {
  final String id;
  final String typ;
  final String type;
  final Iden3MessageType messageType;
  final String thid;
  final T body;
  final String from;
  final String? to;
  final Map<String, dynamic>? nextRequest;

  const Iden3MessageEntity({
    required this.id,
    required this.typ,
    required this.type,
    this.messageType = Iden3MessageType.unknown,
    required this.thid,
    required this.from,
    this.to,
    this.nextRequest,
    required this.body,
  });

  @override
  String toString() =>
      "[Iden3MessageEntity] {id: $id, typ: $typ, type: $type, messageType: $messageType, thid: $thid, body: $body, from: $from, to: $to, nextRequest: $nextRequest}";

  @override
  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'typ': typ,
        'type': type,
        'messageType': messageType.name,
        'thid': thid,
        'body': (body as dynamic).toJson(),
        'from': from,
        'to': to,
        'nextRequest': nextRequest,
      }
        ..removeWhere(
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
              to == other.to &&
              nextRequest == other.nextRequest;

  @override
  int get hashCode => runtimeType.hashCode;
}
