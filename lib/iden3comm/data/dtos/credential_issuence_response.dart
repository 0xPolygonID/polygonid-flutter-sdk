class CredentialIssuance {
  final String? id;
  final String? typ;
  final String? type;
  final String? thid;
  final CredentialIssuanceBodyRequest? body;
  final String? from;

  CredentialIssuance(
      {this.id, this.typ, this.type, this.thid, this.body, this.from});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [CredentialIssuance]
  factory CredentialIssuance.fromJson(Map<String, dynamic> json) {
    CredentialIssuanceBodyRequest body =
        CredentialIssuanceBodyRequest.fromJson(json['body']);
    return CredentialIssuance(
      id: json['id'],
      typ: json['typ'],
      type: json['type'],
      thid: json['thid'],
      from: json['from'],
      body: body,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'typ': typ,
        'type': type,
        'thid': thid,
        'from': from,
        'body': body!.toJson(),
      };
}

class CredentialIssuanceBodyRequest {
  final Map<String, dynamic> credential;

  CredentialIssuanceBodyRequest({required this.credential});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [CredentialIssuance]
  factory CredentialIssuanceBodyRequest.fromJson(Map<String, dynamic> json) {
    return CredentialIssuanceBodyRequest(
      credential: json['credential'],
    );
  }

  Map<String, dynamic> toJson() => {
        'credential': credential,
      };
}
