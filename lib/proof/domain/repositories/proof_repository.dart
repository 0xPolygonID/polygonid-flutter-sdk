import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/proof_scope_request.dart';

import '../entities/circuit_data_entity.dart';
import '../entities/gist_proof_entity.dart';
import '../entities/jwz/jwz.dart';
import '../entities/jwz/jwz_proof.dart';
import '../entities/proof_entity.dart';

abstract class ProofRepository {
  Future<bool> isCircuitSupported({required String circuitId});

  Future<CircuitDataEntity> loadCircuitFiles(String circuitId);

  Future<Uint8List> calculateAtomicQueryInputs(
      {required String id,
      required int profileNonce,
      required int claimSubjectProfileNonce,
      required ClaimEntity claim,
      required ProofScopeRequest request,
      ProofEntity? incProof,
      ProofEntity? nonRevProof,
      GistProofEntity? gistProof,
      List<String>? authClaim,
      Map<String, dynamic>? treeState,
      String? challenge,
      String? signature});

  Future<Uint8List> calculateWitness(
    CircuitDataEntity circuitData,
    Uint8List atomicQueryInputs,
  );

  Future<JWZProof> prove(CircuitDataEntity circuitData, Uint8List wtnsBytes);

  Future<List<FilterEntity>> getFilters({required ProofRequestEntity request});

  Future<String> encodeJWZ({required JWZEntity jwz});

  Future<GistProofEntity> getGistProof(
      {required String idAsInt, required String contractAddress});
}
