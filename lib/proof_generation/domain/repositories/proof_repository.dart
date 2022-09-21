import 'dart:typed_data';

import '../../../credential/data/dtos/credential_dto.dart';
import '../entities/circuit_data_entity.dart';

abstract class ProofRepository {
  Future<CircuitDataEntity> loadCircuitFiles(String circuitId);

  Future<Uint8List?> calculateAtomicQueryInputs(
      String challenge,
      CredentialDTO credential,
      String circuitId,
      String claimType,
      String key,
      List<int> values,
      int operator,
      String revStatusUrl,
      String pubX,
      String pubY,
      String? signature);

  Future<Uint8List?> calculateWitness(
    CircuitDataEntity circuitData,
    Uint8List atomicQueryInputs,
  );

  Future<Map<String, dynamic>?> prove(
      CircuitDataEntity circuitData, Uint8List wtnsBytes);
}
