import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/domain/common/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/domain/credential/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/domain/credential/entities/credential_request_entity.dart';
import 'package:polygonid_flutter_sdk/domain/credential/use_cases/fetch_and_save_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/domain/credential/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/domain/credential/use_cases/remove_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/domain/credential/use_cases/update_claim_use_case.dart';

@injectable
class CredentialWallet {
  final FetchAndSaveClaimsUseCase _fetchAndSaveClaimsUseCase;
  final GetClaimsUseCase _getClaimsUseCase;
  final RemoveClaimsUseCase _removeClaimsUseCase;
  final UpdateClaimUseCase _updateClaimUseCase;

  CredentialWallet(this._fetchAndSaveClaimsUseCase, this._getClaimsUseCase,
      this._removeClaimsUseCase, this._updateClaimUseCase);

  /// Fetch a list of [ClaimEntity] and store them
  Future<List<ClaimEntity>> fetchAndSaveClaims(
      {required List<CredentialRequestEntity> credentialRequests}) {
    return _fetchAndSaveClaimsUseCase.execute(param: credentialRequests);
  }

  /// Get a list of [ClaimEntity] from storage
  /// The list can be filtered by [filters]
  Future<List<ClaimEntity>> getClaims({List<FilterEntity>? filters}) {
    return _getClaimsUseCase.execute(param: filters);
  }

  /// Get a list of [ClaimEntity] from storage from a list of id
  /// This is a shortcut to [getClaims], using a filter on id
  Future<List<ClaimEntity>> getClaimsByIds({required List<String> ids}) {
    return _getClaimsUseCase.execute(param: [
      FilterEntity(operator: FilterOperator.inList, name: 'id', value: ids)
    ]);
  }

  /// Remove Claims from storage from a list of id
  Future<void> removeClaims({required List<String> ids}) {
    return _removeClaimsUseCase.execute(param: ids);
  }

  /// Remove a Claim from storage by id
  /// This is a shortcut of [removeClaims] with only one id
  Future<void> removeClaim({required String id}) {
    return _removeClaimsUseCase.execute(param: [id]);
  }

  /// Update the Claim associated to the [id] in storage
  /// Be aware only the [ClaimEntity.data] will be updated
  /// and [data] is subject to validation by the data layer
  Future<ClaimEntity> updateClaim({
    required String id,
    String? issuer,
    String? identifier,
    ClaimState? state,
    String? expiration,
    String? type,
    Map<String, dynamic>? data,
  }) {
    return _updateClaimUseCase.execute(
        param: UpdateClaimParam(
            id, issuer, identifier, state, expiration, type, data));
  }
}
