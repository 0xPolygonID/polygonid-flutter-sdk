import 'package:polygonid_flutter_sdk/domain/identity/entities/circuit_data.dart';

import '../entities/identity.dart';

abstract class IdentityRepository {
  Future<String> createIdentity({String? privateKey});

  Future<Identity> getIdentityFromKey({String? privateKey});

  Future<String> getIdentifier({String? privateKey});

  Future<Identity> getIdentity({required String identifier});

  Future<String> signMessage(
      {required String identifier, required String message});

  Future<void> removeIdentity({required String identifier});

  /// TODO: Remove this method when we support multiple identity
  Future<String?> getCurrentIdentifier();

  Future<String> getAuthToken(
      {required String identifier,
      required CircuitData circuitData,
      required String message});
}
