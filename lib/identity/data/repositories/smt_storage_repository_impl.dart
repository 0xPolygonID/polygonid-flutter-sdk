// import '../../domain/exceptions/smt_exceptions.dart';
// import '../../domain/repositories/smt_storage_repository.dart';
// import '../../libs/smt/hash.dart';
// import '../../libs/smt/node.dart';
//
import 'package:polygonid_flutter_sdk/identity/domain/entities/hash_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/node_entity.dart';

import '../../domain/repositories/smt_storage_repository.dart';
import '../data_sources/storage_identity_state_data_source.dart';
import '../mappers/hash_mapper.dart';
import '../mappers/node_mapper.dart';

class SMTStorageRepositoryImpl implements SMTStorageRepository {
  final StorageIdentityStateDataSource _storageIdentityStateDataSource;
  final NodeMapper _nodeMapper;
  final HashMapper _hashMapper;

  SMTStorageRepositoryImpl(
    this._storageIdentityStateDataSource,
    this._nodeMapper,
    this._hashMapper,
  );

  @override
  Future<NodeEntity> get(
      {required HashEntity hash,
      required String identifier,
      required String privateKey}) {
    return _storageIdentityStateDataSource
        .get(
            key: _hashMapper.mapTo(hash),
            identifier: identifier,
            privateKey: privateKey)
        .then((dto) => _nodeMapper.mapFrom(dto));
  }

  @override
  Future<HashEntity> getRoot(
      {required String identifier, required String privateKey}) {
    return _storageIdentityStateDataSource
        .getRoot(identifier: identifier, privateKey: privateKey)
        .then((dto) => _hashMapper.mapFrom(dto));
  }

  @override
  Future<void> put(
      {required HashEntity hash,
      required NodeEntity node,
      required String identifier,
      required String privateKey}) {
    return _storageIdentityStateDataSource.put(
        hash: _hashMapper.mapTo(hash),
        node: _nodeMapper.mapTo(node),
        identifier: identifier,
        privateKey: privateKey);
  }

  @override
  Future<void> setRoot(
      {required HashEntity root,
      required String identifier,
      required String privateKey}) {
    return _storageIdentityStateDataSource.setRoot(
        root: _hashMapper.mapTo(root),
        identifier: identifier,
        privateKey: privateKey);
  }
}
