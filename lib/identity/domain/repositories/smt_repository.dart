import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_state_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_type.dart';

import '../../../proof/domain/entities/proof_entity.dart';
import '../entities/hash_entity.dart';
import '../entities/node_entity.dart';

abstract class SMTRepository {
  Future<void> addLeaf(
      {required NodeEntity leaf,
      required TreeType type,
      required String did,
      required String privateKey});

  Future<NodeEntity> getNode(
      {required HashEntity hash,
      required TreeType type,
      required String did,
      required String privateKey});

  Future<void> addNode(
      {required HashEntity hash,
      required NodeEntity node,
      required TreeType type,
      required String did,
      required String privateKey});

  Future<HashEntity> getRoot(
      {required TreeType type,
      required String did,
      required String privateKey});

  Future<void> setRoot(
      {required HashEntity root,
      required TreeType type,
      required String did,
      required String privateKey});

  /// TODO: use this through an UC
  Future<ProofEntity> generateProof({
    required HashEntity key,
    required TreeType type,
    required String did,
    required String privateKey,
  });

  Future<void> createSMT({
    required int maxLevels,
    required TreeType type,
    required String did,
    required String privateKey,
  });

  Future<void> removeSMT({
    required TreeType type,
    required String did,
    required String privateKey,
  });

  Future<String> hashState({
    required String claims,
    required String revocation,
    required String roots,
  });

  Future<Map<String, dynamic>> convertState({required TreeStateEntity state});
}
