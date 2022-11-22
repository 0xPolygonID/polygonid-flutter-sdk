import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:sembast/sembast.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../constants.dart';
import '../../../sdk/di/injector.dart';
import '../../domain/exceptions/smt_exceptions.dart';
import '../dtos/hash_dto.dart';
import '../dtos/node_aux_dto.dart';
import '../dtos/node_dto.dart';
import '../dtos/proof_dto.dart';
import '../mappers/hex_mapper.dart';
import 'lib_babyjubjub_data_source.dart';

/// [StoreRef] wrapper
/// Delegates all call to [IdentitySMTStoreRefWrapper._getStore]
/// Needed for UT for mocking extension methods
@injectable
class IdentitySMTStoreRefWrapper {
  Future<StoreRef<String, Map<String, Object?>>> _getStore(
      {required String storeName}) {
    return getItSdk.getAsync<StoreRef<String, Map<String, Object?>>>(
        instanceName: storeName);
  }

  Future<Map<String, Object?>?> get(
      DatabaseClient database, String storeName, String key) {
    return _getStore(storeName: storeName)
        .then((store) => store.record(key).get(database));
  }

  Future<Map<String, Object?>> put(DatabaseClient database, String storeName,
      String key, Map<String, Object?> value,
      {bool? merge}) {
    return _getStore(storeName: storeName)
        .then((store) => store.record(key).put(database, value, merge: merge));
  }

  Future<String?> remove(
      DatabaseClient database, String storeName, String identifier) {
    return _getStore(storeName: storeName)
        .then((store) => store.record(identifier).delete(database));
  }
}

class SMTDataSource {
  final IdentitySMTStoreRefWrapper _storeRefWrapper;
  final HexMapper _hexMapper;
  final LibBabyJubJubDataSource _libBabyjubjubDataSource;

  SMTDataSource(
      this._storeRefWrapper, this._hexMapper, this._libBabyjubjubDataSource);

  Future<Database> _getDatabase(
      {required String identifier, required String privateKey}) {
    return getItSdk.getAsync<Database>(
        instanceName: identityDatabaseName,
        param1: identifier,
        param2: privateKey);
  }

  Future<NodeDTO> getNode(
      {required HashDTO key,
      required String storeName,
      required String identifier,
      required String privateKey}) {
    return _getDatabase(identifier: identifier, privateKey: privateKey).then(
        (database) => database
            .transaction((transaction) => getTransact(
                storeName: storeName, transaction: transaction, key: key))
            .then((snapshot) => NodeDTO.fromJson(snapshot!))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<Map<String, Object?>?> getTransact(
      {required String storeName,
      required DatabaseClient transaction,
      required HashDTO key}) async {
    return _storeRefWrapper.get(transaction, storeName, key.toString());
  }

  Future<void> addNode(
      {required HashDTO key,
      required NodeDTO node,
      required String storeName,
      required String identifier,
      required String privateKey}) {
    return _getDatabase(identifier: identifier, privateKey: privateKey).then(
        (database) => database
            .transaction((transaction) => putTransact(
                storeName: storeName,
                transaction: transaction,
                key: key,
                node: node))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<void> putTransact(
      {required String storeName,
      required DatabaseClient transaction,
      required HashDTO key,
      required NodeDTO node}) async {
    await _storeRefWrapper.put(
        transaction, storeName, key.toString(), node.toJson());
  }

  Future<HashDTO> getRoot(
      {required String storeName,
      required String identifier,
      required String privateKey}) {
    return _getDatabase(identifier: identifier, privateKey: privateKey).then(
        (database) => database
            .transaction((transaction) =>
                getRootTransact(transaction: transaction, storeName: storeName))
            .then((snapshot) => HashDTO.fromJson(snapshot!))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<Map<String, Object?>?> getRootTransact(
      {required DatabaseClient transaction, required String storeName}) async {
    return _storeRefWrapper.get(transaction, storeName, "root");
  }

  Future<void> setRoot(
      {required HashDTO root,
      required String storeName,
      required String identifier,
      required String privateKey}) {
    return _getDatabase(identifier: identifier, privateKey: privateKey).then(
        (database) => database
            .transaction((transaction) => setRootTransact(
                transaction: transaction, storeName: storeName, root: root))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<void> setRootTransact(
      {required DatabaseClient transaction,
      required String storeName,
      required HashDTO root}) async {
    await _storeRefWrapper.put(transaction, storeName, "root", root.toJson());
  }

  Future<int> getMaxLevels(
      {required String storeName,
      required String identifier,
      required String privateKey}) {
    return _getDatabase(identifier: identifier, privateKey: privateKey).then(
        (database) => database
            .transaction((transaction) =>
                getRootTransact(transaction: transaction, storeName: storeName))
            .then((snapshot) => snapshot!["maxLevels"] as int)
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<Map<String, Object?>?> getMaxLevelsTransact(
      {required DatabaseClient transaction, required String storeName}) async {
    return _storeRefWrapper.get(transaction, storeName, "maxLevels");
  }

  Future<void> setMaxLevels(
      {required int maxLevels,
      required String storeName,
      required String identifier,
      required String privateKey}) {
    return _getDatabase(identifier: identifier, privateKey: privateKey).then(
        (database) => database
            .transaction((transaction) => setMaxLevelsTransact(
                transaction: transaction,
                storeName: storeName,
                maxLevels: maxLevels))
            .whenComplete(() => database.close()));
  }

  // For UT purpose
  Future<void> setMaxLevelsTransact(
      {required DatabaseClient transaction,
      required String storeName,
      required int maxLevels}) async {
    await _storeRefWrapper
        .put(transaction, storeName, "maxLevels", {"maxLevels": maxLevels});
  }

  Future<HashDTO> addLeaf(
      {required NodeDTO newNodeLeaf,
      required String storeName,
      required String identifier,
      required String privateKey}) async {
    int maxLevels = await getMaxLevels(
        storeName: storeName, identifier: identifier, privateKey: privateKey);
    final root = await getRoot(
        storeName: storeName, identifier: identifier, privateKey: privateKey);
    final path = _getPath(maxLevels, newNodeLeaf.children[0]);
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
    int maxLevels = await getMaxLevels(
        storeName: storeName, identifier: identifier, privateKey: privateKey);
    if (level > maxLevels - 1) {
      throw ArgumentError("level must be less than maxLevels");
    }

    logger().i("add leaf under key $key at level $level");

    final node = await getNode(
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
        final pathOldLeaf = _getPath(maxLevels, nKey);
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
          final nodeHashData = await _libBabyjubjubDataSource
              .hashPoseidon(newNodeChildren.map((dto) => dto.data).toList());
          final nodeHash = HashDTO(data: nodeHashData);
          newNodeMiddle = NodeDTO(
              children: newNodeChildren,
              hash: nodeHash,
              type: NodeTypeDTO.middle);
        } else {
          // go left
          final nextKey = await _addLeaf(newLeaf, node.children[0], level + 1,
              path, storeName, identifier, privateKey);
          final newNodeChildren = [nextKey, node.children[1]];
          final nodeHashData = await _libBabyjubjubDataSource
              .hashPoseidon(newNodeChildren.map((dto) => dto.data).toList());
          final nodeHash = HashDTO(data: nodeHashData);
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
      getNode(
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

    addNode(
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
    int maxLevels = await getMaxLevels(
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
      final nodeHashData = await _libBabyjubjubDataSource
          .hashPoseidon(newNodeChildren.map((dto) => dto.data).toList());
      final nodeHash = HashDTO(data: nodeHashData);
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
    final nodeHashData = await _libBabyjubjubDataSource
        .hashPoseidon(newNodeChildren.map((dto) => dto.data).toList());
    final nodeHash = HashDTO(data: nodeHashData);
    final NodeDTO newNodeMiddle = NodeDTO(
        children: newNodeChildren, hash: nodeHash, type: NodeTypeDTO.middle);
    _addNode(newLeaf, storeName, identifier, privateKey);
    return _addNode(newNodeMiddle, storeName, identifier, privateKey);
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
      required String identifier,
      required String privateKey}) async {
    int maxLevels = await getMaxLevels(
        storeName: storeName, identifier: identifier, privateKey: privateKey);
    final path = _getPath(maxLevels, key);
    var siblings = <HashDTO>[];
    final root = await getRoot(
        storeName: storeName, identifier: identifier, privateKey: privateKey);
    var nextKey = root;
    for (int depth = 0; depth < maxLevels; depth++) {
      final node = await getNode(
          key: nextKey,
          storeName: storeName,
          identifier: identifier,
          privateKey: privateKey);

      switch (node.type) {
        case NodeTypeDTO.state:
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
                key: Uint8ArrayUtils.bytesToBigInt(
                        _hexMapper.mapTo(node.children[0].data))
                    .toString(),
                value: Uint8ArrayUtils.bytesToBigInt(
                        _hexMapper.mapTo(node.children[1].data))
                    .toString(),
              ));
        case NodeTypeDTO.middle:
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
