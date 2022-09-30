abstract class Iden3commRepository {
  Future<bool> authenticate(
      {required String issuerMessage,
      required String identifier,
      String? pushToken});

  Future<String> getAuthToken(
      {required String identifier, required String message});

/*Future<List<ProofResponse>> getProofResponseList({
    List<ProofScopeRequest>? scope,
    required String privateKey,
  });

  Future<ProofResponse> getProofResponse(ProofScopeRequest proofRequest,
      String privateKey, CircuitDataEntity circuit, ClaimEntity authClaim);

  Future<String> getAuthToken(
      {required String identifier, required String message});*/
}
