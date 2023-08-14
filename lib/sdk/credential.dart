import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claim_revocation_status_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/remove_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/update_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';

import '../credential/domain/use_cases/save_claims_use_case.dart';

abstract class PolygonIdSdkCredential {
  /// Store in the the Polygon ID Sdk a list of [ClaimEntity] associated to
  /// the identity.
  ///
  /// The [claims] is the list of [ClaimEntity] to store associated to the identity
  ///
  /// The [genesisDid] is the unique id of the identity
  ///
  /// The [privateKey] is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<List<ClaimEntity>> saveClaims(
      {required List<ClaimEntity> claims,
      required String genesisDid,
      required String privateKey});

  /// Get a list of [ClaimEntity] associated to the identity previously stored
  /// in the the Polygon ID Sdk.
  ///
  /// The list can be filtered by [filters]
  ///
  /// The [genesisDid] is the unique id of the identity
  ///
  /// The [privateKey] is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<List<ClaimEntity>> getClaims(
      {List<FilterEntity>? filters,
      required String genesisDid,
      required String privateKey});

  /// Get a list of [ClaimEntity] filtered by ids associated to the identity previously stored
  /// in the the Polygon ID Sdk.
  ///
  /// The [claimIds] is a list of claim ids to filter by
  ///
  /// The [genesisDid] is the unique id of the identity
  ///
  /// The [privateKey] is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<List<ClaimEntity>> getClaimsByIds(
      {required List<String> claimIds,
      required String genesisDid,
      required String privateKey});

  Future<Map<String, dynamic>> getClaimRevocationStatus(
      {required String claimId,
      required String genesisDid,
      required String privateKey});

  /// Remove a list of [ClaimEntity] filtered by ids associated to the identity previously stored
  /// in the the Polygon ID Sdk
  ///
  /// The [claimIds] is a list of claim ids to filter by
  ///
  /// The [genesisDid] is the unique id of the identity
  ///
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<void> removeClaims(
      {required List<String> claimIds,
      required String genesisDid,
      required String privateKey});

  /// Remove a [ClaimEntity] filtered by id associated to the identity previously stored
  /// in the the Polygon ID Sdk
  ///
  /// The [claimId] is a claim id to filter by
  ///
  /// The [genesisDid] is the unique id of the identity
  ///
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<void> removeClaim(
      {required String claimId,
      required String genesisDid,
      required String privateKey});

  /// Update a [ClaimEntity] filtered by id associated to the identity previously stored
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
  Future<ClaimEntity> updateClaim({
    required String claimId,
    required String genesisDid,
    required String privateKey,
    String? issuer,
    ClaimState? state,
    String? expiration,
    String? type,
    Map<String, dynamic>? data,
  });
}

@injectable
class Credential implements PolygonIdSdkCredential {
  final SaveClaimsUseCase _saveClaimsUseCase;
  final GetClaimsUseCase _getClaimsUseCase;
  final GetClaimRevocationStatusUseCase _getClaimRevocationStatusUseCase;
  final RemoveClaimsUseCase _removeClaimsUseCase;
  final UpdateClaimUseCase _updateClaimUseCase;
  final StacktraceManager _stacktraceManager;

  Credential(
    this._saveClaimsUseCase,
    this._getClaimsUseCase,
    this._removeClaimsUseCase,
    this._getClaimRevocationStatusUseCase,
    this._updateClaimUseCase,
    this._stacktraceManager,
  );

  @override
  Future<List<ClaimEntity>> saveClaims(
      {required List<ClaimEntity> claims,
      required String genesisDid,
      required String privateKey}) {
    _stacktraceManager.clear();
    _stacktraceManager.addTrace("PolygonIdSdk.Credential.saveClaims called");
    return _saveClaimsUseCase.execute(
        param: SaveClaimsParam(
            claims: claims, genesisDid: genesisDid, privateKey: privateKey));
  }

  @override
  Future<List<ClaimEntity>> getClaims(
      {List<FilterEntity>? filters,
      required String genesisDid,
      required String privateKey}) {
    _stacktraceManager.clear();
    _stacktraceManager.addTrace("PolygonIdSdk.Credential.getClaims called");
    return _getClaimsUseCase.execute(
        param: GetClaimsParam(
      filters: filters,
      genesisDid: genesisDid,
      profileNonce: GENESIS_PROFILE_NONCE,
      privateKey: privateKey,
    ));
  }

  @override
  Future<List<ClaimEntity>> getClaimsByIds(
      {required List<String> claimIds,
      required String genesisDid,
      required String privateKey}) {
    _stacktraceManager.clear();
    _stacktraceManager
        .addTrace("PolygonIdSdk.Credential.getClaimsByIds called");
    return _getClaimsUseCase.execute(
        param: GetClaimsParam(
      filters: [
        FilterEntity(
            operator: FilterOperator.inList, name: 'id', value: claimIds)
      ],
      genesisDid: genesisDid,
      profileNonce: GENESIS_PROFILE_NONCE,
      privateKey: privateKey,
    ));
  }

  @override
  Future<Map<String, dynamic>> getClaimRevocationStatus({
    required String claimId,
    required String genesisDid,
    required String privateKey,
    Map<String, dynamic>? nonRevProof,
  }) async {
    _stacktraceManager.clear();
    _stacktraceManager
        .addTrace("PolygonIdSdk.Credential.getClaimRevocationStatus called");
    List<ClaimEntity> claimEntityList = await getClaimsByIds(
        claimIds: [claimId], genesisDid: genesisDid, privateKey: privateKey);
    if (claimEntityList.isNotEmpty) {
      return _getClaimRevocationStatusUseCase.execute(
          param: GetClaimRevocationStatusParam(
        claim: claimEntityList[0],
        nonRevProof: nonRevProof,
      ));
    } else {
      _stacktraceManager.addTrace(
          "PolygonIdSdk.Credential.getClaimRevocationStatus claim not found");
      throw ClaimNotFoundException(claimId);
    }
  }

  @override
  Future<void> removeClaims(
      {required List<String> claimIds,
      required String genesisDid,
      required String privateKey}) {
    _stacktraceManager.clear();
    _stacktraceManager.addTrace("PolygonIdSdk.Credential.removeClaims called");
    return _removeClaimsUseCase.execute(
        param: RemoveClaimsParam(
      claimIds: claimIds,
      genesisDid: genesisDid,
      privateKey: privateKey,
    ));
  }

  @override
  Future<void> removeClaim(
      {required String claimId,
      required String genesisDid,
      required String privateKey}) {
    _stacktraceManager.clear();
    _stacktraceManager.addTrace("PolygonIdSdk.Credential.removeClaim called");
    return _removeClaimsUseCase.execute(
        param: RemoveClaimsParam(
      claimIds: [claimId],
      genesisDid: genesisDid,
      privateKey: privateKey,
    ));
  }

  @override
  Future<ClaimEntity> updateClaim({
    required String claimId,
    String? issuer,
    required String genesisDid,
    ClaimState? state,
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
            privateKey: privateKey));
  }
}
