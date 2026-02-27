import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/package_manager/package_manager_impl.dart';
import 'package:polygonid_flutter_sdk/common/package_manager/plain_packer.dart';
import 'package:polygonid_flutter_sdk/common/utils/credential_sort_order.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_info_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/display_type/display_type.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/add_did_profile_info_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_did_profile_info_list_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_did_profile_info_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/remove_did_profile_info_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/authenticate.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/remote_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/discovery_protocol.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_request_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/base.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/discovery/disclose.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/discovery/query.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/self_issuance/self_issued_credential_params.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/iden3_message_factory.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/authenticate_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/clean_schema_cache_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/core_claim_from_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/create_anon_aadhaar_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/create_anon_aadhaar_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/create_passport_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/create_passport_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/fetch_and_save_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/fetch_credentials_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/fetch_onchain_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/fetch_schema_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_token_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_filters_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_claims_rev_nonce_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_message_requests_and_credentials.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_schemas_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/add_interaction_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/get_interactions_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/remove_interactions_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/update_interaction_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/jose/jwk.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/zkproof_entity.dart';

abstract class PolygonIdSdkIden3comm {
  /// Returns a [Iden3Message] from an iden3comm message string.
  ///
  /// The [message] is the iden3comm message in string format
  ///
  /// When communicating through iden3comm with an Issuer or Verifier,
  /// iden3comm message string needs to be parsed to a supported
  /// [Iden3Message] by the Polygon Id Sdk using this method.
  Future<Iden3Message> getIden3Message({required String message});

  /// Returns the schemas from an [Iden3Message].
  Future<List<Map<String, dynamic>>> getSchemas({
    required Iden3Message message,
  });

  /// Fetches a schema from a given [schemaUrl].
  Future<Map<String, dynamic>> fetchSchema({required String schemaUrl});

  /// Fetches a display method JSON from a given [url].
  Future<Map<String, dynamic>> fetchDisplayMethod({required String url});

  /// Fetches and parses [DisplayType] for given [DisplayMethod].
  Future<DisplayType> fetchDisplayType({required DisplayMethod displayMethod});

  /// Returns a list of [FilterEntity] from an iden3comm message to
  /// apply to [Credential.getCredentials]
  ///
  /// The [message] is the iden3comm message entity
  Future<List<FilterEntity>> getFilters({required Iden3Message message});

  /// Fetch a list of [CredentialEntity] from issuer using iden3comm message
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
  Future<List<CredentialEntity>> fetchAndSaveClaims({
    required BaseCredentialOfferMessage message,
    required String genesisDid,
    BigInt? profileNonce,
    required String privateKey,
    required List<JsonWebKey> keys,
  });

  /// Fetch a list of [CredentialEntity] from onchain contract using its address
  /// and stores them in Polygon Id Sdk.
  ///
  /// The [contractAddress] is the address of the onchain contract
  ///
  /// The [genesisDid] is the unique id of the identity
  ///
  /// The [profileNonce] is the nonce of the profile used from identity
  /// to obtain the did identifier
  ///
  /// The [privateKey] is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<List<CredentialEntity>> fetchOnchainClaims({
    required String contractAddress,
    required String genesisDid,
    BigInt? profileNonce,
    required String privateKey,
  });

  /// Get a list of [CredentialEntity] stored in Polygon Id Sdk that fulfills
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
  Future<List<CredentialEntity>> getClaimsFromIden3Message({
    required Iden3Message message,
    required String genesisDid,
    BigInt? profileNonce,
    required String privateKey,
    List<CredentialSortOrder> sortOrder,
  });

  Future<List<RequestAndCredentials>> getMessageRequestsAndCredentials({
    required Iden3Message message,
    required String genesisDid,
    BigInt? profileNonce,
    required String encryptionKey,
  });

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
    required Iden3Message message,
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
  Future<List<Iden3commProofEntity>> getProofs({
    required Iden3Message message,
    required String genesisDid,
    BigInt? profileNonce,
    required String privateKey,
    String? challenge,
    EnvConfigEntity config,
    Map<String, dynamic>? transactionData,
  });

  /// Get an [Iden3commProofEntity] for iden3comm message
  ///
  /// The [request] is the zero knowledge proof request from iden3comm message
  ///
  /// The [verifierDid] is DID of the request verifier
  ///
  /// The [genesisDid] is the unique id of the identity
  ///
  /// The [profileNonce] is the nonce of the profile used from identity
  /// to obtain the did identifier
  ///
  /// The [privateKey] is the key used to access all the sensitive info from the identity
  /// and also to realize operations like generating proofs
  Future<Iden3commProofEntity> getProof({
    required ZeroKnowledgeProofRequest request,
    required String verifierDid,
    required String genesisDid,
    BigInt? profileNonce,
    required String linkNonce,
    required String privateKey,
    String? challenge,
    EnvConfigEntity? config,
    Map<String, dynamic>? transactionData,
  });

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
  @Deprecated('Use authenticateV2')
  Future<Iden3Message?> authenticate({
    required Iden3Message message,
    required String genesisDid,
    BigInt? profileNonce,
    required String privateKey,
    String? pushToken,
    String? challenge,
  });

  Future<Iden3Message?> authenticateV2({
    required String privateKey,
    required String genesisDid,
    required BigInt profileNonce,
    required IdentityEntity identityEntity,
    required Iden3Message message,
    required EnvEntity env,
    DIDDocument? didDocument,
    String? pushToken,
    List<RequestAndCredentials>? requestsAndCreds,
    String? challenge,
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
  Future<List<InteractionEntity>> getInteractions({
    String? genesisDid,
    BigInt? profileNonce,
    String? privateKey,
    List<InteractionType>? types,
    List<InteractionState>? states,
    List<FilterEntity>? filters,
  });

  /// Saves an [InteractionEntity] in the Polygon ID Sdk
  ///
  /// The [interaction] is the interaction to be saved
  /// The [genesisDid] is the unique id of the identity
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// to obtain the did identifier
  Future<InteractionEntity> addInteraction({
    required InteractionEntity interaction,
    required String genesisDid,
    required String privateKey,
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

  /// Updated the states of a [InteractionEntity] in the Polygon ID Sdk
  ///
  /// The [id] is the id of the notification to be updated
  /// The [genesisDid] is the unique id of the identity
  /// The [profileNonce] is the nonce of the profile used from identity
  /// to obtain the did identifier
  /// The [privateKey]  is the key used to access all the sensitive info from the identity
  /// The [state] is the new state of the interaction
  Future<InteractionEntity> updateInteraction({
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

  /// Cleans the schema cache
  Future<void> cleanSchemaCache();

  /// Add info about a did we interacted with
  /// in case of backup restore we can know which dids we have interacted with
  /// and use the correct profile
  /// in the Map we actually use
  /// * [profileNonce]
  /// * [selectedProfileType]
  Future<void> addDidProfileInfo({
    required String did,
    required String privateKey,
    required String interactedWithDid,
    required Map<String, dynamic> info,
  });

  /// Get info about a did we interacted with.
  /// [did] is the did of the identity we used to interact
  /// [privateKey] is the key used to access the sensitive info
  /// [interactedWithDid] is the did of the identity we interacted with
  Future<Map<String, dynamic>> getDidProfileInfo({
    required String did,
    required String privateKey,
    required String interactedWithDid,
  });

  /// Get a list of info about dids we interacted with.
  /// [did] is the did of the identity we used to interact
  /// [privateKey] is the key used to access the sensitive info
  /// [filters] is a list of filters to apply to the list
  Future<List<Map<String, dynamic>>> getDidProfileInfoList({
    required String did,
    required String privateKey,
    required List<FilterEntity>? filters,
  });

  /// Remove info about a did we interacted with
  /// [did] is the did of the identity we used to interact
  /// [privateKey] is the key used to access the sensitive info
  /// [interactedWithDid] is the did of the identity we interacted with
  Future<void> removeDidProfileInfo({
    required String did,
    required String privateKey,
    required String interactedWithDid,
  });

  /// Accepts any message as string and generate JWZ token containing this
  /// message
  Future<String> getAuthToken({
    required String genesisDid,
    required String privateKey,
    required BigInt profileNonce,
    required String iden3message,
  });

  /// Accepts auth request or contract invocation iden3 message and generates
  /// JWZ token which contains the response to this message.
  Future<String> getAuthResponseToken({
    required String privateKey,
    required String genesisDid,
    required BigInt profileNonce,
    required IdentityEntity identityEntity,
    required Iden3Message message,
    required EnvEntity env,
    DIDDocument? didDocument,
    String? pushToken,
    List<RequestAndCredentials>? requestsAndCreds,
    String? challenge,
  });

  /// Fetches credential using the [credentialOfferMessage] and returns it without saving.
  /// [credentialOfferMessage] is the message received from the issuer
  /// [privateKey] is the key used to access the sensitive info
  /// [genesisDid] is the unique id of the identity
  /// [profileNonce] is the nonce of the profile used from identity to create the did identifier
  /// [blockchain] is optional param to specify the blockchain to fetch the credentials from
  /// [network] is optional param to specify the network to fetch the credentials from
  Future<List<CredentialEntity>> fetchCredentials({
    required BaseCredentialOfferMessage credentialOfferMessage,
    required String privateKey,
    required String genesisDid,
    required BigInt profileNonce,
    required List<JsonWebKey> keys,
    String? blockchain,
    String? network,
  });

  Future<ZKProofEntity> getAnonAadhaarProof({
    required String qrData,
    required int timeNow,
    required String profileDid,
    required SelfIssuedCredentialParams selfIssuedCredentialParams,
    required String circuitId,
  });

  Future<CredentialEntity> getAnonAadhaarCredential({
    required String qrData,
    required int timeNow,
    required String profileDid,
    required SelfIssuedCredentialParams selfIssuedCredentialParams,
    required Map<String, dynamic> additionalFields,
  });

  /// [passportData] - DG1 passport group with tag
  Future<ZKProofEntity> getPassportProof({
    required String passportData,
    required String dg2Hash,
    required String profileDid,
    required int revocationNonce,
    required String credentialStatusID,
    required String issuerDid,
    required int issuanceDate,
    required String linkNonce,
    required String circuitId,
  });

  /// [passportData] - DG1 passport group with tag
  Future<CredentialEntity> getPassportCredential({
    required String passportData,
    required String dg2Hash,
    required String profileDid,
    required int revocationNonce,
    required String credentialStatusID,
    required String issuerDid,
    required int issuanceDate,
    required String linkNonce,
    required String circuitId,
    Map<String, dynamic>? additionalFields,
  });

  Future<DiscoverFeatureDiscloseMessage> handleDiscoveryMessage({
    required DiscoverFeatureQueriesMessage message,
    DiscoveryProtocolHandlerOptions? opts,
  });
}

@injectable
class Iden3comm implements PolygonIdSdkIden3comm {
  final FetchAndSaveClaimsUseCase _fetchAndSaveClaimsUseCase;
  final FetchOnchainClaimsUseCase _fetchOnchainClaimsUseCase;
  final Iden3MessageFactory _iden3messageFactory;
  final GetSchemasUseCase _getSchemasUseCase;
  final FetchSchemaUseCase _fetchSchemaUseCase;
  final AuthenticateUseCase _authenticateUseCase;
  final GetFiltersUseCase _getFiltersUseCase;
  final GetIden3commClaimsUseCase _getIden3commClaimsUseCase;
  final GetMessageRequestsAndCredsUseCase _getMessageRequestsAndCredsUseCase;
  final GetIden3commClaimsRevNonceUseCase _getIden3commClaimsRevNonceUseCase;
  final GetIden3commProofsUseCase _getIden3commProofsUseCase;
  final GetIden3commProofUseCase _getIden3commProofUseCase;
  final GetInteractionsUseCase _getInteractionsUseCase;
  final AddInteractionUseCase _addInteractionUseCase;
  final RemoveInteractionsUseCase _removeInteractionsUseCase;
  final UpdateInteractionUseCase _updateInteractionUseCase;
  final CleanSchemaCacheUseCase _cleanSchemaCacheUseCase;
  final StacktraceManager _stacktraceManager;
  final AddDidProfileInfoUseCase _addDidProfileInfoUseCase;
  final GetDidProfileInfoUseCase _getDidProfileInfoUseCase;
  final GetDidProfileInfoListUseCase _getDidProfileInfoListUseCase;
  final RemoveDidProfileInfoUseCase _removeDidProfileInfoUseCase;
  final GetAuthTokenUseCase _getAuthTokenUseCase;
  final FetchCredentialsUseCase _fetchCredentialsUseCase;
  final CreateAnonAadhaarCredentialUseCase _createAnonAadhaarCredentialUseCase;
  final CreateAnonAadhaarProofUseCase _createAnonAadhaarProofUseCase;
  final CreatePassportCredentialUseCase _createPassportCredentialUseCase;
  final CreatePassportProofUseCase _createPassportProofUseCase;
  final CoreClaimFromCredentialUseCase _coreClaimFromCredentialUseCase;
  final RemoteIden3commDataSource _remoteIden3commDataSource;

  Iden3comm(
    this._fetchAndSaveClaimsUseCase,
    this._fetchOnchainClaimsUseCase,
    this._iden3messageFactory,
    this._getSchemasUseCase,
    this._fetchSchemaUseCase,
    this._authenticateUseCase,
    this._getFiltersUseCase,
    this._getIden3commClaimsUseCase,
    this._getMessageRequestsAndCredsUseCase,
    this._getIden3commClaimsRevNonceUseCase,
    this._getIden3commProofsUseCase,
    this._getIden3commProofUseCase,
    this._getInteractionsUseCase,
    this._addInteractionUseCase,
    this._removeInteractionsUseCase,
    this._updateInteractionUseCase,
    this._cleanSchemaCacheUseCase,
    this._stacktraceManager,
    this._addDidProfileInfoUseCase,
    this._getDidProfileInfoUseCase,
    this._getDidProfileInfoListUseCase,
    this._removeDidProfileInfoUseCase,
    this._getAuthTokenUseCase,
    this._fetchCredentialsUseCase,
    this._createAnonAadhaarCredentialUseCase,
    this._createAnonAadhaarProofUseCase,
    this._createPassportCredentialUseCase,
    this._createPassportProofUseCase,
    this._coreClaimFromCredentialUseCase,
    this._remoteIden3commDataSource,
  );

  @override
  Future<Iden3Message> getIden3Message({required String message}) async {
    _stacktraceManager.clearStacktrace();
    return _iden3messageFactory.createMessage(rawMessage: message);
  }

  @override
  Future<List<Map<String, dynamic>>> getSchemas({
    required Iden3Message message,
  }) {
    _stacktraceManager.clearStacktrace();
    return _getSchemasUseCase.execute(param: message);
  }

  @override
  Future<Map<String, dynamic>> fetchSchema({required String schemaUrl}) {
    _stacktraceManager.clearStacktrace();
    return _fetchSchemaUseCase.execute(param: schemaUrl);
  }

  @override
  Future<Map<String, dynamic>> fetchDisplayMethod({required String url}) {
    _stacktraceManager.clearStacktrace();
    return _remoteIden3commDataSource.fetchDisplayMethod(url: url);
  }

  @override
  Future<DisplayType> fetchDisplayType({required DisplayMethod displayMethod}) {
    _stacktraceManager.clearStacktrace();
    return _remoteIden3commDataSource.fetchDisplayType(
      displayMethod: displayMethod,
    );
  }

  @override
  Future<List<FilterEntity>> getFilters({required Iden3Message message}) {
    _stacktraceManager.clearStacktrace();
    return _getFiltersUseCase.execute(param: message);
  }

  @override
  Future<List<CredentialEntity>> fetchAndSaveClaims({
    required BaseCredentialOfferMessage message,
    required String genesisDid,
    BigInt? profileNonce,
    required String privateKey,
    required List<JsonWebKey> keys,
  }) {
    _stacktraceManager.clearStacktrace();

    return _fetchAndSaveClaimsUseCase.execute(
      param: FetchAndSaveClaimsParam(
        message: message,
        genesisDid: genesisDid,
        profileNonce: profileNonce ?? GENESIS_PROFILE_NONCE,
        privateKey: privateKey,
        keys: keys,
      ),
    );
  }

  @override
  Future<List<CredentialEntity>> fetchOnchainClaims({
    required String contractAddress,
    required String genesisDid,
    BigInt? profileNonce,
    required String privateKey,
    String? chainId,
  }) {
    _stacktraceManager.clearStacktrace();

    return _fetchOnchainClaimsUseCase.execute(
      param: FetchOnchainClaimsParam(
        contractAddress: contractAddress,
        genesisDid: genesisDid,
        profileNonce: profileNonce,
        privateKey: privateKey,
        chainId: chainId,
      ),
    );
  }

  @override
  Future<List<CredentialEntity>> getClaimsFromIden3Message({
    required Iden3Message message,
    required String genesisDid,
    BigInt? profileNonce,
    required String privateKey,
    List<CredentialSortOrder> sortOrder = const [],
  }) {
    _stacktraceManager.clearStacktrace();
    return _getIden3commClaimsUseCase.execute(
      param: GetIden3commClaimsParam(
        message: message,
        genesisDid: genesisDid,
        profileNonce: profileNonce ?? GENESIS_PROFILE_NONCE,
        encryptionKey: privateKey,
        credentialSortOrderList: sortOrder,
      ),
    );
  }

  @override
  Future<List<RequestAndCredentials>> getMessageRequestsAndCredentials({
    required Iden3Message message,
    required String genesisDid,
    BigInt? profileNonce,
    required String encryptionKey,
  }) {
    _stacktraceManager.clearStacktrace();
    return _getMessageRequestsAndCredsUseCase.execute(
      param: GetMessageRequestsAndCredsParam(
        message: message,
        genesisDid: genesisDid,
        profileNonce: profileNonce ?? GENESIS_PROFILE_NONCE,
        encryptionKey: encryptionKey,
      ),
    );
  }

  @override
  Future<List<int>> getClaimsRevNonceFromIden3Message({
    required Iden3Message message,
    required String genesisDid,
    BigInt? profileNonce,
    required String privateKey,
  }) {
    _stacktraceManager.clearStacktrace();
    return _getIden3commClaimsRevNonceUseCase.execute(
      param: GetIden3commClaimsRevNonceParam(
        message: message,
        genesisDid: genesisDid,
        profileNonce: profileNonce ?? GENESIS_PROFILE_NONCE,
        encryptionKey: privateKey,
      ),
    );
  }

  @override
  Future<List<Iden3commProofEntity>> getProofs({
    required Iden3Message message,
    required String genesisDid,
    BigInt? profileNonce,
    required String privateKey,
    String? challenge,
    EnvConfigEntity? config,
    Map<String, dynamic>? transactionData,
  }) {
    _stacktraceManager.clearStacktrace();
    return _getIden3commProofsUseCase.execute(
      param: GetIden3commProofsParam(
        message: message,
        genesisDid: genesisDid,
        profileNonce: profileNonce ?? GENESIS_PROFILE_NONCE,
        privateKey: privateKey,
        challenge: challenge,
        config: config,
        transactionData: transactionData,
      ),
    );
  }

  @override
  Future<Iden3commProofEntity> getProof({
    required ZeroKnowledgeProofRequest request,
    required String verifierDid,
    required String genesisDid,
    BigInt? profileNonce,
    required String linkNonce,
    required String privateKey,
    String? challenge,
    EnvConfigEntity? config,
    Map<String, dynamic>? transactionData,
  }) {
    _stacktraceManager.clearStacktrace();
    return _getIden3commProofUseCase.execute(
      param: GetIden3commProofParam(
        request: request,
        verifierDid: verifierDid,
        genesisDid: genesisDid,
        profileNonce: profileNonce ?? GENESIS_PROFILE_NONCE,
        linkNonce: linkNonce,
        privateKey: privateKey,
        challenge: challenge,
        config: config,
        transactionData: transactionData,
      ),
    );
  }

  @override
  Future<Iden3Message?> authenticate({
    required Iden3Message message,
    required String genesisDid,
    BigInt? profileNonce,
    required String privateKey,
    String? pushToken,
    String? challenge,
    CircuitId circuitId = CircuitId.authV2,
  }) {
    _stacktraceManager.clearStacktrace();
    if (message is! AuthorizationRequestMessage) {
      _stacktraceManager.addError(
        'Invalid message type: ${message.type}, expected: ${Iden3MessageType.authRequest}',
      );
      throw InvalidIden3MsgTypeException(
        expected: Iden3MessageType.authRequest,
        actual: message.type,
        errorMessage:
            'Invalid message type, expected: ${Iden3MessageType.authRequest}, actual: ${message.type}',
      );
    }

    return _authenticateUseCase.execute(
      param: AuthenticateParam(
        message: message,
        genesisDid: genesisDid,
        profileNonce: profileNonce ?? GENESIS_PROFILE_NONCE,
        privateKey: privateKey,
        pushToken: pushToken,
        challenge: challenge,
        circuitId: circuitId,
      ),
    );
  }

  Future<Iden3Message?> authenticateV2({
    required String privateKey,
    required String genesisDid,
    required BigInt profileNonce,
    required IdentityEntity identityEntity,
    required Iden3Message message,
    required EnvEntity env,
    DIDDocument? didDocument,
    String? pushToken,
    List<RequestAndCredentials>? requestsAndCreds,
    String? challenge,
    CircuitId circuitId = CircuitId.authV2,
  }) async {
    try {
      return await Authenticate().authenticate(
        privateKey: privateKey,
        genesisDid: genesisDid,
        profileNonce: profileNonce,
        identityEntity: identityEntity,
        message: message,
        env: env,
        pushToken: pushToken,
        didDocument: didDocument,
        requestsAndCreds: requestsAndCreds,
        challenge: challenge,
      );
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (e) {
      _stacktraceManager.addError('[authenticateV2] Error: ${e.toString()}');
      throw PolygonIdSDKException(
        errorMessage: "Error while authenticating with error: ${e.toString()}",
      );
    }
  }

  @override
  Future<List<InteractionEntity>> getInteractions({
    String? genesisDid,
    BigInt? profileNonce,
    String? privateKey,
    List<InteractionType>? types,
    List<InteractionState>? states,
    List<FilterEntity>? filters,
  }) {
    _stacktraceManager.clearStacktrace();
    return _getInteractionsUseCase.execute(
      param: GetInteractionsParam(
        genesisDid: genesisDid,
        profileNonce: profileNonce ?? GENESIS_PROFILE_NONCE,
        privateKey: privateKey,
        types: types,
        filters: filters,
      ),
    );
  }

  @override
  Future<void> removeInteractions({
    String? genesisDid,
    String? privateKey,
    required List<String> ids,
  }) {
    _stacktraceManager.clearStacktrace();
    return _removeInteractionsUseCase.execute(
      param: RemoveInteractionsParam(
        genesisDid: genesisDid,
        encryptionKey: privateKey,
        ids: ids,
      ),
    );
  }

  @override
  Future<InteractionEntity> addInteraction({
    required InteractionEntity interaction,
    required String genesisDid,
    required String privateKey,
  }) {
    _stacktraceManager.clearStacktrace();
    return _addInteractionUseCase.execute(
      param: AddInteractionParam(
        genesisDid: genesisDid,
        encryptionKey: privateKey,
        interaction: interaction,
      ),
    );
  }

  @override
  Future<InteractionEntity> updateInteraction({
    required String id,
    String? genesisDid,
    BigInt? profileNonce,
    String? privateKey,
    InteractionState? state,
  }) {
    _stacktraceManager.clearStacktrace();
    return _updateInteractionUseCase.execute(
      param: UpdateInteractionParam(
        genesisDid: genesisDid,
        profileNonce: profileNonce ?? GENESIS_PROFILE_NONCE,
        encryptionKey: privateKey,
        id: id,
        state: state,
      ),
    );
  }

  @override
  Future<void> cleanSchemaCache() {
    return _cleanSchemaCacheUseCase.execute(param: null);
  }

  @override
  Future<void> addDidProfileInfo({
    required String did,
    required String privateKey,
    required String interactedWithDid,
    required Map<String, dynamic> info,
  }) {
    return _addDidProfileInfoUseCase.execute(
      param: AddDidProfileInfoParam(
        genesisDid: did,
        interactedWithDid: interactedWithDid,
        didProfileInfo: info,
        encryptionKey: privateKey,
      ),
    );
  }

  @override
  Future<Map<String, dynamic>> getDidProfileInfo({
    required String did,
    required String privateKey,
    required String interactedWithDid,
  }) {
    return _getDidProfileInfoUseCase.execute(
      param: GetDidProfileInfoParam(
        genesisDid: did,
        interactedWithDid: interactedWithDid,
        encryptionKey: privateKey,
      ),
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getDidProfileInfoList({
    required String did,
    required String privateKey,
    required List<FilterEntity>? filters,
  }) {
    return _getDidProfileInfoListUseCase.execute(
      param: GetDidProfileInfoListParam(
        genesisDid: did,
        filters: filters,
        encryptionKey: privateKey,
      ),
    );
  }

  @override
  Future<void> removeDidProfileInfo({
    required String did,
    required String privateKey,
    required String interactedWithDid,
  }) {
    return _removeDidProfileInfoUseCase.execute(
      param: RemoveDidProfileInfoParam(
        genesisDid: did,
        interactedWithDid: interactedWithDid,
        encryptionKey: privateKey,
      ),
    );
  }

  Future<String> getAuthToken({
    required String genesisDid,
    required String privateKey,
    required BigInt profileNonce,
    required String iden3message,
    CircuitId circuitId = CircuitId.authV2,
  }) {
    return _getAuthTokenUseCase.execute(
      param: GetAuthTokenParam(
        genesisDid: genesisDid,
        profileNonce: profileNonce,
        privateKey: privateKey,
        message: iden3message,
        circuitId: circuitId,
      ),
    );
  }

  Future<String> getAuthResponseToken({
    required String privateKey,
    required String genesisDid,
    required BigInt profileNonce,
    required IdentityEntity identityEntity,
    required Iden3Message message,
    required EnvEntity env,
    DIDDocument? didDocument,
    String? pushToken,
    List<RequestAndCredentials>? requestsAndCreds,
    String? challenge,
    CircuitId circuitId = CircuitId.authV2,
  }) async {
    try {
      return await Authenticate().getAuthResponseToken(
        privateKey: privateKey,
        genesisDid: genesisDid,
        profileNonce: profileNonce,
        identityEntity: identityEntity,
        message: message,
        env: env,
        pushToken: pushToken,
        didDocument: didDocument,
        requestsAndCreds: requestsAndCreds,
        circuitId: circuitId,
      );
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (e) {
      _stacktraceManager.addError('[getAuthTokenOnly] Error: ${e.toString()}');
      throw PolygonIdSDKException(
        errorMessage:
            "Error while getting auth token with error: ${e.toString()}",
      );
    }
  }

  @override
  Future<List<CredentialEntity>> fetchCredentials({
    required BaseCredentialOfferMessage credentialOfferMessage,
    required String privateKey,
    required String genesisDid,
    required BigInt profileNonce,
    required List<JsonWebKey> keys,
    String? blockchain,
    String? network,
  }) {
    return _fetchCredentialsUseCase.fetchCredentials(
      credentialOfferMessage: credentialOfferMessage,
      privateKey: privateKey,
      genesisDid: genesisDid,
      keys: keys,
      profileNonce: profileNonce,
      blockchain: blockchain,
      network: network,
    );
  }

  @override
  Future<ZKProofEntity> getAnonAadhaarProof({
    required String qrData,
    required int timeNow,
    required String profileDid,
    required SelfIssuedCredentialParams selfIssuedCredentialParams,
    required String circuitId,
  }) async {
    return _createAnonAadhaarProofUseCase.execute(
      param: CreateAnonAadhaarProofParam(
        qrData: qrData,
        timeNow: timeNow,
        profileDid: profileDid,
        selfIssuedCredentialParams: selfIssuedCredentialParams,
        circuitId: circuitId,
      ),
    );
  }

  @override
  Future<CredentialEntity> getAnonAadhaarCredential({
    required String qrData,
    required int timeNow,
    required String profileDid,
    required SelfIssuedCredentialParams selfIssuedCredentialParams,
    Map<String, dynamic>? additionalFields,
  }) {
    return _createAnonAadhaarCredentialUseCase.execute(
      param: CreateAnonAadhaarCredentialParam(
        qrData: qrData,
        timeNow: timeNow,
        profileDid: profileDid,
        selfIssuedCredentialParams: selfIssuedCredentialParams,
        additionalFields: additionalFields,
      ),
    );
  }

  @override
  Future<ZKProofEntity> getPassportProof({
    required String passportData,
    required String dg2Hash,
    required String profileDid,
    required int revocationNonce,
    required String credentialStatusID,
    required String issuerDid,
    required int issuanceDate,
    required String linkNonce,
    required String circuitId,
  }) async {
    return _createPassportProofUseCase.execute(
      param: CreatePassportProofParam(
        passportData: passportData,
        dg2Hash: dg2Hash,
        profileDid: profileDid,
        revocationNonce: revocationNonce,
        credentialStatusID: credentialStatusID,
        issuerDid: issuerDid,
        issuanceDate: issuanceDate,
        linkNonce: linkNonce,
        circuitId: circuitId,
      ),
    );
  }

  @override
  Future<CredentialEntity> getPassportCredential({
    required String passportData,
    required String dg2Hash,
    required String profileDid,
    required int revocationNonce,
    required String credentialStatusID,
    required String issuerDid,
    required int issuanceDate,
    required String linkNonce,
    required String circuitId,
    Map<String, dynamic>? additionalFields,
  }) {
    return _createPassportCredentialUseCase.execute(
      param: CreatePassportCredentialParam(
        passportData: passportData,
        dg2Hash: dg2Hash,
        profileDid: profileDid,
        revocationNonce: revocationNonce,
        credentialStatusID: credentialStatusID,
        issuerDid: issuerDid,
        issuanceDate: issuanceDate,
        linkNonce: linkNonce,
        circuitId: circuitId,
        additionalFields: additionalFields,
      ),
    );
  }

  Future<String> coreClaimFromCredential({
    required CredentialEntity credential,
    required int revNonce,
    EnvConfigEntity? config,
  }) {
    return _coreClaimFromCredentialUseCase.execute(
      param: CoreClaimFromCredentialParam(
        credential: credential,
        config: config,
        revNonce: revNonce,
      ),
    );
  }

  @override
  Future<DiscoverFeatureDiscloseMessage> handleDiscoveryMessage({
    required DiscoverFeatureQueriesMessage message,
    DiscoveryProtocolHandlerOptions? opts,
  }) {
    final packageManager = PackageManager();
    packageManager.packers[MediaType.plainMessage] = PlainPacker();

    IDiscoveryProtocolHandler handler = DiscoveryProtocolHandler(
      DiscoveryProtocolOptions(packageManager: packageManager),
    );

    return handler.handleDiscoveryQuery(message, opts);
  }
}
