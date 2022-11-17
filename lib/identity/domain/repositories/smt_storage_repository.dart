import '../entities/hash_entity.dart';
import '../entities/node_entity.dart';

abstract class SMTStorageRepository {
  Future<NodeEntity> get(
      {required HashEntity hash,
      required String identifier,
      required String privateKey});

  Future<void> put(
      {required HashEntity hash,
      required NodeEntity node,
      required String identifier,
      required String privateKey});

  Future<HashEntity> getRoot(
      {required String identifier, required String privateKey});

  Future<void> setRoot(
      {required HashEntity root,
      required String identifier,
      required String privateKey});
}
