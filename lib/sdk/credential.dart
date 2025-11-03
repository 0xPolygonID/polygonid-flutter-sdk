import 'package:injectable/injectable.dart';
import 'package:jose_plus/jose.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/utils/credential_sort_order.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/cache_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/cache_credentials_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/clean_cache_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/credential_status_check_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claim_revocation_status_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_credential_by_id_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_credential_by_partial_id_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/refresh_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/remove_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/update_claim_use_case.dart';

import '../credential/domain/use_cases/save_claims_use_case.dart';

abstract class PolygonIdSdkCredential {
  /// Store in the the Polygon ID Sdk a list of [CredentialEntity] associated to
  /// the identity.
  ///
  /// The [claims] is the list of [CredentialEntity] to store associated to the identity
  ///
  /// The [genesisDid] is the unique id of the identity
  ///
  /// The [privateKey] is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<List<CredentialEntity>> saveClaims({
    required List<CredentialEntity> claims,
    required String genesisDid,
    required String privateKey,
  });

  /// Get a stored [CredentialEntity] associated to the identity by the genesis DID.
  /// The [credentialId] is the unique id of the credential to get.
  /// The [genesisDid] is the unique id of the identity.
  /// The [privateKey] is the key used to access all the sensitive info from the identity.
  Future<CredentialEntity>? getCredentialById({
    required String credentialId,
    required String genesisDid,
    required String privateKey,
  });

  /// Get a stored [CredentialEntity] associated to the identity by the partial credential id.
  /// The [partialCredentialId] is a partial unique id of the credential to get.
  /// The [genesisDid] is the unique id of the identity.
  /// The [privateKey] is the key used to access all the sensitive info from the identity.
  Future<CredentialEntity>? getCredentialByPartialId({
    required String partialCredentialId,
    required String genesisDid,
    required String privateKey,
  });

  /// Get a list of [CredentialEntity] associated to the identity previously stored
  /// in the the Polygon ID Sdk.
  ///
  /// The list can be filtered by [filters]
  ///
  /// The [genesisDid] is the unique id of the identity
  ///
  /// The [privateKey] is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<List<CredentialEntity>> getClaims({
    List<FilterEntity>? filters,
    required String genesisDid,
    required String privateKey,
    List<CredentialSortOrder> credentialSortOrderList,
  });

  /// Get a list of [CredentialEntity] filtered by ids associated to the identity previously stored
  /// in the the Polygon ID Sdk.
  ///
  /// The [claimIds] is a list of claim ids to filter by
  ///
  /// The [genesisDid] is the unique id of the identity
  ///
  /// The [privateKey] is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<List<CredentialEntity>> getClaimsByIds({
    required List<String> claimIds,
    required String genesisDid,
    required String privateKey,
  });

  /// Get the revocation status of a [CredentialEntity] associated to the identity previously stored
  /// in the the Polygon ID SDK.
  Future<Map<String, dynamic>> getClaimRevocationStatus({
    required String claimId,
    required String genesisDid,
    required String privateKey,
  });

  /// Check the revocation status of a [CredentialEntity].
  Future<bool> credentialStatusCheck({required CredentialEntity credential});

  /// Remove a list of [CredentialEntity] filtered by ids associated to the identity previously stored
  /// in the the Polygon ID Sdk
  ///
  /// The [claimIds] is a list of claim ids to filter by
  ///
  /// The [genesisDid] is the unique id of the identity
  ///
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<void> removeClaims({
    required List<String> claimIds,
    required String genesisDid,
    required String privateKey,
  });

  /// Remove a [CredentialEntity] filtered by id associated to the identity previously stored
  /// in the the Polygon ID Sdk
  ///
  /// The [claimId] is a claim id to filter by
  ///
  /// The [genesisDid] is the unique id of the identity
  ///
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<void> removeClaim({
    required String claimId,
    required String genesisDid,
    required String privateKey,
  });

  /// Update a [CredentialEntity] filtered by id associated to the identity previously stored
  /// in the the Polygon ID Sdk
  ///
  /// The [claimId] is the unique id of the claim to update.
  ///
  /// The [genesisDid] is the unique id of the identity.
  ///
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs.
  ///
  /// [data] could be subject to validation by the data layer
  Future<CredentialEntity> updateClaim({
    required String claimId,
    required String genesisDid,
    required String privateKey,
    String? issuer,
    CredentialState? state,
    String? expiration,
    String? type,
    Map<String, dynamic>? data,
  });

  /// Refresh a [CredentialEntity] associated to the identity previously stored
  /// in the the Polygon ID SDK. This method will update the claim with the latest
  /// state from refresh service.
  /// The [credential] is the credential to refresh.
  /// The [genesisDid] is the unique id of the identity.
  /// The [privateKey]  is the key used to access all the sensitive info from the identity.
  /// Returns the refreshed credential.
  Future<CredentialEntity> refreshCredential({
    required CredentialEntity credential,
    required String genesisDid,
    required String privateKey,
    required List<JsonWebKey> keys,
  });

  /// Cache a [CredentialEntity] associated to the identity previously stored to speed up
  /// underlying PolygonID native libraries operations.
  /// The [credential] is the credential to cache.
  Future<void> cacheCredential({
    required CredentialEntity credential,
    EnvConfigEntity? configParam,
  });

  /// Cache a list of [CredentialEntity] associated to the identity previously stored to speed up
  /// underlying PolygonID native libraries operations.
  /// The [credentials] is the list of credentials to cache.
  Future<void> cacheCredentials({
    required List<CredentialEntity> credentials,
    EnvConfigEntity? configParam,
  });

  /// Clean the credentials cache to remove all cached credentials.
  Future<void> cleanCredentialsCache({EnvConfigEntity? configParam});
}

@injectable
class Credential implements PolygonIdSdkCredential {
  final SaveClaimsUseCase _saveClaimsUseCase;
  final GetClaimsUseCase _getClaimsUseCase;
  final GetClaimRevocationStatusUseCase _getClaimRevocationStatusUseCase;
  final CredentialStatusCheckUseCase _credentialStatusCheckUseCase;
  final RemoveClaimsUseCase _removeClaimsUseCase;
  final UpdateClaimUseCase _updateClaimUseCase;
  final StacktraceManager _stacktraceManager;
  final RefreshCredentialUseCase _refreshCredentialUseCase;
  final GetCredentialByIdUseCase _getCredentialByIdUseCase;
  final GetCredentialByPartialIdUseCase _getCredentialByPartialIdUseCase;
  final CacheCredentialsUseCase _cacheCredentialsUseCase;
  final CacheCredentialUseCase _cacheCredentialUseCase;
  final CleanCredentialCacheUseCase _cleanCredentialCacheUseCase;

  Credential(
    this._saveClaimsUseCase,
    this._getClaimsUseCase,
    this._removeClaimsUseCase,
    this._getClaimRevocationStatusUseCase,
    this._credentialStatusCheckUseCase,
    this._updateClaimUseCase,
    this._stacktraceManager,
    this._refreshCredentialUseCase,
    this._getCredentialByIdUseCase,
    this._getCredentialByPartialIdUseCase,
    this._cacheCredentialsUseCase,
    this._cacheCredentialUseCase,
    this._cleanCredentialCacheUseCase,
  );

  @override
  Future<List<CredentialEntity>> saveClaims({
    required List<CredentialEntity> claims,
    required String genesisDid,
    required String privateKey,
  }) {
    _stacktraceManager.clear();
    _stacktraceManager.addTrace("PolygonIdSdk.Credential.saveClaims called");
    return _saveClaimsUseCase.execute(
      param: SaveClaimsParam(
        claims: claims,
        genesisDid: genesisDid,
        encryptionKey: privateKey,
      ),
    );
  }

  @override
  Future<CredentialEntity> getCredentialById({
    required String credentialId,
    required String genesisDid,
    required String privateKey,
  }) {
    _stacktraceManager.clear();
    _stacktraceManager.addTrace(
      "PolygonIdSdk.Credential.getCredentialById called",
    );
    return _getCredentialByIdUseCase.execute(
      param: GetCredentialByIdParam(
        genesisDid: genesisDid,
        encryptionKey: privateKey,
        id: credentialId,
      ),
    );
  }

  @override
  Future<CredentialEntity> getCredentialByPartialId({
    required String partialCredentialId,
    required String genesisDid,
    required String privateKey,
  }) {
    _stacktraceManager.clear();
    _stacktraceManager.addTrace(
      "PolygonIdSdk.Credential.getCredentialByPartialId called",
    );
    return _getCredentialByPartialIdUseCase.execute(
      param: GetCredentialByPartialIdParam(
        genesisDid: genesisDid,
        encryptionKey: privateKey,
        partialId: partialCredentialId,
      ),
    );
  }

  @override
  Future<List<CredentialEntity>> getClaims({
    List<FilterEntity>? filters,
    required String genesisDid,
    required String privateKey,
    List<CredentialSortOrder> credentialSortOrderList = const [],
  }) {
    _stacktraceManager.clear();
    _stacktraceManager.addTrace("PolygonIdSdk.Credential.getClaims called");
    return _getClaimsUseCase.execute(
      param: GetClaimsParam(
        filters: filters,
        genesisDid: genesisDid,
        profileNonce: GENESIS_PROFILE_NONCE,
        encryptionKey: privateKey,
        credentialSortOrderList: credentialSortOrderList,
      ),
    );
  }

  @override
  Future<List<CredentialEntity>> getClaimsByIds({
    required List<String> claimIds,
    required String genesisDid,
    required String privateKey,
  }) {
    _stacktraceManager.clear();
    _stacktraceManager.addTrace(
      "PolygonIdSdk.Credential.getClaimsByIds called",
    );
    return _getClaimsUseCase.execute(
      param: GetClaimsParam(
        filters: [
          FilterEntity(
            operator: FilterOperator.inList,
            name: 'id',
            value: claimIds,
          ),
        ],
        genesisDid: genesisDid,
        profileNonce: GENESIS_PROFILE_NONCE,
        encryptionKey: privateKey,
      ),
    );
  }

  @override
  Future<Map<String, dynamic>> getClaimRevocationStatus({
    required String claimId,
    required String genesisDid,
    required String privateKey,
    Map<String, dynamic>? nonRevProof,
  }) async {
    _stacktraceManager.clear();
    _stacktraceManager.addTrace(
      "PolygonIdSdk.Credential.getClaimRevocationStatus called",
    );
    List<CredentialEntity> claimEntityList = await getClaimsByIds(
      claimIds: [claimId],
      genesisDid: genesisDid,
      privateKey: privateKey,
    );
    if (claimEntityList.isNotEmpty) {
      return _getClaimRevocationStatusUseCase.execute(
        param: GetClaimRevocationStatusParam(
          claim: claimEntityList[0],
          nonRevProof: nonRevProof,
        ),
      );
    } else {
      _stacktraceManager.addError("Claim not found");
      throw CredentialNotFoundException(
        id: claimId,
        errorMessage: "Claim not found",
      );
    }
  }

  @override
  Future<bool> credentialStatusCheck({
    required CredentialEntity credential,
  }) async {
    _stacktraceManager.clear();
    _stacktraceManager.addTrace(
      "PolygonIdSdk.Credential.credentialStatusCheck called",
    );

    return _credentialStatusCheckUseCase.execute(param: credential);
  }

  @override
  Future<void> removeClaims({
    required List<String> claimIds,
    required String genesisDid,
    required String privateKey,
  }) {
    _stacktraceManager.clear();
    _stacktraceManager.addTrace("PolygonIdSdk.Credential.removeClaims called");
    return _removeClaimsUseCase.execute(
      param: RemoveClaimsParam(
        claimIds: claimIds,
        genesisDid: genesisDid,
        encryptionKey: privateKey,
      ),
    );
  }

  @override
  Future<void> removeClaim({
    required String claimId,
    required String genesisDid,
    required String privateKey,
  }) {
    _stacktraceManager.clear();
    _stacktraceManager.addTrace("PolygonIdSdk.Credential.removeClaim called");
    return _removeClaimsUseCase.execute(
      param: RemoveClaimsParam(
        claimIds: [claimId],
        genesisDid: genesisDid,
        encryptionKey: privateKey,
      ),
    );
  }

  @override
  Future<CredentialEntity> updateClaim({
    required String claimId,
    String? issuer,
    required String genesisDid,
    CredentialState? state,
    String? expiration,
    String? type,
    Map<String, dynamic>? data,
    required String privateKey,
  }) {
    _stacktraceManager.clear();
    _stacktraceManager.addTrace("PolygonIdSdk.Credential.updateClaim called");
    return _updateClaimUseCase.execute(
      param: UpdateClaimParam(
        id: claimId,
        issuer: issuer,
        genesisDid: genesisDid,
        state: state,
        expiration: expiration,
        type: type,
        data: data,
        encryptionKey: privateKey,
      ),
    );
  }

  @override
  Future<CredentialEntity> refreshCredential({
    required String genesisDid,
    required String privateKey,
    required CredentialEntity credential,
    required List<JsonWebKey> keys,
  }) {
    return _refreshCredentialUseCase.execute(
      param: RefreshCredentialParam(
        credential: credential,
        genesisDid: genesisDid,
        privateKey: privateKey,
        keys: keys,
      ),
    );
  }

  @override
  Future<void> cacheCredential({
    required CredentialEntity credential,
    EnvConfigEntity? configParam,
  }) {
    return _cacheCredentialUseCase.execute(
      param: CacheCredentialParam(credential: credential, config: configParam),
    );
  }

  @override
  Future<void> cacheCredentials({
    required List<CredentialEntity> credentials,
    EnvConfigEntity? configParam,
  }) {
    return _cacheCredentialsUseCase.execute(
      credentials: credentials,
      configParam: configParam,
    );
  }

  @override
  Future<void> cleanCredentialsCache({EnvConfigEntity? configParam}) {
    return _cleanCredentialCacheUseCase.execute(param: configParam);
  }
}
