///The RHS stores 3 types of nodes:
///
/// - State node: [Claims Tree root, Revocation Tree root, Roots Tree root]
///- Middle node: [leftNode, rightNode]
/// - Leaf node: [key, value, 1]
enum RhsNodeType {
  leaf,
  middle,
  state,
  unknown,
}

class RhsNodeEntity {
  final Map<String, dynamic> node;
  final String status;
  final RhsNodeType nodeType;

  RhsNodeEntity({
    required this.node,
    required this.status,
    required this.nodeType,
  });

  @override
  String toString() =>
      "[RhsNodeEntity] {node: $node, status: $status, nodeType: $nodeType}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RhsNodeEntity &&
          runtimeType == other.runtimeType &&
          node.toString() == other.node.toString() &&
          status == other.status &&
          nodeType == other.nodeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
