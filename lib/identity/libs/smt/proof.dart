/*class Proof {
  Iden3CoreLib _iden3coreLib;
  bool existence;
  List<Hash> siblings;
  Node? nodeAux;

  Proof(this._iden3coreLib, this.existence, this.siblings, this.nodeAux);

  Hash root(Node n) {
    assert(n.type == NodeType.leaf);
    Hash midKey;
    if (existence) {
      midKey = n.key;
    } else {
      if (nodeAux == null) {
        midKey = Hash.zero();
      } else {
        assert(nodeAux!.type == NodeType.leaf);
        if (n.entry![0] == nodeAux!.entry![0]) {
          throw Exception(
              "Non-existence proof being checked against hIndex equal to nodeAux");
        }
        midKey = nodeAux!.key;
      }
    }

    final path = SMTUtils.getPath(siblings.length, n.entry![0]);

    for (int lvl = siblings.length - 1; lvl >= 0; lvl--) {
      if (path[lvl]) {
        midKey = Node.middle(_iden3coreLib, siblings[lvl], midKey).key;
      } else {
        midKey = Node.middle(_iden3coreLib, midKey, siblings[lvl]).key;
      }
    }

    return midKey;
  }

  bool verify(Hash treeRoot, Node node) {
    final proofTreeRoot = root(node);
    return proofTreeRoot == treeRoot;
  }
}*/
