import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/offer/offer_iden3_message_entity.dart';

import '../../../common/domain/entities/filter_entity.dart';
import '../entities/claim_entity.dart';

abstract class CredentialRepository {
  Future<ClaimEntity> fetchClaim(
      {required String did,
      required String authToken,
      required OfferIden3MessageEntity message});

  Future<void> saveClaims({
    required List<ClaimEntity> claims,
    required String did,
    required String privateKey,
  });

  Future<List<ClaimEntity>> getClaims(
      {List<FilterEntity>? filters,
      required String did,
      required String privateKey});

  Future<ClaimEntity> getClaim(
      {required String claimId,
      required String did,
      required String privateKey});

  Future<void> removeClaims(
      {required List<String> claimIds,
      required String did,
      required String privateKey});

  Future<Map<String, dynamic>> fetchSchema({required String url});

  Future<Map<String, dynamic>> fetchVocab(
      {required Map<String, dynamic> schema, required String type});

  Future<Map<String, dynamic>> getRevocationStatus(
      {required ClaimEntity claim});

  Future<bool> isUsingRHS({required ClaimEntity claim});

  Future<String> getRhsRevocationId({required ClaimEntity claim});

  Future<int> getRevocationNonce({required ClaimEntity claim});

  Future<List<String>> getAuthClaim({required List<String> publicKey});
}
