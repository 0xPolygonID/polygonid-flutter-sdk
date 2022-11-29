import '../entities/identity_entity.dart';
import '../entities/private_identity_entity.dart';
import '../entities/rhs_node_entity.dart';

abstract class IdentityRepository {
  // Identity
  Future<PrivateIdentityEntity> createIdentity({String? secret});

  Future<void> storeIdentity(
      {required IdentityEntity identity, required String privateKey});

  Future<void> removeIdentity(
      {required String identifier, required String privateKey});

  Future<String> getIdentifier({required String privateKey});

  Future<IdentityEntity> getIdentity({required String identifier});

  Future<PrivateIdentityEntity> getPrivateIdentity(
      {required String identifier, required String privateKey});

  Future<List<IdentityEntity>> getIdentities();

  Future<String> signMessage(
      {required String privateKey, required String message});

  Future<String> getDidIdentifier(
      {required String identifier,
      required String networkName,
      required String networkEnv});

  // RHS
  Future<Map<String, dynamic>> getNonRevProof(
      {required String identityState,
      required int nonce,
      required String baseUrl});

  Future<String> getState(
      {required String identifier, required String contractAddress});

  Future<String> getGistProof(
      {required String identifier, required String contractAddress});

  Future<RhsNodeEntity> getStateRoots({required String url});
}
