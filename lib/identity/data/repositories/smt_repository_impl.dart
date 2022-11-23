// import '../../domain/exceptions/smt_exceptions.dart';
// import '../../domain/repositories/smt_storage_repository.dart';
// import '../../libs/smt/hash.dart';
// import '../../libs/smt/node.dart';
//
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_smt_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/hash_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/node_entity.dart';

import '../../domain/entities/proof_entity.dart';
import '../../domain/repositories/smt_repository.dart';
import '../data_sources/smt_data_source.dart';
import '../dtos/hash_dto.dart';
import '../dtos/node_dto.dart';
import '../mappers/hash_mapper.dart';
import '../mappers/node_mapper.dart';
import '../mappers/proof_mapper.dart';

class SMTRepositoryImpl implements SMTRepository {
  final SMTDataSource _smtDataSource;
  final StorageSMTDataSource _storageSMTDataSource;
  final LibIdentityDataSource _libIdentityDataSource;
  final NodeMapper _nodeMapper;
  final HashMapper _hashMapper;
  final ProofMapper _proofMapper;

  SMTRepositoryImpl(
    this._smtDataSource,
    this._storageSMTDataSource,
    this._libIdentityDataSource,
    this._nodeMapper,
    this._hashMapper,
    this._proofMapper,
  );

  @override
  Future<HashEntity> addLeaf(
      {required HashEntity key,
      required HashEntity value,
      required String storeName,
      required String identifier,
      required String privateKey}) async {
    final keyHash = _hashMapper.mapTo(key);
    final valueHash = _hashMapper.mapTo(value);
    final oneHash = HashDTO.one();
    final newNodeChildren = [keyHash, valueHash, oneHash];
    final nodeHash = _libIdentityDataSource.getNodeKey(newNodeChildren);
    final newNodeLeaf = NodeDTO(
        hash: nodeHash, children: newNodeChildren, type: NodeTypeDTO.leaf);
    return _smtDataSource
        .addLeaf(
            newNodeLeaf: newNodeLeaf,
            storeName: storeName,
            identifier: identifier,
            privateKey: privateKey)
        .then((dto) => _hashMapper.mapFrom(dto)); // returns new root
  }

  @override
  Future<NodeEntity> getNode(
      {required HashEntity hash,
      required String storeName,
      required String identifier,
      required String privateKey}) {
    return _storageSMTDataSource
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
    return _storageSMTDataSource
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
    return _storageSMTDataSource.addNode(
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
    return _storageSMTDataSource.setRoot(
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
    return _smtDataSource
        .generateProof(
            key: _hashMapper.mapTo(key),
            storeName: storeName,
            identifier: identifier,
            privateKey: privateKey)
        .then((dto) => _proofMapper.mapFrom(dto));
  }

  Future<HashEntity> getProofTreeRoot(
      {required ProofEntity proof, required NodeEntity node}) async {
    return _smtDataSource
        .getProofTreeRoot(
            proof: _proofMapper.mapTo(proof), node: _nodeMapper.mapTo(node))
        .then((dto) => _hashMapper.mapFrom(dto));
  }

  Future<bool> verifyProof(
      {required ProofEntity proof,
      required NodeEntity node,
      required HashEntity treeRoot}) async {
    return _smtDataSource.verifyProof(
        proof: _proofMapper.mapTo(proof),
        node: _nodeMapper.mapTo(node),
        treeRoot: _hashMapper.mapTo(treeRoot));
  }
}
