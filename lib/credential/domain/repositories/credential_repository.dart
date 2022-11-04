import '../../../common/domain/entities/filter_entity.dart';
import '../entities/claim_entity.dart';
import '../entities/credential_request_entity.dart';

abstract class CredentialRepository {
  Future<ClaimEntity> fetchClaim(
      {required String identifier,
      required String token,
      required CredentialRequestEntity credentialRequest});

  Future<String> getFetchMessage(
      {required CredentialRequestEntity credentialRequest});

  Future<void> saveClaims({
    required List<ClaimEntity> claims,
    required String identifier,
    required String privateKey,
  });

  Future<List<ClaimEntity>> getClaims(
      {List<FilterEntity>? filters,
      required String identifier,
      required String privateKey});

  Future<ClaimEntity> getClaim(
      {required String claimId,
      required String identifier,
      required String privateKey});

  Future<void> removeClaims(
      {required List<String> claimIds,
      required String identifier,
      required String privateKey});

  Future<ClaimEntity> updateClaim(
      {required ClaimEntity claim,
      required String identifier,
      required String privateKey});

  Future<Map<String, dynamic>?> fetchSchema({required String url});

  Future<Map<String, dynamic>?> fetchVocab(
      {required Map<String, dynamic>? schema, required String type});

  Future<Map<String, dynamic>> getRevocationStatus(
      {required ClaimEntity claim});

  Future<bool> isUsingRHS({required ClaimEntity claim});

  Future<String> getRhsRevocationId({required ClaimEntity claim});

  Future<int> getRevocationNonce({required ClaimEntity claim});
}
