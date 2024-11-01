import 'package:polygonid_flutter_sdk/identity/data/data_sources/smt_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_smt_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/node_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/hash_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_state_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/mtproof_dto.dart';
import 'package:poseidon/poseidon.dart';

class SMTRepositoryImpl implements SMTRepository {
  final SMTDataSource _smtDataSource;
  final StorageSMTDataSource _storageSMTDataSource;

  SMTRepositoryImpl(
    this._smtDataSource,
    this._storageSMTDataSource,
  );

  // @override
  // Future<HashEntity> addLeaf({required HashEntity key,
  //   required HashEntity value,
  //   required TreeType type,
  //   required String did,
  //   required String privateKey}) async {
  //   final keyHash = (key);
  //   final valueHash = (value);
  //   final oneHash = HashDTO.fromBigInt(BigInt.one);
  //   final newNodeChildren = [keyHash, valueHash, oneHash];
  //   String nodeHashString = poseidon3(
  //       keyHash, valueHash, BigInt.one);
  //   HashDTO nodeHash = HashDTO.fromBigInt(nodeHashString);
  //   final newNodeLeaf = NodeDTO(
  //       hash: nodeHash, children: newNodeChildren, type: NodeTypeDTO.leaf);
  //   return _smtDataSource
  //       .addLeaf(
  //       newNodeLeaf: newNodeLeaf,
  //       storeName: _treeTypeMapper.mapTo(type),
  //       did: did,
  //       privateKey: privateKey)
  //       .then((dto) => _hashMapper.mapFrom(dto)); // returns new root
  // }

  Future<void> addLeaf({
    required NodeEntity leaf,
    required TreeType type,
    required String did,
    required String privateKey,
  }) {
    return _smtDataSource.addLeaf(
      newNodeLeaf: leaf,
      storeName: type.storeName,
      did: did,
      privateKey: privateKey,
    );
  }

  @override
  Future<NodeEntity> getNode({
    required HashEntity hash,
    required TreeType type,
    required String did,
    required String privateKey,
  }) {
    return _storageSMTDataSource.getNode(
      key: hash,
      storeName: type.storeName,
      did: did,
      privateKey: privateKey,
    );
  }

  @override
  Future<HashEntity> getRoot({
    required TreeType type,
    required String did,
    required String privateKey,
  }) {
    return _storageSMTDataSource.getRoot(
      storeName: type.storeName,
      did: did,
      privateKey: privateKey,
    );
  }

  @override
  Future<void> addNode({
    required HashEntity hash,
    required NodeEntity node,
    required TreeType type,
    required String did,
    required String privateKey,
  }) {
    return _storageSMTDataSource.addNode(
      key: hash,
      node: node,
      storeName: type.storeName,
      did: did,
      privateKey: privateKey,
    );
  }

  @override
  Future<void> setRoot(
      {required HashEntity root,
      required TreeType type,
      required String did,
      required String privateKey}) {
    return _storageSMTDataSource.setRoot(
      root: (root),
      storeName: type.storeName,
      did: did,
      privateKey: privateKey,
    );
  }

  @override
  Future<MTProofEntity> generateProof({
    required HashEntity key,
    required TreeType type,
    required String did,
    required String privateKey,
  }) async {
    return _smtDataSource.generateProof(
      key: (key),
      storeName: type.storeName,
      did: did,
      privateKey: privateKey,
    );
  }

  Future<HashEntity> getProofTreeRoot({
    required MTProofEntity proof,
    required NodeEntity node,
  }) async {
    return _smtDataSource.getProofTreeRoot(
      proof: proof,
      node: node,
    );
  }

  Future<bool> verifyProof({
    required MTProofEntity proof,
    required NodeEntity node,
    required HashEntity treeRoot,
  }) async {
    return _smtDataSource.verifyProof(
      proof: proof,
      node: node,
      treeRoot: (treeRoot),
    );
  }

  @override
  Future<void> createSMT({
    required int maxLevels,
    required TreeType type,
    required String did,
    required String privateKey,
  }) {
    return _smtDataSource.createSMT(
        maxLevels: maxLevels,
        storeName: type.storeName,
        did: did,
        privateKey: privateKey);
  }

  @override
  Future<void> removeSMT({
    required TreeType type,
    required String did,
    required String privateKey,
  }) async {
    await _smtDataSource.removeSMT(
        storeName: type.storeName, did: did, privateKey: privateKey);
    await _smtDataSource.removeRoot(
        storeName: type.storeName, did: did, privateKey: privateKey);
  }

  @override
  Future<String> hashState({
    required String claims,
    required String revocation,
    required String roots,
  }) async {
    return poseidon3([
      BigInt.parse(claims),
      BigInt.parse(revocation),
      BigInt.parse(roots),
    ]).toString();
  }

  @override
  Future<Map<String, dynamic>> convertState({required TreeStateEntity state}) {
    return Future.value(state.toJson());
  }
}
