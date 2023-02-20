import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/remove_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/update_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/offer/offer_iden3_message_entity.dart';

import '../credential/domain/use_cases/save_claims_use_case.dart';

abstract class PolygonIdSdkCredential {

  /// Store a list of [ClaimEntity] of the identity
  Future<List<ClaimEntity>> saveClaims(
      {required List<ClaimEntity> claims,
        required String did,
        required String privateKey});

  /// Get a list of [ClaimEntity] of the identity from storage
  /// The list can be filtered by [filters]
  Future<List<ClaimEntity>> getClaims(
      {List<FilterEntity>? filters,
      required String did,
      required String privateKey});

  /// Get a list of [ClaimEntity] of the identity from storage from a list of id
  /// This is a shortcut to [getClaims], using a filter on id
  Future<List<ClaimEntity>> getClaimsByIds(
      {required List<String> claimIds,
      required String did,
      required String privateKey});

  /// Remove Claims from storage from a list of ids
  Future<void> removeClaims(
      {required List<String> claimIds,
      required String did,
      required String privateKey});

  /// Remove a Claim from storage by id
  /// This is a shortcut of [removeClaims] with only one id
  Future<void> removeClaim(
      {required String claimId,
      required String did,
      required String privateKey});

  /// Update the Claim associated to the [claimId] in storage
  /// Be aware only the [ClaimEntity.info] will be updated
  /// and [data] is subject to validation by the data layer
  Future<ClaimEntity> updateClaim({
    required String claimId,
    String? issuer,
    required String did,
    ClaimState? state,
    String? expiration,
    String? type,
    Map<String, dynamic>? data,
    required String privateKey,
  });
}

@injectable
class Credential implements PolygonIdSdkCredential {
  final SaveClaimsUseCase _saveClaimsUseCase;
  final GetClaimsUseCase _getClaimsUseCase;
  final RemoveClaimsUseCase _removeClaimsUseCase;
  final UpdateClaimUseCase _updateClaimUseCase;

  Credential(
    this._saveClaimsUseCase,
    this._getClaimsUseCase,
    this._removeClaimsUseCase,
    this._updateClaimUseCase,
  );

  /// store a list of [ClaimEntity] of the identity
  @override
  Future<List<ClaimEntity>> saveClaims({
    required List<ClaimEntity> claims,
    required String did,
    required String privateKey}) {
    return _saveClaimsUseCase.execute(
        param: SaveClaimsParam(
            claims: claims,
            did: did,
            privateKey: privateKey));
  }

  /// Get a list of [ClaimEntity] from storage
  /// The list can be filtered by [filters]
  @override
  Future<List<ClaimEntity>> getClaims(
      {List<FilterEntity>? filters,
      required String did,
      required String privateKey}) {
    return _getClaimsUseCase.execute(
        param: GetClaimsParam(
      filters: filters,
      did: did,
      privateKey: privateKey,
    ));
  }

  /// Get a list of [ClaimEntity] from storage from a list of id
  /// This is a shortcut to [getClaims], using a filter on id
  @override
  Future<List<ClaimEntity>> getClaimsByIds(
      {required List<String> claimIds,
      required String did,
      required String privateKey}) {
    return _getClaimsUseCase.execute(
        param: GetClaimsParam(
      filters: [
        FilterEntity(
            operator: FilterOperator.inList, name: 'id', value: claimIds)
      ],
      did: did,
      privateKey: privateKey,
    ));
  }

  /// Remove Claims from storage from a list of id
  @override
  Future<void> removeClaims(
      {required List<String> claimIds,
      required String did,
      required String privateKey}) {
    return _removeClaimsUseCase.execute(
        param: RemoveClaimsParam(
      claimIds: claimIds,
      did: did,
      privateKey: privateKey,
    ));
  }

  /// Remove a Claim from storage by id
  /// This is a shortcut of [removeClaims] with only one id
  @override
  Future<void> removeClaim(
      {required String claimId,
      required String did,
      required String privateKey}) {
    return _removeClaimsUseCase.execute(
        param: RemoveClaimsParam(
      claimIds: [claimId],
      did: did,
      privateKey: privateKey,
    ));
  }

  /// Update the Claim associated to the [claimId] in storage
  /// Be aware only the [ClaimEntity.info] will be updated
  /// and [data] is subject to validation by the data layer
  @override
  Future<ClaimEntity> updateClaim({
    required String claimId,
    String? issuer,
    required String did,
    ClaimState? state,
    String? expiration,
    String? type,
    Map<String, dynamic>? data,
    required String privateKey,
  }) {
    return _updateClaimUseCase.execute(
        param: UpdateClaimParam(
            id: claimId,
            issuer: issuer,
            did: did,
            state: state,
            expiration: expiration,
            type: type,
            data: data,
            privateKey: privateKey));
  }
}
