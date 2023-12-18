import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_request_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_base_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/authenticate_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/clean_schema_cache_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/fetch_and_save_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/generate_iden3comm_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_challenge_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_token_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_fetch_requests_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_filters_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_claims_rev_nonce_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3message_type_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3message_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_jwz_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_query_context_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_proof_query_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_schemas_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/add_interaction_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/get_interactions_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/remove_interactions_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/update_interaction_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/listen_and_store_notification_use_case.dart';

@injectable
class Iden3commUsecases {
  final AuthenticateUseCase _authenticateUseCase;
  final CheckProfileAndDidCurrentEnvUseCase
      _checkProfileAndDidCurrentEnvUseCase;
  final CleanSchemaCacheUseCase _cleanSchemaCacheUseCase;
  final FetchAndSaveClaimsUseCase _fetchAndSaveClaimsUseCase;
  final GenerateIden3commProofUseCase _generateIden3commProofUseCase;
  final GetAuthChallengeUseCase _getAuthChallengeUseCase;
  final GetAuthTokenUseCase _getAuthTokenUseCase;
  final GetFetchRequestsUseCase _getFetchRequestsUseCase;
  final GetFiltersUseCase _getFiltersUseCase;
  final GetIden3commClaimsRevNonceUseCase _getIden3commClaimsRevNonceUseCase;
  final GetIden3commClaimsUseCase _getIden3commClaimsUseCase;
  final GetIden3commProofsUseCase _getIden3commProofsUseCase;
  final GetIden3MessageTypeUseCase _getIden3MessageTypeUseCase;
  final GetIden3MessageUseCase _getIden3MessageUseCase;
  final GetJWZUseCase _getJWZUseCase;
  final GetProofQueryContextUseCase _getProofQueryContextUseCase;
  final GetProofQueryUseCase _getProofQueryUseCase;
  final GetSchemasUseCase _getSchemasUseCase;

  final AddInteractionUseCase _addInteractionUseCase;
  final GetInteractionsUseCase _getInteractionsUseCase;
  final RemoveInteractionsUseCase _removeInteractionsUseCase;
  final UpdateInteractionUseCase _updateInteractionUseCase;

  Iden3commUsecases(
    this._authenticateUseCase,
    this._checkProfileAndDidCurrentEnvUseCase,
    this._cleanSchemaCacheUseCase,
    this._fetchAndSaveClaimsUseCase,
    this._generateIden3commProofUseCase,
    this._getAuthChallengeUseCase,
    this._getAuthTokenUseCase,
    this._getFetchRequestsUseCase,
    this._getFiltersUseCase,
    this._getIden3commClaimsRevNonceUseCase,
    this._getIden3commClaimsUseCase,
    this._getIden3commProofsUseCase,
    this._getIden3MessageTypeUseCase,
    this._getIden3MessageUseCase,
    this._getJWZUseCase,
    this._getProofQueryContextUseCase,
    this._getProofQueryUseCase,
    this._getSchemasUseCase,
    this._addInteractionUseCase,
    this._getInteractionsUseCase,
    this._removeInteractionsUseCase,
    this._updateInteractionUseCase,
  );

  Future<void> authenticate(AuthenticateParam param) {
    return _authenticateUseCase.execute(param: param);
  }

  Future<void> checkProfileAndDidCurrentEnv(
      CheckProfileAndDidCurrentEnvParam param) {
    return _checkProfileAndDidCurrentEnvUseCase.execute(param: param);
  }

  Future<void> cleanSchemaCache() {
    return _cleanSchemaCacheUseCase.execute(param: null);
  }

  Future<List<ClaimEntity>> fetchAndSaveClaims(FetchAndSaveClaimsParam param) {
    return _fetchAndSaveClaimsUseCase.execute(param: param);
  }

  Future<Iden3commProofEntity> generateIden3commProof(
      GenerateIden3commProofParam param) {
    return _generateIden3commProofUseCase.execute(param: param);
  }

  Future<String> getAuthChallenge(String message) {
    return _getAuthChallengeUseCase.execute(param: message);
  }

  Future<String> getAuthToken(GetAuthTokenParam param) {
    return _getAuthTokenUseCase.execute(param: param);
  }

  Future<List<String>> getFetchRequests(GetFetchRequestsParam param) {
    return _getFetchRequestsUseCase.execute(param: param);
  }

  Future<List<FilterEntity>> getFilters(Iden3MessageEntity param) {
    return _getFiltersUseCase.execute(param: param);
  }

  Future<List<int>> getIden3commClaimsRevNonce(
      GetIden3commClaimsRevNonceParam param) {
    return _getIden3commClaimsRevNonceUseCase.execute(param: param);
  }

  Future<List<ClaimEntity?>> getIden3commClaims(GetIden3commClaimsParam param) {
    return _getIden3commClaimsUseCase.execute(param: param);
  }

  Future<List<Iden3commProofEntity>> getIden3commProofs(
      GetIden3commProofsParam param) {
    return _getIden3commProofsUseCase.execute(param: param);
  }

  Future<Iden3MessageType> getIden3MessageType(String message) {
    return _getIden3MessageTypeUseCase.execute(param: message);
  }

  Future<Iden3MessageEntity> getIden3Message(String message) {
    return _getIden3MessageUseCase.execute(param: message);
  }

  Future<String> getJWZ(GetJWZParam param) {
    return _getJWZUseCase.execute(param: param);
  }

  Future<Map<String, dynamic>> getProofQueryContext(ProofScopeRequest param) {
    return _getProofQueryContextUseCase.execute(param: param);
  }

  Future<ProofQueryParamEntity> getProofQuery(ProofScopeRequest param) {
    return _getProofQueryUseCase.execute(param: param);
  }

  Future<List<Map<String, dynamic>>> getSchemas(Iden3MessageEntity message) {
    return _getSchemasUseCase.execute(param: message);
  }

  Future<InteractionBaseEntity> addInteraction(AddInteractionParam param) {
    return _addInteractionUseCase.execute(param: param);
  }

  Future<List<InteractionBaseEntity>> getInteractions(GetInteractionsParam param) {
    return _getInteractionsUseCase.execute(param: param);
  }

  Future<void> removeInteractions(RemoveInteractionsParam param) {
    return _removeInteractionsUseCase.execute(param: param);
  }

  Future<InteractionBaseEntity> updateInteraction(UpdateInteractionParam param) {
    return _updateInteractionUseCase.execute(param: param);
  }
}
