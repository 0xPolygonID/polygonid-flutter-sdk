import '../entities/identity_entity.dart';
import '../entities/rhs_node_entity.dart';

abstract class IdentityRepository {
  Future<String> createIdentity({String? privateKey});

  Future<IdentityEntity> getIdentityFromKey({String? privateKey});

  Future<String> getIdentifier({String? privateKey});

  Future<IdentityEntity> getIdentity({required String identifier});

  Future<void> removeIdentity({required String identifier});

  Future<String> signMessage(
      {required String identifier, required String message});

  /// TODO: Remove this method when we support multiple identity
  Future<String?> getCurrentIdentifier();

  /// FIXME: remove when [PublicIdentity] is created
  Future<List<String>> getPublicKeys({required String privateKey});

  Future<String> fetchIdentityState({required String id});

  Future<RhsNodeEntity> fetchStateRoots({required String url});

  Future<Map<String, dynamic>> nonRevProof(
      int revNonce, String id, String rhsBaseUrl);
}
