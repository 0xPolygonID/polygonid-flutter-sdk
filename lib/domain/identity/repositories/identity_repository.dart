import '../entities/identity.dart';

abstract class IdentityRepository {
  Future<String> createIdentity({String? privateKey});

  Future<Identity> getIdentity({String? privateKey});

  Future<String> signMessage(
      {required String privateKey, required String message});

  Future<void> removeIdentity({required String identifier});

  /// Remove this method when we support multiple identity
  Future<String?> getCurrentIdentifier();
}
