import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';

class ProofRequestEntity {
  final ZeroKnowledgeProofRequest scope;
  final Map<String, dynamic> context;

  bool get isOptional => scope.isOptional;

  ProofRequestEntity(this.scope, this.context);

  @override
  String toString() =>
      "[ProofRequestEntity] {scope: $scope, context: $context}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProofRequestEntity &&
          runtimeType == other.runtimeType &&
          scope == other.scope &&
          context == other.context;

  @override
  int get hashCode => runtimeType.hashCode;
}
