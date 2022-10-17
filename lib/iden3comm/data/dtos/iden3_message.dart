class Iden3Message {
  final String? id;
  final String? typ;
  final String? type;
  final String? thid;
  final Map<String, dynamic>? body;
  final String? from;
  final String? to;

  Iden3Message(
      {this.id, this.typ, this.type, this.thid, this.body, this.from, this.to});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [Iden3Message]
  factory Iden3Message.fromJson(Map<String, dynamic> json) {
    return Iden3Message(
      id: json['id'],
      typ: json['typ'],
      type: json['type'],
      thid: json['thid'],
      from: json['from'],
      to: json['to'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'typ': typ,
        'type': type,
        'thid': thid,
        'from': from,
        'to': to,
        'body': body,
      };
}
