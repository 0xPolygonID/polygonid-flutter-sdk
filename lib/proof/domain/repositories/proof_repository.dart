import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof_request_entity.dart';

import '../entities/circuit_data_entity.dart';
import '../entities/gist_proof_entity.dart';
import '../entities/jwz/jwz.dart';
import '../entities/jwz/jwz_proof.dart';

abstract class ProofRepository {
  Future<bool> isCircuitSupported({required String circuitId});

  Future<CircuitDataEntity> loadCircuitFiles(String circuitId);

  Future<Uint8List> calculateAtomicQueryInputs(
      String challenge,
      ClaimEntity authClaim,
      String circuitId,
      ProofQueryParamEntity queryParam,
      String pubX,
      String pubY,
      String signature,
      Map<String, dynamic> revocationStatus);

  Future<Uint8List> calculateWitness(
    CircuitDataEntity circuitData,
    Uint8List atomicQueryInputs,
  );

  Future<JWZProof> prove(CircuitDataEntity circuitData, Uint8List wtnsBytes);

  Future<List<FilterEntity>> getFilters({required ProofRequestEntity request});

  Future<GistProofEntity> getGistProof(
      {required String idAsInt, required String contractAddress});

  Future<String> encodeJWZ({required JWZEntity jwz});
}
