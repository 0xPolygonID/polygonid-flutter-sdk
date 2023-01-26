import 'hash_entity.dart';

/// 3 types of nodes:
///
/// - State node: [Claims Tree root, Revocation Tree root, Roots Tree root]
/// - Middle node: [leftNode, rightNode]
/// - Leaf node: [key, value, 1]
enum NodeType { unknown, state, middle, leaf }

class NodeEntity {
  final HashEntity hash;
  final List<HashEntity> children;
  final NodeType nodeType;

  NodeEntity(
      {required this.hash, required this.children, required this.nodeType});

  @override
  String toString() =>
      "[NodeEntity] {hash: $hash, children: $children, nodeType: $nodeType}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NodeEntity &&
          runtimeType == other.runtimeType &&
          hash.toString() == other.hash.toString() &&
          children.toString() == other.children.toString() &&
          nodeType == other.nodeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
