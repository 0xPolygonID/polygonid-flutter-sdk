import 'package:injectable/injectable.dart';

import '../../domain/exceptions/smt_exceptions.dart';
import '../../domain/repositories/smt_storage_repository.dart';
import '../iden3core/iden3core.dart';
import 'hash.dart';
import 'node.dart';
import 'proof.dart';
import 'smt_utils.dart';

@injectable
class MerkleTree {
  Iden3CoreLib _iden3coreLib;
  Hash root;
  int maxLevels;
  SMTStorageRepository storage;

  MerkleTree(this._iden3coreLib, this.storage, this.maxLevels)
      : root = storage.getRoot();

  void add(BigInt k, BigInt v) {
    final kHash = Hash.fromBigInt(k);
    final vHash = Hash.fromBigInt(v);
    final newNodeLeaf = Node.leaf(_iden3coreLib, kHash, vHash);
    final path = SMTUtils.getPath(maxLevels, kHash);
    root = _addLeaf(newNodeLeaf, root, 0, path);
    storage.setRoot(root);
  }

  Hash _addLeaf(Node newLeaf, Hash key, int lvl, List<bool> path) {
    if (lvl > maxLevels - 1) {
      throw ArgumentError("lvl must be less than maxLevels");
    }
    // print("add leaf under key $key at level $lvl");
    final n = getNode(key);
    switch (n.type) {
      case NodeType.empty:
        return _addNode(newLeaf);
      case NodeType.leaf:
        final nKey = n.entry![0];
        // Check if leaf node found contains the leaf node we are
        // trying to add
        final newLeafKey = newLeaf.entry![0];
        if (newLeafKey == nKey) {
          throw SMTEntryIndexAlreadyExists();
        }
        final pathOldLeaf = SMTUtils.getPath(maxLevels, nKey);
        // We need to push newLeaf down until its path diverges from
        // n's path
        return _pushLeaf(newLeaf, n, lvl, path, pathOldLeaf);
      case NodeType.middle:
        // We need to go deeper, continue traversing the tree, left or
        // right depending on path
        late final Node newNodeMiddle;
        if (path[lvl]) {
          // go right
          final nextKey = _addLeaf(newLeaf, n.childR!, lvl + 1, path);
          newNodeMiddle = Node.middle(_iden3coreLib, n.childL!, nextKey);
        } else {
          // go left
          final nextKey = _addLeaf(newLeaf, n.childL!, lvl + 1, path);
          newNodeMiddle = Node.middle(_iden3coreLib, nextKey, n.childR!);
        }
        return _addNode(newNodeMiddle);
      default:
        throw SMTInvalidNodeFound();
    }
  }

  Hash _addNode(Node n) {
    // print("add node $n");

    final k = n.key;
    if (n.type == NodeType.empty) {
      return k;
    }

    bool nodeFound = true;
    try {
      storage.get(k);
    } on SMTNotFound {
      nodeFound = false;
    }

    if (nodeFound) {
      throw SMTNodeKeyAlreadyExists();
    }

    storage.put(k, n);
    return k;
  }

  Node getNode(Hash key) {
    // print("get node key: $key");
    if (key == Hash.zero()) {
      return Node.empty(_iden3coreLib);
    }
    return storage.get(key);
  }

  // pushLeaf recursively pushes an existing oldLeaf down until its path diverges
  // from newLeaf, at which point both leafs are stored, all while updating the
  // path.
  Hash _pushLeaf(Node newLeaf, Node oldLeaf, int lvl, List<bool> pathNewLeaf,
      List<bool> pathOldLeaf) {
    if (lvl > maxLevels - 2) {
      throw SMTReachedMaxLevel();
    }

    if (pathNewLeaf[lvl] == pathOldLeaf[lvl]) {
      // We need to go deeper!
      final nextKey =
          _pushLeaf(newLeaf, oldLeaf, lvl + 1, pathNewLeaf, pathOldLeaf);
      late final Node newNodeMiddle;
      if (pathNewLeaf[lvl]) {
        // go right
        newNodeMiddle = Node.middle(_iden3coreLib, Hash.zero(), nextKey);
      } else {
        // go left
        newNodeMiddle = Node.middle(_iden3coreLib, nextKey, Hash.zero());
      }
      return _addNode(newNodeMiddle);
    }

    final oldLeafKey = oldLeaf.key;
    final newLeafKey = newLeaf.key;
    late final Node newNodeMiddle;
    if (pathNewLeaf[lvl]) {
      newNodeMiddle = Node.middle(_iden3coreLib, oldLeafKey, newLeafKey);
    } else {
      newNodeMiddle = Node.middle(_iden3coreLib, newLeafKey, oldLeafKey);
    }

    _addNode(newLeaf);
    return _addNode(newNodeMiddle);
  }

  Proof generateProof(Hash key) {
    final path = SMTUtils.getPath(maxLevels, key);
    var siblings = <Hash>[];
    var nextKey = root;
    for (int depth = 0; depth < maxLevels; depth++) {
      final n = getNode(nextKey);
      switch (n.type) {
        case NodeType.empty:
          return Proof(_iden3coreLib, false, siblings, null);
        case NodeType.leaf:
          if (n.entry![0] == key) {
            return Proof(_iden3coreLib, true, siblings, null);
          }
          // We found a leaf whose entry didn't match key
          return Proof(_iden3coreLib, false, siblings, n);
        case NodeType.middle:
          if (path[depth]) {
            nextKey = n.childR!;
            siblings.add(n.childL!);
          } else {
            nextKey = n.childL!;
            siblings.add(n.childR!);
          }
          continue;
        default:
          throw SMTInvalidNodeFound();
      }
    }
    throw SMTKeyNotFound();
  }
}
