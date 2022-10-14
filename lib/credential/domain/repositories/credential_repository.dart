import '../../../common/domain/entities/filter_entity.dart';
import '../entities/claim_entity.dart';
import '../entities/credential_request_entity.dart';
import '../entities/rhs_node_entity.dart';

abstract class CredentialRepository {
  Future<ClaimEntity> fetchClaim(
      {required String identifier,
      required String token,
      required CredentialRequestEntity credentialRequest});

  Future<String> getFetchMessage(
      {required CredentialRequestEntity credentialRequest});

  Future<void> saveClaims({required List<ClaimEntity> claims});

  Future<List<ClaimEntity>> getClaims({List<FilterEntity>? filters});

  Future<ClaimEntity> getClaim({required String id});

  Future<void> removeClaims({required List<String> ids});

  Future<ClaimEntity> updateClaim({required ClaimEntity claim});

  Future<Map<String, dynamic>?> fetchSchema({required String url});

  Future<Map<String, dynamic>?> fetchVocab(
      {required Map<String, dynamic>? schema, required String type});

  Future<List<dynamic>> fetchIssuerState({required String id});

  Future<RhsNodeEntity> fetchIdentityState({required String url});
}
