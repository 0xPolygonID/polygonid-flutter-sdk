import 'package:polygonid_flutter_sdk/proof/domain/entities/mtproof_entity.dart';

class GistMTProofEntity {
  final String root;
  final MTProofEntity proof;

  GistMTProofEntity({required this.root, required this.proof});

  @override
  String toString() => "[GistMTProofEntity] {root: $root, proof: $proof}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GistMTProofEntity &&
          runtimeType == other.runtimeType &&
          root.toString() == other.root.toString() &&
          proof.toString() == other.proof.toString();

  @override
  int get hashCode => runtimeType.hashCode;
}
