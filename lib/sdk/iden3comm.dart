import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_request_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_base_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/offer_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/authenticate_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/clean_schema_cache_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/fetch_and_save_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_filters_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_claims_rev_nonce_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3message_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_schemas_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/add_interaction_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/get_interactions_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/remove_interactions_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/update_interaction_use_case.dart';

abstract class PolygonIdSdkIden3comm {
  /// Returns a [Iden3MessageEntity] from an iden3comm message string.
  ///
  /// The [message] is the iden3comm message in string format
  ///
  /// When communicating through iden3comm with an Issuer or Verifier,
  /// iden3comm message string needs to be parsed to a supported
  /// [Iden3MessageEntity] by the Polygon Id Sdk using this method.
  Future<Iden3MessageEntity> getIden3Message({required String message});

  /// Returns the schemas from an [Iden3MessageEntity].
  Future<List<Map<String, dynamic>>> getSchemas(
      {required Iden3MessageEntity message});

  /// Returns a list of [FilterEntity] from an iden3comm message to
  /// apply to [Credential.getClaims]
  ///
  /// The [message] is the iden3comm message entity
  Future<List<FilterEntity>> getFilters({required Iden3MessageEntity message});

  /// Fetch a list of [ClaimEntity] from issuer using iden3comm message
  /// and stores them in Polygon Id Sdk.
  ///
  /// The [message] is the iden3comm message entity
  ///
  /// The [genesisDid] is the unique id of the identity
  ///
  /// The [profileNonce] is the nonce of the profile used from identity
  /// to obtain the did identifier
  ///
  /// The [privateKey] is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<List<ClaimEntity>> fetchAndSaveClaims(
      {required Iden3MessageEntity message,
        required String genesisDid,
        BigInt? profileNonce,
        required String privateKey});

  /// Get a list of [ClaimEntity] stored in Polygon Id Sdk that fulfills
  /// the request from iden3comm message.
  ///
  /// The [message] is the iden3comm message entity
  ///
  /// The [genesisDid] is the unique id of the identity
  ///
  /// The [profileNonce] is the nonce of the profile used from identity
  /// to obtain the did identifier
  ///
  /// The [privateKey] is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<List<ClaimEntity?>> getClaimsFromIden3Message(
      {required Iden3MessageEntity message,
        required String genesisDid,
        BigInt? profileNonce,
        required String privateKey,
        Map<int, Map<String, dynamic>>? nonRevocationProofs});

  /// Get a list of [int] revocation nonces of claims stored in Polygon Id Sdk that fulfills
  /// the request from iden3comm message.
  ///
  /// The [message] is the iden3comm message entity
  ///
  /// The [genesisDid] is the unique id of the identity
  ///
  /// The [profileNonce] is the nonce of the profile used from identity
  /// to obtain the did identifier
  ///
  /// The [privateKey] is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<List<int>> getClaimsRevNonceFromIden3Message({
    required Iden3MessageEntity message,
    required String genesisDid,
    BigInt? profileNonce,
    required String privateKey,
  });

  /// Get a list of [Iden3commProofEntity] from iden3comm message
  ///
  /// The [message] is the iden3comm message entity
  ///
  /// The [genesisDid] is the unique id of the identity
  ///
  /// The [profileNonce] is the nonce of the profile used from identity
  /// to obtain the did identifier
  ///
  /// The [privateKey] is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<List<Iden3commProofEntity>> getProofs(
      {required Iden3MessageEntity message,
        required String genesisDid,
        BigInt? profileNonce,
        required String privateKey,
        String? challenge,
        String? ethereumUrl,
        String? stateContractAddr,
        String? ipfsNodeUrl,
        Map<int, Map<String, dynamic>>? nonRevocationProofs});

  /// Authenticate response from iden3Message sharing the needed
  /// (if any) proofs requested by it
  ///
  /// The [message] is the iden3comm message entity
  ///
  /// The [genesisDid] is the unique id of the identity
  ///
  /// The [profileNonce] is the nonce of the profile used from identity
  /// to obtain the did identifier
  ///
  /// The [privateKey] is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  ///
  /// The [pushToken] is the push notification registration token so the issuer/verifer
  /// can send notifications to the identity.
  Future<void> authenticate({
    required Iden3MessageEntity message,
    required String genesisDid,
    BigInt? profileNonce,
    required String privateKey,
    String? pushToken,
  });

  /// Gets a list of [InteractionEntity] associated to the identity previously stored
  /// in the the Polygon ID Sdk
  ///
  /// /// The [genesisDid] is the unique id of the identity
  ///
  /// The [profileNonce] is the nonce of the profile used from identity
  /// to obtain the did identifier
  ///
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<List<InteractionBaseEntity>> getInteractions({
    String? genesisDid,
    BigInt? profileNonce,
    String? privateKey,
    List<InteractionType>? types,
    List<InteractionState>? states,
    List<FilterEntity>? filters,
  });

  /// Saves an [InteractionBaseEntity] in the Polygon ID Sdk
  ///
  /// The [interaction] is the interaction to be saved
  /// The [genesisDid] is the unique id of the identity
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// to obtain the did identifier
  Future<InteractionBaseEntity> addInteraction({
    required InteractionBaseEntity interaction,
    String? genesisDid,
    String? privateKey,
  });

  /// Removes a list of [InteractionEntity] from the Polygon ID Sdk by their ids
  ///
  /// The [genesisDid] is the unique id of the identity
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// The [ids] is the list of ids of the interactions to be removed
  Future<void> removeInteractions({
    String? genesisDid,
    String? privateKey,
    required List<String> ids,
  });

  /// Updated the states of a [InteractionBaseEntity] in the Polygon ID Sdk
  ///
  /// The [id] is the id of the notification to be updated
  /// The [genesisDid] is the unique id of the identity
  /// The [profileNonce] is the nonce of the profile used from identity
  /// to obtain the did identifier
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// The [state] is the new state of the interaction
  Future<InteractionBaseEntity> updateInteraction({
    required String id,
    String? genesisDid,
    BigInt? profileNonce,
    String? privateKey,
    InteractionState? state,
  });

  /// Handles notifications and store them
  ///
  /// The [payload] is the notification payload
// Future<void> handleNotification({required String payload});

  Future<void> cleanSchemaCache();
}

@injectable
class Iden3comm implements PolygonIdSdkIden3comm {
  final FetchAndSaveClaimsUseCase _fetchAndSaveClaimsUseCase;
  final GetIden3MessageUseCase _getIden3MessageUseCase;
  final GetSchemasUseCase _getSchemasUseCase;
  final AuthenticateUseCase _authenticateUseCase;
  final GetFiltersUseCase _getFiltersUseCase;
  final GetIden3commClaimsUseCase _getIden3commClaimsUseCase;
  final GetIden3commClaimsRevNonceUseCase _getIden3commClaimsRevNonceUseCase;
  final GetIden3commProofsUseCase _getIden3commProofsUseCase;
  final GetInteractionsUseCase _getInteractionsUseCase;
  final AddInteractionUseCase _addInteractionUseCase;
  final RemoveInteractionsUseCase _removeInteractionsUseCase;
  final UpdateInteractionUseCase _updateInteractionUseCase;
  final CleanSchemaCacheUseCase _cleanSchemaCacheUseCase;
  final StacktraceStreamManager _stacktraceStreamManager;

  Iden3comm(this._fetchAndSaveClaimsUseCase,
      this._getIden3MessageUseCase,
      this._getSchemasUseCase,
      this._authenticateUseCase,
      this._getFiltersUseCase,
      this._getIden3commClaimsUseCase,
      this._getIden3commClaimsRevNonceUseCase,
      this._getIden3commProofsUseCase,
      this._getInteractionsUseCase,
      this._addInteractionUseCase,
      this._removeInteractionsUseCase,
      this._updateInteractionUseCase,
      this._cleanSchemaCacheUseCase,
      this._stacktraceStreamManager,);

  @override
  Future<Iden3MessageEntity> getIden3Message({required String message}) {
    _stacktraceStreamManager.clear();
    return _getIden3MessageUseCase.execute(param: message);
  }

  @override
  Future<List<Map<String, dynamic>>> getSchemas(
      {required Iden3MessageEntity message}) {
    _stacktraceStreamManager.clear();
    return _getSchemasUseCase.execute(param: message);
  }

  @override
  Future<List<FilterEntity>> getFilters({required Iden3MessageEntity message}) {
    _stacktraceStreamManager.clear();
    return _getFiltersUseCase.execute(param: message);
  }

  @override
  Future<List<ClaimEntity>> fetchAndSaveClaims(
      {required Iden3MessageEntity message,
        required String genesisDid,
        BigInt? profileNonce,
        required String privateKey}) {
    _stacktraceStreamManager.clear();
    if (message is! OfferIden3MessageEntity) {
      _stacktraceStreamManager.addTrace(
          '[fetchAndSaveClaims] Invalid message type: ${message.messageType}');
      throw InvalidIden3MsgTypeException(
          Iden3MessageType.credentialOffer, message.messageType);
    }
    return _fetchAndSaveClaimsUseCase.execute(
        param: FetchAndSaveClaimsParam(
            message: message,
            genesisDid: genesisDid,
            profileNonce: profileNonce ?? GENESIS_PROFILE_NONCE,
            privateKey: privateKey));
  }

  @override
  Future<List<ClaimEntity?>> getClaimsFromIden3Message(
      {required Iden3MessageEntity message,
        required String genesisDid,
        BigInt? profileNonce,
        required String privateKey,
        Map<int, Map<String, dynamic>>? nonRevocationProofs}) {
    _stacktraceStreamManager.clear();
    return _getIden3commClaimsUseCase.execute(
        param: GetIden3commClaimsParam(
          message: message,
          genesisDid: genesisDid,
          profileNonce: profileNonce ?? GENESIS_PROFILE_NONCE,
          privateKey: privateKey,
          nonRevocationProofs: nonRevocationProofs ?? {},
        ));
  }

  @override
  Future<List<int>> getClaimsRevNonceFromIden3Message({
    required Iden3MessageEntity message,
    required String genesisDid,
    BigInt? profileNonce,
    required String privateKey,
  }) {
    _stacktraceStreamManager.clear();
    return _getIden3commClaimsRevNonceUseCase.execute(
        param: GetIden3commClaimsRevNonceParam(
          message: message,
          genesisDid: genesisDid,
          profileNonce: profileNonce ?? GENESIS_PROFILE_NONCE,
          privateKey: privateKey,
        ));
  }

  @override
  Future<List<Iden3commProofEntity>> getProofs(
      {required Iden3MessageEntity message,
        required String genesisDid,
        BigInt? profileNonce,
        required String privateKey,
        String? challenge,
        String? ethereumUrl,
        String? stateContractAddr,
        String? ipfsNodeUrl,
        Map<int, Map<String, dynamic>>? nonRevocationProofs}) {
    _stacktraceStreamManager.clear();
    return _getIden3commProofsUseCase.execute(
        param: GetIden3commProofsParam(
          message: message,
          genesisDid: genesisDid,
          profileNonce: profileNonce ?? GENESIS_PROFILE_NONCE,
          privateKey: privateKey,
          challenge: challenge,
          ethereumUrl: ethereumUrl,
          stateContractAddr: stateContractAddr,
          ipfsNodeUrl: ipfsNodeUrl,
          nonRevocationProofs: nonRevocationProofs,
        ));
  }

  @override
  Future<void> authenticate({
    required Iden3MessageEntity message,
    required String genesisDid,
    BigInt? profileNonce,
    required String privateKey,
    String? pushToken,
    Map<int, Map<String, dynamic>>? nonRevocationProofs,
  }) {
    _stacktraceStreamManager.clear();
    if (message is! AuthIden3MessageEntity) {
      _stacktraceStreamManager.addTrace(
          '[authenticate] Invalid message type: ${message.messageType}');
      throw InvalidIden3MsgTypeException(
          Iden3MessageType.authRequest, message.messageType);
    }

    return _authenticateUseCase.execute(
        param: AuthenticateParam(
          message: message,
          genesisDid: genesisDid,
          profileNonce: profileNonce ?? GENESIS_PROFILE_NONCE,
          privateKey: privateKey,
          pushToken: pushToken,
          nonRevocationProofs: nonRevocationProofs,
        ));
  }

  @override
  Future<List<InteractionBaseEntity>> getInteractions({
    String? genesisDid,
    BigInt? profileNonce,
    String? privateKey,
    List<InteractionType>? types,
    List<InteractionState>? states,
    List<FilterEntity>? filters,
  }) {
    _stacktraceStreamManager.clear();
    return _getInteractionsUseCase.execute(
        param: GetInteractionsParam(
          genesisDid: genesisDid,
          profileNonce: profileNonce ?? GENESIS_PROFILE_NONCE,
          privateKey: privateKey,
          types: types,
          filters: filters,
        ));
  }

  @override
  Future<void> removeInteractions({
    String? genesisDid,
    String? privateKey,
    required List<String> ids,
  }) {
    _stacktraceStreamManager.clear();
    return _removeInteractionsUseCase.execute(
        param: RemoveInteractionsParam(
            genesisDid: genesisDid, privateKey: privateKey, ids: ids));
  }

  @override
  Future<InteractionBaseEntity> addInteraction({
    required InteractionBaseEntity interaction,
    String? genesisDid,
    String? privateKey,
  }) {
    _stacktraceStreamManager.clear();
    return _addInteractionUseCase.execute(
        param: AddInteractionParam(
            genesisDid: genesisDid,
            privateKey: privateKey,
            interaction: interaction));
  }

  @override
  Future<InteractionBaseEntity> updateInteraction({
    required String id,
    String? genesisDid,
    BigInt? profileNonce,
    String? privateKey,
    InteractionState? state,
  }) {
    _stacktraceStreamManager.clear();
    return _updateInteractionUseCase.execute(
        param: UpdateInteractionParam(
          genesisDid: genesisDid,
          profileNonce: profileNonce ?? GENESIS_PROFILE_NONCE,
          privateKey: privateKey,
          id: id,
          state: state,
        ));
  }

  @override
  Future<void> cleanSchemaCache() {
    return _cleanSchemaCacheUseCase.execute(param: null);
  }

  ///
  Stream<String> stacktraceStream() {
    return _stacktraceStreamManager.stacktraceStream;
  }

  ///
  void switchStacktrace({bool enabled = false}) {
    _stacktraceStreamManager.isEnabled = enabled;
  }

  ///
  String getStacktrace() {
    return _stacktraceStreamManager.stacktrace;
  }
}
