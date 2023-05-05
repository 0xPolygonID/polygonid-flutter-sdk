import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_state_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/proof_entity.dart';

class RevStatusEntity {
  final TreeStateEntity issuer;
  final ProofEntity mtp;

  RevStatusEntity({
    required this.issuer,
    required this.mtp,
  });

  @override
  String toString() => "[RevStatusEntity] {issuer: $issuer, mtp: $mtp}";

  @override
  Map<String, dynamic> toJson() => {
        'issuer': issuer.toJson(),
        'mtp': mtp.toJson(),
      }..removeWhere(
          (dynamic key, dynamic value) => key == null || value == null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RevStatusEntity &&
          runtimeType == other.runtimeType &&
          issuer == other.issuer &&
          mtp == other.mtp;

  @override
  int get hashCode => runtimeType.hashCode;
}
