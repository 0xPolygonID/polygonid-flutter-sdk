import 'package:injectable/injectable.dart';

import '../common/domain/entities/filter_entity.dart';
import '../credential/domain/entities/claim_entity.dart';
import '../credential/domain/entities/credential_request_entity.dart';
import '../credential/domain/use_cases/fetch_and_save_claims_use_case.dart';
import '../credential/domain/use_cases/get_claims_use_case.dart';
import '../credential/domain/use_cases/remove_claims_use_case.dart';
import '../credential/domain/use_cases/update_claim_use_case.dart';

abstract class PolygonIdSdkCredential {
  /// Fetch a list of [ClaimEntity] and store them
  Future<List<ClaimEntity>> fetchAndSaveClaims(
      {required List<CredentialRequestEntity> credentialRequests,
      required String identifier,
      required String privateKey});

  /// Get a list of [ClaimEntity] of the identity from storage
  /// The list can be filtered by [filters]
  Future<List<ClaimEntity>> getClaims(
      {List<FilterEntity>? filters,
      required String identifier,
      required String privateKey});

  /// Get a list of [ClaimEntity] of the identity from storage from a list of id
  /// This is a shortcut to [getClaims], using a filter on id
  Future<List<ClaimEntity>> getClaimsByIds(
      {required List<String> claimIds,
      required String identifier,
      required String privateKey});

  /// Remove Claims from storage from a list of id
  Future<void> removeClaims(
      {required List<String> claimIds,
      required String identifier,
      required String privateKey});

  /// Remove a Claim from storage by id
  /// This is a shortcut of [removeClaims] with only one id
  Future<void> removeClaim(
      {required String claimId,
      required String identifier,
      required String privateKey});

  /// Update the Claim associated to the [id] in storage
  /// Be aware only the [ClaimEntity.info] will be updated
  /// and [data] is subject to validation by the data layer
  Future<ClaimEntity> updateClaim({
    required String id,
    String? issuer,
    required String identifier,
    ClaimState? state,
    String? expiration,
    String? type,
    Map<String, dynamic>? data,
    required String privateKey,
  });
}

@injectable
class Credential implements PolygonIdSdkCredential {
  final FetchAndSaveClaimsUseCase _fetchAndSaveClaimsUseCase;
  final GetClaimsUseCase _getClaimsUseCase;
  final RemoveClaimsUseCase _removeClaimsUseCase;
  final UpdateClaimUseCase _updateClaimUseCase;

  Credential(this._fetchAndSaveClaimsUseCase, this._getClaimsUseCase,
      this._removeClaimsUseCase, this._updateClaimUseCase);

  /// Fetch a list of [ClaimEntity] and store them
  Future<List<ClaimEntity>> fetchAndSaveClaims(
      {required List<CredentialRequestEntity> credentialRequests,
      required String identifier,
      required String privateKey}) {
    return _fetchAndSaveClaimsUseCase.execute(
        param: FetchAndSaveClaimsParam(
            requests: credentialRequests,
            identifier: identifier,
            privateKey: privateKey));
  }

  /// Get a list of [ClaimEntity] from storage
  /// The list can be filtered by [filters]
  Future<List<ClaimEntity>> getClaims(
      {List<FilterEntity>? filters,
      required String identifier,
      required String privateKey}) {
    return _getClaimsUseCase.execute(
        param: GetClaimsParam(
      filters: filters,
      identifier: identifier,
      privateKey: privateKey,
    ));
  }

  /// Get a list of [ClaimEntity] from storage from a list of id
  /// This is a shortcut to [getClaims], using a filter on id
  Future<List<ClaimEntity>> getClaimsByIds(
      {required List<String> claimIds,
      required String identifier,
      required String privateKey}) {
    return _getClaimsUseCase.execute(
        param: GetClaimsParam(
      filters: [
        FilterEntity(
            operator: FilterOperator.inList, name: 'id', value: claimIds)
      ],
      identifier: identifier,
      privateKey: privateKey,
    ));
  }

  /// Remove Claims from storage from a list of id
  Future<void> removeClaims(
      {required List<String> claimIds,
      required String identifier,
      required String privateKey}) {
    return _removeClaimsUseCase.execute(
        param: RemoveClaimsParam(
      claimIds: claimIds,
      identifier: identifier,
      privateKey: privateKey,
    ));
  }

  /// Remove a Claim from storage by id
  /// This is a shortcut of [removeClaims] with only one id
  Future<void> removeClaim(
      {required String claimId,
      required String identifier,
      required String privateKey}) {
    return _removeClaimsUseCase.execute(
        param: RemoveClaimsParam(
      claimIds: [claimId],
      identifier: identifier,
      privateKey: privateKey,
    ));
  }

  /// Update the Claim associated to the [id] in storage
  /// Be aware only the [ClaimEntity.info] will be updated
  /// and [data] is subject to validation by the data layer
  Future<ClaimEntity> updateClaim({
    required String id,
    String? issuer,
    required String identifier,
    ClaimState? state,
    String? expiration,
    String? type,
    Map<String, dynamic>? data,
    required String privateKey,
  }) {
    return _updateClaimUseCase.execute(
        param: UpdateClaimParam(
            id: id,
            issuer: issuer,
            identifier: identifier,
            state: state,
            expiration: expiration,
            type: type,
            data: data,
            privateKey: privateKey));
  }
}
