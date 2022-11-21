// import '../../domain/exceptions/smt_exceptions.dart';
// import '../../domain/repositories/smt_storage_repository.dart';
// import '../../libs/smt/hash.dart';
// import '../../libs/smt/node.dart';
//
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/hash_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/node_entity.dart';

import '../../../common/domain/domain_logger.dart';
import '../../domain/entities/proof_entity.dart';
import '../../domain/exceptions/smt_exceptions.dart';
import '../../domain/repositories/smt_repository.dart';
import '../../libs/smt/smt_utils.dart';
import '../data_sources/storage_identity_smt_data_source.dart';
import '../dtos/hash_dto.dart';
import '../dtos/node_dto.dart';
import '../mappers/hash_mapper.dart';
import '../mappers/node_mapper.dart';

class SMTRepositoryImpl implements SMTRepository {
  final StorageIdentitySMTDataSource _storageIdentitySMTDataSource;
  final LibIdentityDataSource _libIdentityDataSource;
  final NodeMapper _nodeMapper;
  final HashMapper _hashMapper;

  SMTRepositoryImpl(
    this._storageIdentitySMTDataSource,
    this._libIdentityDataSource,
    this._nodeMapper,
    this._hashMapper,
  );

  @override
  Future<HashDTO> addLeaf(
      {required HashEntity key,
      required HashEntity value,
      required String storeName,
      required String identifier,
      required String privateKey}) async {
    //merkleTree.add(k, v);
    final keyHash = _hashMapper.mapTo(key);
    final valueHash = _hashMapper.mapTo(value);
    final oneHash = HashDTO.one();
    final newNodeChildren = [keyHash, valueHash, oneHash];
    final nodeHash = _libIdentityDataSource.getNodeKey(newNodeChildren);
    final newNodeLeaf = NodeDTO(
        hash: nodeHash, children: newNodeChildren, type: NodeTypeDTO.leaf);
    int maxLevels = await _storageIdentitySMTDataSource.getMaxLevels(
        storeName: storeName, identifier: identifier, privateKey: privateKey);
    final root = await _storageIdentitySMTDataSource.getRoot(
        storeName: storeName, identifier: identifier, privateKey: privateKey);
    final path = SMTUtils.getPath(maxLevels, keyHash);
    final newRoot =
        _addLeaf(newNodeLeaf, root, 0, path, storeName, identifier, privateKey);
    return newRoot;
  }

  Future<HashDTO> _addLeaf(
      NodeDTO newLeaf,
      HashDTO key,
      int level,
      List<bool> path,
      String storeName,
      String identifier,
      String privateKey) async {
    int maxLevels = await _storageIdentitySMTDataSource.getMaxLevels(
        storeName: storeName, identifier: identifier, privateKey: privateKey);
    if (level > maxLevels - 1) {
      throw ArgumentError("level must be less than maxLevels");
    }

    logger().i("add leaf under key $key at level $level");

    final node = await _storageIdentitySMTDataSource.getNode(
        key: key,
        storeName: storeName,
        identifier: identifier,
        privateKey: privateKey);
    switch (node.type) {
      case NodeTypeDTO.state:
        return _addNode(newLeaf, storeName, identifier, privateKey);
      case NodeTypeDTO.leaf:
        final nKey = node.children[0];
        // Check if leaf node found contains the leaf node we are
        // trying to add
        final newLeafKey = newLeaf.children[0];
        if (newLeafKey == nKey) {
          throw SMTEntryIndexAlreadyExists();
        }
        final pathOldLeaf = SMTUtils.getPath(maxLevels, nKey);
        // We need to push newLeaf down until its path diverges from
        // n's path
        return _pushLeaf(newLeaf, node, level, path, pathOldLeaf, storeName,
            identifier, privateKey);
      case NodeTypeDTO.middle:
        // We need to go deeper, continue traversing the tree, left or
        // right depending on path
        late final NodeDTO newNodeMiddle;
        if (path[level]) {
          // go right
          final nextKey = await _addLeaf(newLeaf, node.children[1], level + 1,
              path, storeName, identifier, privateKey);
          final newNodeChildren = [node.children[0], nextKey];
          final nodeHash = _libIdentityDataSource.getNodeKey(newNodeChildren);
          newNodeMiddle = NodeDTO(
              children: newNodeChildren,
              hash: nodeHash,
              type: NodeTypeDTO.middle);
        } else {
          // go left
          final nextKey = await _addLeaf(newLeaf, node.children[0], level + 1,
              path, storeName, identifier, privateKey);
          final newNodeChildren = [nextKey, node.children[1]];
          final nodeHash = _libIdentityDataSource.getNodeKey(newNodeChildren);
          newNodeMiddle = NodeDTO(
              children: newNodeChildren,
              hash: nodeHash,
              type: NodeTypeDTO.middle);
        }
        return _addNode(newNodeMiddle, storeName, identifier, privateKey);
      default:
        throw SMTInvalidNodeFound();
    }
  }

  HashDTO _addNode(
      NodeDTO node, String storeName, String identifier, String privateKey) {
    // print("add node $n");

    final key = node.hash;
    if (node.type == NodeTypeDTO.state) {
      return key;
    }

    bool nodeFound = true;
    try {
      _storageIdentitySMTDataSource.getNode(
          key: key,
          storeName: storeName,
          identifier: identifier,
          privateKey: privateKey);
    } on SMTNotFound {
      nodeFound = false;
    }

    if (nodeFound) {
      throw SMTNodeKeyAlreadyExists();
    }

    _storageIdentitySMTDataSource.addNode(
        key: key,
        node: node,
        storeName: storeName,
        identifier: identifier,
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
      String identifier,
      String privateKey) async {
    int maxLevels = await _storageIdentitySMTDataSource.getMaxLevels(
        storeName: storeName, identifier: identifier, privateKey: privateKey);
    if (level > maxLevels - 2) {
      throw SMTReachedMaxLevel();
    }

    if (pathNewLeaf[level] == pathOldLeaf[level]) {
      // We need to go deeper!
      final nextKey = await _pushLeaf(newLeaf, oldLeaf, level + 1, pathNewLeaf,
          pathOldLeaf, storeName, identifier, privateKey);
      late final List<HashDTO> newNodeChildren;
      if (pathNewLeaf[level]) {
        // go right
        newNodeChildren = [HashDTO.zero(), nextKey];
      } else {
        // go left
        newNodeChildren = [nextKey, HashDTO.zero()];
      }
      final nodeHash = _libIdentityDataSource.getNodeKey(newNodeChildren);
      final NodeDTO newNodeMiddle = NodeDTO(
          children: newNodeChildren, hash: nodeHash, type: NodeTypeDTO.middle);
      return _addNode(newNodeMiddle, storeName, identifier, privateKey);
    }

    final oldLeafKey = oldLeaf.hash;
    final newLeafKey = newLeaf.hash;
    late final List<HashDTO> newNodeChildren;
    if (pathNewLeaf[level]) {
      newNodeChildren = [oldLeafKey, newLeafKey];
    } else {
      newNodeChildren = [newLeafKey, oldLeafKey];
    }
    final nodeHash = _libIdentityDataSource.getNodeKey(newNodeChildren);
    final NodeDTO newNodeMiddle = NodeDTO(
        children: newNodeChildren, hash: nodeHash, type: NodeTypeDTO.middle);
    _addNode(newLeaf, storeName, identifier, privateKey);
    return _addNode(newNodeMiddle, storeName, identifier, privateKey);
  }

  @override
  Future<NodeEntity> getNode(
      {required HashEntity hash,
      required String storeName,
      required String identifier,
      required String privateKey}) {
    return _storageIdentitySMTDataSource
        .getNode(
            key: _hashMapper.mapTo(hash),
            storeName: storeName,
            identifier: identifier,
            privateKey: privateKey)
        .then((dto) => _nodeMapper.mapFrom(dto));
  }

  @override
  Future<HashEntity> getRoot(
      {required String storeName,
      required String identifier,
      required String privateKey}) {
    return _storageIdentitySMTDataSource
        .getRoot(
            storeName: storeName,
            identifier: identifier,
            privateKey: privateKey)
        .then((dto) => _hashMapper.mapFrom(dto));
  }

  @override
  Future<void> addNode(
      {required HashEntity hash,
      required NodeEntity node,
      required String storeName,
      required String identifier,
      required String privateKey}) {
    return _storageIdentitySMTDataSource.addNode(
        key: _hashMapper.mapTo(hash),
        node: _nodeMapper.mapTo(node),
        storeName: storeName,
        identifier: identifier,
        privateKey: privateKey);
  }

  @override
  Future<void> setRoot(
      {required HashEntity root,
      required String storeName,
      required String identifier,
      required String privateKey}) {
    return _storageIdentitySMTDataSource.setRoot(
        root: _hashMapper.mapTo(root),
        storeName: storeName,
        identifier: identifier,
        privateKey: privateKey);
  }

  Future<ProofEntity> generateProof(
      {required HashEntity key,
      required String storeName,
      required String identifier,
      required String privateKey}) async {
    final keyHash = _hashMapper.mapTo(key);
    int maxLevels = await _storageIdentitySMTDataSource.getMaxLevels(
        storeName: storeName, identifier: identifier, privateKey: privateKey);
    final path = SMTUtils.getPath(maxLevels, keyHash);
    var siblings = <HashEntity>[];
    final root = await getRoot(
        storeName: storeName, identifier: identifier, privateKey: privateKey);
    var nextKey = root;
    for (int depth = 0; depth < maxLevels; depth++) {
      final node = await getNode(
          hash: nextKey,
          storeName: storeName,
          identifier: identifier,
          privateKey: privateKey);
      switch (node.nodeType) {
        case NodeType.state:
          return ProofEntity(existence: false, siblings: siblings);
        case NodeType.leaf:
          if (node.children[0] == key) {
            return ProofEntity(existence: true, siblings: siblings);
          }
          // We found a leaf whose entry didn't match key
          return ProofEntity(
              existence: false, siblings: siblings, nodeAux: node);
        case NodeType.middle:
          if (path[depth]) {
            nextKey = node.children[1];
            siblings.add(node.children[0]);
          } else {
            nextKey = node.children[0];
          }
          siblings.add(node.children[1]);

          continue;
        default:
          throw SMTInvalidNodeFound();
      }
    }
    throw SMTKeyNotFound();
  }
}
