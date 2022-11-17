import 'hash_entity.dart';

/// 3 types of nodes:
///
/// - State node: [Claims Tree root, Revocation Tree root, Roots Tree root]
/// - Middle node: [leftNode, rightNode]
/// - Leaf node: [key, value, 1]
enum NodeType { unknown, state, middle, leaf }

class NodeEntity {
  final List<HashEntity> children;
  final NodeType nodeType;

  NodeEntity({required this.children, required this.nodeType});

  @override
  String toString() =>
      "[NodeEntity] {children: $children, nodeType: $nodeType}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NodeEntity &&
          runtimeType == other.runtimeType &&
          children.toString() == other.children.toString() &&
          nodeType == other.nodeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
