import 'package:injectable/injectable.dart';

import '../iden3core/iden3core.dart';
import 'hash.dart';

enum NodeType {
  middle,
  leaf,
  empty,
}

/// FIXME: mix of object and DS
@injectable
class Node {
  NodeType type;
  Iden3CoreLib _iden3coreLib;
  Hash? childL; // left child of a middle node.
  Hash? childR; // right child of a middle node.

  List<Hash>? entry; // data stored in a leaf node

  Hash? _key; // cache for calculated key

  Node(this.type, this._iden3coreLib);

  Node.leaf(Iden3CoreLib lib, Hash k, Hash v)
      : _iden3coreLib = lib,
        type = NodeType.leaf {
    entry = List<Hash>.from([k, v]);
  }

  Node.middle(Iden3CoreLib lib, this.childL, this.childR)
      : _iden3coreLib = lib,
        type = NodeType.middle;

  Node.empty(Iden3CoreLib lib)
      : _iden3coreLib = lib,
        type = NodeType.empty;

  Hash get key {
    if (_key == null) {
      switch (type) {
        case NodeType.leaf:
          _key = _iden3coreLib.poseidonHashHashes(
              [entry![0], entry![1], Hash.fromBigInt(BigInt.one)]);
          break;
        case NodeType.middle:
          _key = _iden3coreLib.poseidonHashHashes([childL!, childR!]);
          break;
        default:
          _key = Hash.zero();
      }
    }
    return _key!;
  }

  @override
  String toString() {
    switch (type) {
      case NodeType.leaf:
        return "leaf(${entry![0]}, ${entry![1]}) => $key";
      case NodeType.middle:
        return "middle($childL, $childR) => $key";
      default:
        return "empty";
    }
  }
}
