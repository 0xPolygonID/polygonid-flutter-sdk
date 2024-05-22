import 'package:polygonid_flutter_sdk/common/utils/collection_utils.dart';

class CredentialOfferData {
  final String id;
  final String? description;
  final CredentialOfferStatus? status;

  CredentialOfferData({
    required this.id,
    this.description,
    this.status,
  });

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [CredentialOfferData]
  factory CredentialOfferData.fromJson(Map<String, dynamic> json) {
    return CredentialOfferData(
      id: json['id'],
      description: json['description'],
      status: CredentialOfferStatus.values
          .firstWhereOrNull((e) => json['status'] == e.name),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'status': status?.name,
      };

  @override
  String toString() =>
      "[CredentialOfferData] {id: $id, description: $description, status: $status}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CredentialOfferData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          description == other.description &&
          status == other.status;

  @override
  int get hashCode => runtimeType.hashCode;

  bool get isPending => status == CredentialOfferStatus.pending;

  bool get isCompleted => status == CredentialOfferStatus.completed;

  bool get isRejected => status == CredentialOfferStatus.rejected;
}

enum CredentialOfferStatus {
  pending('pending'),
  completed('completed'),
  rejected('rejected');

  final String name;

  const CredentialOfferStatus(this.name);
}
