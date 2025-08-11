import 'package:polygonid_flutter_sdk/common/utils/collection_utils.dart';

@Deprecated('Use CredentialOffer instead')
typedef CredentialOfferData = CredentialOffer;

class CredentialOffer {
  final String id;
  final String? description;
  final CredentialOfferStatus? status;

  CredentialOffer({
    required this.id,
    this.description,
    this.status,
  });

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [CredentialOffer]
  factory CredentialOffer.fromJson(Map<String, dynamic> json) {
    return CredentialOffer(
      id: json['id'],
      description: json['description'],
      status: CredentialOfferStatus.values
          .firstWhereOrNull((e) => json['status'] == e.name),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        if (status != null) 'status': status?.name,
      };

  @override
  String toString() =>
      "[CredentialOffer] {id: $id, description: $description, status: $status}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CredentialOffer &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          description == other.description &&
          status == other.status;

  @override
  int get hashCode => runtimeType.hashCode;

  bool get isPending => status == CredentialOfferStatus.pending;

  bool get isCompleted =>
      status == null || status == CredentialOfferStatus.completed;

  bool get isRejected => status == CredentialOfferStatus.rejected;
}

enum CredentialOfferStatus {
  pending('pending'),
  completed('completed'),
  rejected('rejected');

  final String name;

  const CredentialOfferStatus(this.name);
}
