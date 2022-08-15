import 'dart:ffi';
import 'dart:typed_data';

import 'package:convert/convert.dart' as convert;
import 'package:ffi/ffi.dart';

import '../../../libs/generated_bindings.dart' as bindings;

final _q = BigInt.parse(
    "21888242871839275222246405745257275088548364400416034343698204186575808495617");

class Hash {
  final Uint8List _data;

  Hash.zero() : _data = Uint8List(32);

  Hash.fromUint8List(this._data) {
    assert(_data.length == 32);
  }

  Hash.fromBigInt(BigInt i) : _data = Uint8List(32) {
    if (i < BigInt.from(0)) {
      throw ArgumentError("BigInt must be positive");
    }

    if (i >= _q) {
      throw ArgumentError("BigInt must be less than $_q");
    }

    int bytes = (i.bitLength + 7) >> 3;
    final b = BigInt.from(256);
    for (int j = 0; j < bytes; j++) {
      _data[j] = i.remainder(b).toInt();
      i = i >> 8;
    }
  }

  Hash.fromHex(String h) : _data = Uint8List(32) {
    if (h.length != 64) {
      throw ArgumentError("Hex string must be 64 characters long");
    }
    convert.hex.decode(h).asMap().forEach((i, b) {
      _data[i] = b;
    });
  }

  @override
  String toString() {
    return convert.hex.encode(_data);
  }

  BigInt toBigInt() {
    final b = BigInt.from(256);
    BigInt i = BigInt.from(0);
    for (int j = _data.length - 1; j >= 0; j--) {
      i = i * b + BigInt.from(_data[j]);
    }
    return i;
  }

  bool testBit(int n) {
    if (n < 0 || n >= _data.length * 8) {
      throw ArgumentError("n must be in range [0, ${_data.length * 8}]");
    }
    return _data[n ~/ 8] & (1 << (n % 8)) != 0;
  }

  @override
  bool operator ==(Object other) {
    if (other is Hash) {
      for (int i = 0; i < _data.length; i++) {
        if (_data[i] != other._data[i]) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  @override
  int get hashCode => Object.hashAll(_data);
}

enum NodeType {
  middle,
  leaf,
  empty,
}

class Node {
  NodeType _type;
  Hash? childL; // left child of a middle node.
  Hash? childR; // right child of a middle node.

  List<Hash>? entry; // data stored in a leaf node

  Hash? _key; // cache for calculated key

  Node(this._type);

  Node.leaf(Hash k, Hash v) : _type = NodeType.leaf {
    entry = List<Hash>.from([k, v]);
  }

  Node.middle(this.childL, this.childR) : _type = NodeType.middle;

  Node.empty() : _type = NodeType.empty;

  Hash get key {
    if (_key == null) {
      switch (_type) {
        case NodeType.leaf:
          _key = poseidonHashHashes(
              [entry![0], entry![1], Hash.fromBigInt(BigInt.one)]);
          break;
        case NodeType.middle:
          _key = poseidonHashHashes([childL!, childR!]);
          break;
        default:
          _key = Hash.zero();
      }
    }
    return _key!;
  }

  @override
  String toString() {
    switch (_type) {
      case NodeType.leaf:
        return "leaf(${entry![0]}, ${entry![1]}) => $key";
      case NodeType.middle:
        return "middle($childL, $childR) => $key";
      default:
        return "empty";
    }
  }
}

class Proof {
  bool existence;
  List<Hash> siblings;
  Node? nodeAux;

  Proof(this.existence, this.siblings, this.nodeAux);

  Hash root(Node n) {
    assert(n._type == NodeType.leaf);
    Hash midKey;
    if (existence) {
      midKey = n.key;
    } else {
      if (nodeAux == null) {
        midKey = Hash.zero();
      } else {
        assert(nodeAux!._type == NodeType.leaf);
        if (n.entry![0] == nodeAux!.entry![0]) {
          throw Exception(
              "Non-existence proof being checked against hIndex equal to nodeAux");
        }
        midKey = nodeAux!.key;
      }
    }

    final path = _getPath(siblings.length, n.entry![0]);

    for (int lvl = siblings.length - 1; lvl >= 0; lvl--) {
      if (path[lvl]) {
        midKey = Node.middle(siblings[lvl], midKey).key;
      } else {
        midKey = Node.middle(midKey, siblings[lvl]).key;
      }
    }

    return midKey;
  }

  bool verify(Hash treeRoot, Node node) {
    final proofTreeRoot = root(node);
    return proofTreeRoot == treeRoot;
  }
}

class NotFound implements Exception {}

class NodeKeyAlreadyExists implements Exception {}

class EntryIndexAlreadyExists implements Exception {}

class ReachedMaxLevel implements Exception {}

class InvalidNodeFound implements Exception {}

class KeyNotFound implements Exception {}

abstract class Storage {
  Node get(Hash k);
  void put(Hash k, Node n);
  Hash getRoot();
  void setRoot(Hash r);
}

class MemoryStorage implements Storage {
  final Map<Hash, Node> _data = <Hash, Node>{};
  Hash? _root;

  @override
  Node get(Hash k) {
    final n = _data[k];
    // print("get $k => $n");
    if (n == null) {
      throw NotFound();
    }
    return n;
  }

  @override
  put(Hash k, Node n) {
    // print("put $k $n");
    _data[k] = n;
  }

  @override
  Hash getRoot() {
    if (_root == null) {
      return Hash.zero();
    }
    return _root!;
  }

  @override
  void setRoot(Hash r) {
    _root = r;
  }
}

class MerkleTree {
  Hash root;
  int maxLevels;
  Storage storage;

  MerkleTree(this.storage, this.maxLevels) : root = storage.getRoot();

  void add(BigInt k, BigInt v) {
    final kHash = Hash.fromBigInt(k);
    final vHash = Hash.fromBigInt(v);
    final newNodeLeaf = Node.leaf(kHash, vHash);
    final path = _getPath(maxLevels, kHash);
    root = _addLeaf(newNodeLeaf, root, 0, path);
    storage.setRoot(root);
  }

  Hash _addLeaf(Node newLeaf, Hash key, int lvl, List<bool> path) {
    if (lvl > maxLevels - 1) {
      throw ArgumentError("lvl must be less than maxLevels");
    }
    // print("add leaf under key $key at level $lvl");
    final n = getNode(key);
    switch (n._type) {
      case NodeType.empty:
        return _addNode(newLeaf);
      case NodeType.leaf:
        final nKey = n.entry![0];
        // Check if leaf node found contains the leaf node we are
        // trying to add
        final newLeafKey = newLeaf.entry![0];
        if (newLeafKey == nKey) {
          throw EntryIndexAlreadyExists();
        }
        final pathOldLeaf = _getPath(maxLevels, nKey);
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
          newNodeMiddle = Node.middle(n.childL!, nextKey);
        } else {
          // go left
          final nextKey = _addLeaf(newLeaf, n.childL!, lvl + 1, path);
          newNodeMiddle = Node.middle(nextKey, n.childR!);
        }
        return _addNode(newNodeMiddle);
      default:
        throw InvalidNodeFound();
    }
  }

  Hash _addNode(Node n) {
    // print("add node $n");

    final k = n.key;
    if (n._type == NodeType.empty) {
      return k;
    }

    bool nodeFound = true;
    try {
      storage.get(k);
    } on NotFound {
      nodeFound = false;
    }

    if (nodeFound) {
      throw NodeKeyAlreadyExists();
    }

    storage.put(k, n);
    return k;
  }

  Node getNode(Hash key) {
    // print("get node key: $key");
    if (key == Hash.zero()) {
      return Node.empty();
    }
    return storage.get(key);
  }

  // pushLeaf recursively pushes an existing oldLeaf down until its path diverges
  // from newLeaf, at which point both leafs are stored, all while updating the
  // path.
  Hash _pushLeaf(Node newLeaf, Node oldLeaf, int lvl, List<bool> pathNewLeaf,
      List<bool> pathOldLeaf) {
    if (lvl > maxLevels - 2) {
      throw ReachedMaxLevel();
    }

    if (pathNewLeaf[lvl] == pathOldLeaf[lvl]) {
      // We need to go deeper!
      final nextKey =
          _pushLeaf(newLeaf, oldLeaf, lvl + 1, pathNewLeaf, pathOldLeaf);
      late final Node newNodeMiddle;
      if (pathNewLeaf[lvl]) {
        // go right
        newNodeMiddle = Node.middle(Hash.zero(), nextKey);
      } else {
        // go left
        newNodeMiddle = Node.middle(nextKey, Hash.zero());
      }
      return _addNode(newNodeMiddle);
    }

    final oldLeafKey = oldLeaf.key;
    final newLeafKey = newLeaf.key;
    late final Node newNodeMiddle;
    if (pathNewLeaf[lvl]) {
      newNodeMiddle = Node.middle(oldLeafKey, newLeafKey);
    } else {
      newNodeMiddle = Node.middle(newLeafKey, oldLeafKey);
    }

    _addNode(newLeaf);
    return _addNode(newNodeMiddle);
  }

  Proof generateProof(Hash key) {
    final path = _getPath(maxLevels, key);
    var siblings = <Hash>[];
    var nextKey = root;
    for (int depth = 0; depth < maxLevels; depth++) {
      final n = getNode(nextKey);
      switch (n._type) {
        case NodeType.empty:
          return Proof(false, siblings, null);
        case NodeType.leaf:
          if (n.entry![0] == key) {
            return Proof(true, siblings, null);
          }
          // We found a leaf whose entry didn't match key
          return Proof(false, siblings, n);
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
          throw InvalidNodeFound();
      }
    }
    throw KeyNotFound();
  }
}

List<bool> _getPath(int numLevel, Hash h) {
  final path = List<bool>.filled(numLevel, false);
  for (int i = 0; i < numLevel; i++) {
    path[i] = h.testBit(i);
  }
  return path;
}

final dylibPath = '/Users/alek/src/go-iden3-core-clib/ios/libiden3core.dylib';
final iden3lib = bindings.NativeLibrary(DynamicLibrary.open(dylibPath));

Hash poseidonHashHashes(List<Hash> hs) {
  if (hs.isEmpty) {
    return Hash.zero();
  }

  Pointer<Pointer<bindings.IDENBigInt>> ints =
      malloc<Pointer<bindings.IDENBigInt>>(hs.length);
  for (int i = 0; i < hs.length; i++) {
    ints[i] = nullptr;
  }

  Pointer<Pointer<bindings.IDENBigInt>> hash =
      malloc<Pointer<bindings.IDENBigInt>>();
  hash.value = nullptr;

  try {
    for (int i = 0; i < hs.length; i++) {
      final intACStr = hs[i].toBigInt().toRadixString(10).toNativeUtf8();
      try {
        int ok = iden3lib.IDENBigIntFromString(
            ints.elementAt(i), intACStr.cast(), nullptr);
        if (ok != 1) {
          throw Exception("can't create IDENBigInt from int");
        }
      } finally {
        malloc.free(intACStr);
      }
    }

    int ok = iden3lib.IDENHashInts(hash, hs.length, ints, nullptr);
    if (ok != 1) {
      throw Exception("can't calc hash of ints");
    }

    return hashFromIdenBigInt(hash.value);
  } finally {
    for (int i = 0; i < hs.length; i++) {
      iden3lib.IDENFreeBigInt(ints[i]);
    }
    iden3lib.IDENFreeBigInt(hash.value);
  }
}

BigInt poseidonHashInts(List<BigInt> bis) {
  if (bis.isEmpty) {
    return BigInt.zero;
  }

  Pointer<Pointer<bindings.IDENBigInt>> ints =
      malloc<Pointer<bindings.IDENBigInt>>(bis.length);
  for (int i = 0; i < bis.length; i++) {
    ints[i] = nullptr;
  }

  Pointer<Pointer<bindings.IDENBigInt>> hash =
      malloc<Pointer<bindings.IDENBigInt>>();
  hash.value = nullptr;

  try {
    for (int i = 0; i < bis.length; i++) {
      final intACStr = bis[i].toRadixString(10).toNativeUtf8();
      try {
        int ok = iden3lib.IDENBigIntFromString(
            ints.elementAt(i), intACStr.cast(), nullptr);
        if (ok != 1) {
          throw Exception("can't create IDENBigInt from int");
        }
      } finally {
        malloc.free(intACStr);
      }
    }

    int ok = iden3lib.IDENHashInts(hash, bis.length, ints, nullptr);
    if (ok != 1) {
      throw Exception("can't calc hash of ints");
    }

    return bigIntFromIdenBigInt(hash.value);
  } finally {
    for (int i = 0; i < bis.length; i++) {
      iden3lib.IDENFreeBigInt(ints[i]);
    }
    iden3lib.IDENFreeBigInt(hash.value);
  }
}

Hash hashFromIdenBigInt(Pointer<bindings.IDENBigInt> v) {
  if (v.ref.data_len == 0) {
    return Hash.zero();
  }
  if (v.ref.data_len > 32) {
    throw ArgumentError("value is too big");
  }

  final h = Hash.zero();
  for (int i = 0; i < v.ref.data_len; i++) {
    h._data[i] = v.ref.data[i];
  }

  return h;
}

BigInt bigIntFromIdenBigInt(Pointer<bindings.IDENBigInt> v) {
  if (v.ref.data_len == 0) {
    return BigInt.zero;
  }

  final b = BigInt.from(256);
  BigInt i = BigInt.from(0);
  for (int j = v.ref.data_len - 1; j >= 0; j--) {
    i = i * b + BigInt.from(v.ref.data[j]);
  }
  return i;
}
