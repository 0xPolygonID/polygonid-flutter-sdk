class IdDescription {
  final String id;
  final String idAsInt;
  final String did;

  IdDescription({
    required this.id,
    required this.idAsInt,
    required this.did,
  });

  factory IdDescription.fromJson(Map<String, dynamic> json) {
    return IdDescription(
      id: json['id'],
      idAsInt: json['idAsInt'],
      did: json['did'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idAsInt': idAsInt,
      'did': did,
    };
  }
}
