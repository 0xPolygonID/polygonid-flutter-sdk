import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/add_did_profile_info_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/generate_non_rev_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_auth_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claim_revocation_nonce_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claim_revocation_status_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_did_profile_info_list_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_did_profile_info_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_non_rev_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/remove_all_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/remove_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/remove_did_profile_info_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/save_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/update_claim_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/get_profiles_use_case.dart';

@injectable
class CredentialUsecases {
  final AddDidProfileInfoUseCase _addDidProfileInfoUseCase;
  final GenerateNonRevProofUseCase _generateNonRevProofUseCase;
  final GetAuthClaimUseCase _getAuthClaimUseCase;
  final GetClaimRevocationNonceUseCase _getClaimRevocationNonceUseCase;
  final GetClaimRevocationStatusUseCase _getClaimRevocationStatusUseCase;
  final GetClaimsUseCase _getClaimsUseCase;
  final GetDidProfileInfoListUseCase _getDidProfileInfoListUseCase;
  final GetDidProfileInfoUseCase _getDidProfileInfoUseCase;
  final GetNonRevProofUseCase _getNonRevProofUseCase;
  final RemoveAllClaimsUseCase _removeAllClaimsUseCase;
  final RemoveClaimsUseCase _removeClaimsUseCase;
  final RemoveDidProfileInfoUseCase _removeDidProfileInfoUseCase;
  final SaveClaimsUseCase _saveClaimsUseCase;
  final UpdateClaimUseCase _updateClaimUseCase;

  CredentialUsecases(
    this._addDidProfileInfoUseCase,
    this._generateNonRevProofUseCase,
    this._getAuthClaimUseCase,
    this._getClaimRevocationNonceUseCase,
    this._getClaimRevocationStatusUseCase,
    this._getClaimsUseCase,
    this._getDidProfileInfoListUseCase,
    this._getDidProfileInfoUseCase,
    this._getNonRevProofUseCase,
    this._removeAllClaimsUseCase,
    this._removeClaimsUseCase,
    this._removeDidProfileInfoUseCase,
    this._saveClaimsUseCase,
    this._updateClaimUseCase,
  );

  Future<void> addDidProfileInfo(AddDidProfileInfoParam param) {
    return _addDidProfileInfoUseCase.execute(param: param);
  }

  Future<Map<String, dynamic>> generateNonRevProof(
      GenerateNonRevProofParam param) {
    return _generateNonRevProofUseCase.execute(param: param);
  }

  Future<List<String>> getAuthClaim(List<String> publicKey) {
    return _getAuthClaimUseCase.execute(param: publicKey);
  }

  Future<int> getClaimRevocationNonce(ClaimEntity claimId) {
    return _getClaimRevocationNonceUseCase.execute(param: claimId);
  }

  Future<Map<String, dynamic>> getClaimRevocationStatus(
      GetClaimRevocationStatusParam param) {
    return _getClaimRevocationStatusUseCase.execute(param: param);
  }

  Future<List<ClaimEntity>> getClaims(GetClaimsParam param) {
    return _getClaimsUseCase.execute(param: param);
  }

  Future<List<Map<String, dynamic>>> getDidProfileInfoList(
      GetDidProfileInfoListParam param) {
    return _getDidProfileInfoListUseCase.execute(param: param);
  }

  Future<Map<String, dynamic>> getDidProfileInfo(
      GetDidProfileInfoParam param) {
    return _getDidProfileInfoUseCase.execute(param: param);
  }

  Future<Map<String, dynamic>> getNonRevProof(ClaimEntity claim) {
    return _getNonRevProofUseCase.execute(param: claim);
  }

  Future<void> removeAllClaims(RemoveAllClaimsParam param) {
    return _removeAllClaimsUseCase.execute(param: param);
  }

  Future<void> removeClaims(RemoveClaimsParam param) {
    return _removeClaimsUseCase.execute(param: param);
  }

  Future<void> removeDidProfileInfo(RemoveDidProfileInfoParam param) {
    return _removeDidProfileInfoUseCase.execute(param: param);
  }

  Future<List<ClaimEntity>> saveClaims(SaveClaimsParam param) {
    return _saveClaimsUseCase.execute(param: param);
  }

  Future<ClaimEntity> updateClaim(UpdateClaimParam param) {
    return _updateClaimUseCase.execute(param: param);
  }
}
