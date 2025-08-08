@Deprecated('Use CredentialFetchRequestBody instead')
typedef FetchBodyRequest = CredentialFetchRequestBody;

class CredentialFetchRequestBody {
  final String id;

  CredentialFetchRequestBody({required this.id});

  factory CredentialFetchRequestBody.fromJson(Map<String, dynamic> json) {
    return CredentialFetchRequestBody(
      id: json['id'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
      };

  @override
  String toString() => "[CredentialFetchRequestBody] {id: $id}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CredentialFetchRequestBody &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => runtimeType.hashCode;
}
