import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/rev_status_entity.dart';

abstract class CredentialRepository {
  Future<void> saveClaims({
    required List<ClaimEntity> claims,
    required String genesisDid,
    required String privateKey,
  });

  Future<List<ClaimEntity>> getClaims(
      {List<FilterEntity>? filters,
      required String genesisDid,
      required String privateKey});

  Future<ClaimEntity> getClaim(
      {required String claimId,
      required String genesisDid,
      required String privateKey});

  Future<void> removeClaims(
      {required List<String> claimIds,
      required String genesisDid,
      required String privateKey});

  Future<void> removeAllClaims(
      {required String genesisDid, required String privateKey});

  Future<RevStatusEntity> getRevocationStatus({required ClaimEntity claim});

  Future<bool> isUsingRHS({required ClaimEntity claim});

  Future<String> getRhsRevocationId({required ClaimEntity claim});

  Future<String> getIssuerIdentifier({required ClaimEntity claim});

  Future<int> getRevocationNonce(
      {required ClaimEntity claim, required bool rhs});

  Future<String> getRevocationUrl(
      {required ClaimEntity claim, required bool rhs});

  Future<List<String>> getAuthClaim({required List<String> publicKey});
}
