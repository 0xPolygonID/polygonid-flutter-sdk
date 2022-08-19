import 'package:polygonid_flutter_sdk/domain/credential/entities/claim_entity.dart';

import '../../common/entities/filter_entity.dart';
import '../../credential/entities/credential_request_entity.dart';

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
}
