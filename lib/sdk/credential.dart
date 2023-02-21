import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/remove_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/update_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/offer/offer_iden3_message_entity.dart';

import '../credential/domain/use_cases/save_claims_use_case.dart';

abstract class PolygonIdSdkCredential {
  /// Stores in the the Polygon ID Sdk a list of [ClaimEntity] associated to
  /// the identity
  ///
  /// The [claims] is the list of [ClaimEntity] to store associated to the identity
  ///
  /// The [did] is the unique id of the identity
  ///
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<List<ClaimEntity>> saveClaims(
      {required List<ClaimEntity> claims,
      required String did,
      required String privateKey});

  /// Gets a list of [ClaimEntity] associated to the identity previously stored
  /// in the the Polygon ID Sdk
  ///
  /// The list can be filtered by [filters]
  ///
  /// The [did] is the unique id of the identity
  ///
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<List<ClaimEntity>> getClaims(
      {List<FilterEntity>? filters,
      required String did,
      required String privateKey});

  /// Gets a list of [ClaimEntity] filtered by ids associated to the identity previously stored
  /// in the the Polygon ID Sdk
  ///
  /// The [claimIds] is a list of claim ids to filter by
  ///
  /// The [did] is the unique id of the identity
  ///
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<List<ClaimEntity>> getClaimsByIds(
      {required List<String> claimIds,
      required String did,
      required String privateKey});

  /// Removes a list of [ClaimEntity] filtered by ids associated to the identity previously stored
  /// in the the Polygon ID Sdk
  ///
  /// The [claimIds] is a list of claim ids to filter by
  ///
  /// The [did] is the unique id of the identity
  ///
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<void> removeClaims(
      {required List<String> claimIds,
      required String did,
      required String privateKey});

  /// Removes a [ClaimEntity] filtered by id associated to the identity previously stored
  /// in the the Polygon ID Sdk
  ///
  /// The [claimId] is a claim id to filter by
  ///
  /// The [did] is the unique id of the identity
  ///
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<void> removeClaim(
      {required String claimId,
      required String did,
      required String privateKey});

  /// Updates a [ClaimEntity] filtered by id associated to the identity previously stored
  /// in the the Polygon ID Sdk
  ///
  /// The [claimId] is a claim id to filter by
  ///
  /// The [did] is the unique id of the identity
  ///
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  ///
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

  /// Stores in the the Polygon ID Sdk a list of [ClaimEntity] associated to
  /// the identity
  ///
  /// The [claims] is the list of [ClaimEntity] to store associated to the identity
  ///
  /// The [did] is the unique id of the identity
  ///
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  @override
  Future<List<ClaimEntity>> saveClaims(
      {required List<ClaimEntity> claims,
      required String did,
      required String privateKey}) {
    return _saveClaimsUseCase.execute(
        param:
            SaveClaimsParam(claims: claims, did: did, privateKey: privateKey));
  }

  /// Gets a list of [ClaimEntity] associated to the identity previously stored
  /// in the the Polygon ID Sdk
  ///
  /// The list can be filtered by [filters]
  ///
  /// The [did] is the unique id of the identity
  ///
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
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

  /// Gets a list of [ClaimEntity] filtered by ids associated to the identity previously stored
  /// in the the Polygon ID Sdk
  ///
  /// The [claimIds] is a list of claim ids to filter by
  ///
  /// The [did] is the unique id of the identity
  ///
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
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

  /// Removes a list of [ClaimEntity] filtered by ids associated to the identity previously stored
  /// in the the Polygon ID Sdk
  ///
  /// The [claimIds] is a list of claim ids to filter by
  ///
  /// The [did] is the unique id of the identity
  ///
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
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

  /// Removes a [ClaimEntity] filtered by id associated to the identity previously stored
  /// in the the Polygon ID Sdk
  ///
  /// The [claimId] is a claim id to filter by
  ///
  /// The [did] is the unique id of the identity
  ///
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
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

  /// Updates a [ClaimEntity] filtered by id associated to the identity previously stored
  /// in the the Polygon ID Sdk
  ///
  /// The [claimId] is a claim id to filter by
  ///
  /// The [did] is the unique id of the identity
  ///
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  ///
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
