import '../../../proof/domain/entities/proof_entity.dart';
import '../entities/hash_entity.dart';
import '../entities/node_entity.dart';

abstract class SMTRepository {
  Future<void> addLeaf(
      {required HashEntity key,
      required HashEntity value,
      required String storeName,
      required String did,
      required String privateKey});

  Future<NodeEntity> getNode(
      {required HashEntity hash,
      required String storeName,
      required String did,
      required String privateKey});

  Future<void> addNode(
      {required HashEntity hash,
      required NodeEntity node,
      required String storeName,
      required String did,
      required String privateKey});

  Future<HashEntity> getRoot(
      {required String storeName,
      required String did,
      required String privateKey});

  Future<void> setRoot(
      {required HashEntity root,
      required String storeName,
      required String did,
      required String privateKey});

  Future<ProofEntity> generateProof(
      {required HashEntity key,
      required String storeName,
      required String did,
      required String privateKey});
}
