import '../entities/identity_entity.dart';
import '../entities/node_entity.dart';
import '../entities/private_identity_entity.dart';
import '../entities/rhs_node_entity.dart';

abstract class IdentityRepository {
  // Identity
  Future<PrivateIdentityEntity> createIdentity({
    required blockchain,
    required network,
    String? secret,
    required String accessMessage,
  });

  Future<void> storeIdentity(
      {required IdentityEntity identity, required String privateKey});

  Future<void> removeIdentity(
      {required String identifier, required String privateKey});

  Future<IdentityEntity> getIdentity({required String did});

  Future<PrivateIdentityEntity> getPrivateIdentity(
      {required String did, required String privateKey});

  Future<List<IdentityEntity>> getIdentities();

  Future<String> signMessage(
      {required String privateKey, required String message});

  Future<String> getDidIdentifier({
    required String privateKey,
    required String blockchain,
    required String network,
  });

  // RHS
  Future<Map<String, dynamic>> getNonRevProof(
      {required String identityState,
      required int nonce,
      required String baseUrl});

  Future<String> getState(
      {required String identifier, required String contractAddress});

  Future<String> convertIdToBigInt({required String id});

  Future<RhsNodeEntity> getStateRoots({required String url});

  Future<Map<String, dynamic>> getLatestState({
    required String did,
    required String privateKey,
  });

  Future<NodeEntity> getAuthClaimNode({required List<String> children});

  // TODO: move to iden3comm
  Future<String> getChallenge({required String message});
}
