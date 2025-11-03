import 'package:polygonid_flutter_sdk/common/utils/credential_sort_order.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';

import '../../../common/domain/entities/filter_entity.dart';
import '../entities/claim_entity.dart';

abstract class CredentialRepository {
  Future<void> saveCredentials({
    required List<CredentialEntity> credentials,
    required String genesisDid,
    required String encryptionKey,
  });

  Future<List<CredentialEntity>> getCredentials({
    List<FilterEntity>? filters,
    required String genesisDid,
    required String encryptionKey,
    List<CredentialSortOrder> credentialSortOrderList = const [],
  });

  Future<CredentialEntity> getCredential({
    required String claimId,
    required String genesisDid,
    required String encryptionKey,
  });

  Future<CredentialEntity> getCredentialByPartialId({
    required String partialId,
    required String genesisDid,
    required String encryptionKey,
  });

  Future<void> removeCredentials({
    required List<String> claimIds,
    required String genesisDid,
    required String encryptionKey,
  });

  Future<void> removeAllCredentials({
    required String genesisDid,
    required String encryptionKey,
  });

  Future<Map<String, dynamic>> getRevocationStatus({
    required CredentialEntity claim,
  });

  Future<String?> getRhsRevocationId({required CredentialEntity claim});

  Future<String> getIssuerIdentifier({required CredentialEntity claim});

  Future<int> getRevocationNonce({required CredentialDTO credential});

  Future<String> getRevocationUrl({required CredentialDTO credential});

  Future<List<String>> getAuthClaim({required List<String> publicKey});

  Future<bool> cacheCredential({required String credential, String? config});

  void cleanCache({String? config});

  Future<String> coreClaimFromCredential({
    required String credential,
    String? config,
  });
}
