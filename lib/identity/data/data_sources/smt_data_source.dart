import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_smt_data_source.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../proof/data/dtos/node_aux_dto.dart';
import '../../../proof/data/dtos/proof_dto.dart';
import '../../domain/exceptions/smt_exceptions.dart';
import '../dtos/hash_dto.dart';
import '../dtos/node_dto.dart';
import '../mappers/hex_mapper.dart';
import 'lib_babyjubjub_data_source.dart';

class SMTDataSource {
  final HexMapper _hexMapper;
  final LibBabyJubJubDataSource _libBabyjubjubDataSource;
  final StorageSMTDataSource _storageSMTDataSource;

  SMTDataSource(this._hexMapper, this._libBabyjubjubDataSource,
      this._storageSMTDataSource);

  Future<void> createSMT(
      {required int maxLevels,
      required String storeName,
      required String did,
      required String privateKey}) async {
    await _storageSMTDataSource
        .getRoot(storeName: storeName, did: did, privateKey: privateKey)
        .then((root) async => await _storageSMTDataSource.removeSMT(
            storeName: storeName, did: did, privateKey: privateKey))
        .catchError((error) {});
    await _storageSMTDataSource.setRoot(
        root: HashDTO.zero(),
        storeName: storeName,
        did: did,
        privateKey: privateKey);
    await _storageSMTDataSource.setMaxLevels(
        maxLevels: maxLevels,
        storeName: storeName,
        did: did,
        privateKey: privateKey);
  }

  Future<HashDTO> getRoot(
      {required String storeName,
      required String did,
      required String privateKey}) async {
    return _storageSMTDataSource.getRoot(
        storeName: storeName, did: did, privateKey: privateKey);
  }

  Future<HashDTO> addLeaf(
      {required NodeDTO newNodeLeaf,
      required String storeName,
      required String did,
      required String privateKey}) async {
    int maxLevels = await _storageSMTDataSource.getMaxLevels(
        storeName: storeName, did: did, privateKey: privateKey);
    final root = await _storageSMTDataSource.getRoot(
        storeName: storeName, did: did, privateKey: privateKey);
    final path = _getPath(maxLevels, newNodeLeaf.children[0]);
    final newRoot =
        await _addLeaf(newNodeLeaf, root, 0, path, storeName, did, privateKey);
    await _storageSMTDataSource.setRoot(
        root: newRoot, storeName: storeName, did: did, privateKey: privateKey);
    return newRoot;
  }

  Future<HashDTO> _addLeaf(NodeDTO newLeaf, HashDTO key, int level,
      List<bool> path, String storeName, String did, String privateKey) async {
    int maxLevels = await _storageSMTDataSource.getMaxLevels(
        storeName: storeName, did: did, privateKey: privateKey);
    if (level > maxLevels - 1) {
      throw ArgumentError("level must be less than maxLevels");
    }

    logger().i("add leaf under key ${key.data} at level $level");

    final node = await _storageSMTDataSource.getNode(
        key: key, storeName: storeName, did: did, privateKey: privateKey);
    switch (node.type) {
      case NodeTypeDTO.empty:
        return _addNode(newLeaf, storeName, did, privateKey);
      case NodeTypeDTO.leaf:
      case NodeTypeDTO.state: //???
        final nKey = node.children[0];
        // Check if leaf node found contains the leaf node we are
        // trying to add
        final newLeafKey = newLeaf.children[0];
        if (newLeafKey == nKey) {
          throw SMTEntryIndexAlreadyExistsException();
        }
        final pathOldLeaf = _getPath(maxLevels, nKey);
        // We need to push newLeaf down until its path diverges from
        // n's path
        return _pushLeaf(newLeaf, node, level, path, pathOldLeaf, storeName,
            did, privateKey);
      case NodeTypeDTO.middle:
        // We need to go deeper, continue traversing the tree, left or
        // right depending on path
        late final NodeDTO newNodeMiddle;
        if (path[level]) {
          // go right
          final nextKey = await _addLeaf(newLeaf, node.children[1], level + 1,
              path, storeName, did, privateKey);
          final newNodeChildren = [node.children[0], nextKey];
          final nodeHashData = await _libBabyjubjubDataSource.hashPoseidon2(
              node.children[0].toString(), nextKey.toString());
          final nodeHash = HashDTO.fromBigInt(BigInt.parse(nodeHashData));
          newNodeMiddle = NodeDTO(
              children: newNodeChildren,
              hash: nodeHash,
              type: NodeTypeDTO.middle);
        } else {
          // go left
          final nextKey = await _addLeaf(newLeaf, node.children[0], level + 1,
              path, storeName, did, privateKey);
          final newNodeChildren = [nextKey, node.children[1]];
          final nodeHashData = await _libBabyjubjubDataSource.hashPoseidon2(
              nextKey.toString(), node.children[1].toString());
          final nodeHash = HashDTO.fromBigInt(BigInt.parse(nodeHashData));
          newNodeMiddle = NodeDTO(
              children: newNodeChildren,
              hash: nodeHash,
              type: NodeTypeDTO.middle);
        }
        return _addNode(newNodeMiddle, storeName, did, privateKey);
      default:
        throw SMTInvalidNodeFoundException();
    }
  }

  Future<HashDTO> _addNode(
      NodeDTO node, String storeName, String did, String privateKey) async {
    // print("add node $n");

    final key = node.hash;
    if (node.type == NodeTypeDTO.empty) {
      return key;
    }

    //bool nodeFound = true;
    //try {
    bool nodeFound = await _storageSMTDataSource
        .getNode(
            key: key, storeName: storeName, did: did, privateKey: privateKey)
        .then((node) => node.type != NodeTypeDTO.empty)
        .catchError((error) => false);
    /*} on SMTNotFoundException {
      nodeFound = false;
    }*/

    if (nodeFound) {
      throw SMTNodeKeyAlreadyExistsException();
    }

    await _storageSMTDataSource.addNode(
        key: key,
        node: node,
        storeName: storeName,
        did: did,
        privateKey: privateKey);
    return key;
  }

  // pushLeaf recursively pushes an existing oldLeaf down until its path diverges
  // from newLeaf, at which point both leafs are stored, all while updating the
  // path.
  Future<HashDTO> _pushLeaf(
      NodeDTO newLeaf,
      NodeDTO oldLeaf,
      int level,
      List<bool> pathNewLeaf,
      List<bool> pathOldLeaf,
      String storeName,
      String did,
      String privateKey) async {
    int maxLevels = await _storageSMTDataSource.getMaxLevels(
        storeName: storeName, did: did, privateKey: privateKey);
    if (level > maxLevels - 2) {
      throw SMTReachedMaxLevelException();
    }

    if (pathNewLeaf[level] == pathOldLeaf[level]) {
      // We need to go deeper!
      final nextKey = await _pushLeaf(newLeaf, oldLeaf, level + 1, pathNewLeaf,
          pathOldLeaf, storeName, did, privateKey);
      late final List<HashDTO> newNodeChildren;
      if (pathNewLeaf[level]) {
        // go right
        newNodeChildren = [HashDTO.zero(), nextKey];
      } else {
        // go left
        newNodeChildren = [nextKey, HashDTO.zero()];
      }
      final nodeHashData = await _libBabyjubjubDataSource.hashPoseidon2(
          newNodeChildren[0].toString(), newNodeChildren[1].toString());
      final nodeHash = HashDTO.fromBigInt(BigInt.parse(nodeHashData));
      final NodeDTO newNodeMiddle = NodeDTO(
          children: newNodeChildren, hash: nodeHash, type: NodeTypeDTO.middle);
      return _addNode(newNodeMiddle, storeName, did, privateKey);
    }

    final oldLeafKey = oldLeaf.hash;
    final newLeafKey = newLeaf.hash;
    late final List<HashDTO> newNodeChildren;
    if (pathNewLeaf[level]) {
      newNodeChildren = [oldLeafKey, newLeafKey];
    } else {
      newNodeChildren = [newLeafKey, oldLeafKey];
    }
    final nodeHashData = await _libBabyjubjubDataSource.hashPoseidon2(
        newNodeChildren[0].toString(), newNodeChildren[1].toString());
    final nodeHash = HashDTO.fromBigInt(BigInt.parse(nodeHashData));
    final NodeDTO newNodeMiddle = NodeDTO(
        children: newNodeChildren, hash: nodeHash, type: NodeTypeDTO.middle);
    await _addNode(newLeaf, storeName, did, privateKey);
    return _addNode(newNodeMiddle, storeName, did, privateKey);
  }

  _getPath(int numLevel, HashDTO h) {
    final path = List<bool>.filled(numLevel, false);
    for (int i = 0; i < numLevel; i++) {
      path[i] = h.testBit(i);
    }
    return path;
  }

  Future<ProofDTO> generateProof(
      {required HashDTO key,
      required String storeName,
      required String did,
      required String privateKey}) async {
    int maxLevels = await _storageSMTDataSource.getMaxLevels(
        storeName: storeName, did: did, privateKey: privateKey);
    final path = _getPath(maxLevels, key);
    var siblings = <HashDTO>[];
    final root = await _storageSMTDataSource.getRoot(
        storeName: storeName, did: did, privateKey: privateKey);
    var nextKey = root;
    for (int depth = 0; depth < maxLevels; depth++) {
      final node = await _storageSMTDataSource.getNode(
          key: nextKey, storeName: storeName, did: did, privateKey: privateKey);

      switch (node.type) {
        case NodeTypeDTO.empty:
          return ProofDTO(existence: false, siblings: siblings);
        case NodeTypeDTO.leaf:
          if (node.children[0] == key) {
            return ProofDTO(existence: true, siblings: siblings);
          }
          // We found a leaf whose entry didn't match key
          return ProofDTO(
              existence: false,
              siblings: siblings,
              nodeAux: NodeAuxDTO(
                key: node.children[0].toString(),
                value: node.children[1].toString(),
              ));
        case NodeTypeDTO.middle:
          if (path[depth]) {
            nextKey = node.children[1];
            siblings.add(node.children[0]);
          } else {
            nextKey = node.children[0];
            siblings.add(node.children[1]);
          }
          continue;
        default:
          throw SMTInvalidNodeFoundException();
      }
    }
    throw SMTKeyNotFoundException();
  }

  Future<HashDTO> getProofTreeRoot(
      {required ProofDTO proof, required NodeDTO node}) async {
    assert(node.type == NodeTypeDTO.leaf);
    HashDTO midKey;
    if (proof.existence) {
      midKey = node.hash;
    } else {
      if (proof.nodeAux == null) {
        midKey = HashDTO.zero();
      } else {
        if (node.children[0] ==
            HashDTO.fromBigInt(BigInt.parse(proof.nodeAux!.key))) {
          throw Exception(
              "Non-existence proof being checked against hIndex equal to nodeAux");
        }
        midKey = HashDTO.fromBigInt(BigInt.parse(proof.nodeAux!.key));
      }
    }

    final path = _getPath(proof.siblings.length, node.children[0]);

    for (int level = proof.siblings.length - 1; level >= 0; level--) {
      late final List<HashDTO> newNodeChildren;
      if (path[level]) {
        newNodeChildren = [proof.siblings[level], midKey];
      } else {
        newNodeChildren = [midKey, proof.siblings[level]];
      }
      final nodeHashData = await _libBabyjubjubDataSource.hashPoseidon2(
          newNodeChildren[0].toString(), newNodeChildren[1].toString());
      midKey = HashDTO.fromBigInt(BigInt.parse(nodeHashData));
    }

    return Future.value(midKey);
  }

  Future<bool> verifyProof(
      {required ProofDTO proof,
      required NodeDTO node,
      required HashDTO treeRoot}) async {
    return getProofTreeRoot(proof: proof, node: node)
        .then((proofTreeRoot) => proofTreeRoot == treeRoot);
  }
}
