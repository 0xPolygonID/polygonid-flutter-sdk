class CredentialOfferData {
  final String id;
  final String? description;

  CredentialOfferData({required this.id, this.description});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [CredentialOfferData]
  factory CredentialOfferData.fromJson(Map<String, dynamic> json) {
    return CredentialOfferData(
      id: json['id'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'description': description,
  };

  @override
  String toString() =>
      "[CredentialOfferData] {id: $id, description: $description}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CredentialOfferData &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              description == other.description;

  @override
  int get hashCode => runtimeType.hashCode;
}