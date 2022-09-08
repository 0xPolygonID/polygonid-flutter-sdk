import '../../../proof_generation/domain/entities/circuit_data_entity.dart';
import '../entities/identity_entity.dart';

abstract class IdentityRepository {
  Future<String> createIdentity({String? privateKey});

  Future<IdentityEntity> getIdentityFromKey({String? privateKey});

  Future<String> getIdentifier({String? privateKey});

  Future<IdentityEntity> getIdentity({required String identifier});

  Future<String> signMessage(
      {required String identifier, required String message});

  Future<void> removeIdentity({required String identifier});

  /// TODO: Remove this method when we support multiple identity
  Future<String?> getCurrentIdentifier();

  Future<String> getAuthToken(
      {required String identifier,
      required CircuitDataEntity circuitData,
      required String message});

  ///
  Future<void> authenticate({
    required String issuerMessage,
    required String identifier,
  });
}
