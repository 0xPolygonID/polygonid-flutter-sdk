import 'package:intl/intl.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/utils/credential_sort_order.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/refresh_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/authenticate.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_body_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_request_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/generate_iden3comm_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_message_requests_and_credentials.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/infrastructure/proof_generation_stream_manager.dart';

class GetIden3commProofParam {
  final ZeroKnowledgeProofRequest request;
  final CredentialEntity? credential;
  final String? verifierDid;
  final String genesisDid;
  final BigInt profileNonce;
  final String linkNonce;
  final String privateKey;
  final String? challenge;
  final EnvConfigEntity? config;

  final Map<String, dynamic>? transactionData;

  GetIden3commProofParam({
    required this.request,
    this.credential,
    required this.verifierDid,
    required this.genesisDid,
    required this.profileNonce,
    required this.linkNonce,
    required this.privateKey,
    this.challenge,
    this.config,
    this.transactionData,
  });
}

class GetIden3commProofUseCase
    extends FutureUseCase<GetIden3commProofParam, Iden3commProofEntity> {
  final ProofRepository _proofRepository;
  final GetMessageRequestsAndCredsUseCase _getMessageRequestsAndCredsUseCase;
  final GenerateIden3commProofUseCase _generateIden3commProofUseCase;
  final IsProofCircuitSupportedUseCase _isProofCircuitSupported;
  final GetIdentityUseCase _getIdentityUseCase;
  final ProofGenerationStepsStreamManager _proofGenerationStepsStreamManager;
  final StacktraceManager _stacktraceManager;

  final RefreshCredentialUseCase _refreshCredentialUseCase;

  GetIden3commProofUseCase(
    this._proofRepository,
    this._getMessageRequestsAndCredsUseCase,
    this._generateIden3commProofUseCase,
    this._isProofCircuitSupported,
    this._getIdentityUseCase,
    this._proofGenerationStepsStreamManager,
    this._stacktraceManager,
    this._refreshCredentialUseCase,
  );

  @override
  Future<Iden3commProofEntity> execute({
    required GetIden3commProofParam param,
  }) async {
    try {
      final request = param.request;

      bool isCircuitSupported = await _isProofCircuitSupported.execute(
        param: request.circuitId,
      );
      if (!isCircuitSupported) {
        _stacktraceManager.addError(
          "[GetIden3commProofsUseCase] Unsupported circuit: ${request.circuitId} for request: ${request.id}",
        );
        throw UnsupportedCircuitException(
          proofRequest: request,
          errorMessage:
              "Unsupported circuit: ${request.circuitId} for request: ${request.id}",
        );
      }

      String circuitId = request.circuitId;
      final circuitData = await _proofRepository.loadCircuitFiles(circuitId);

      String? challenge;
      String? privKey;
      final parsedCircuitId = CircuitId.fromId(circuitId);
      if (parsedCircuitId.isOnChain) {
        challenge = param.challenge;
        privKey = param.privateKey;
      }

      var identityEntity = await _getIdentityUseCase.execute(
        param: GetIdentityParam(
          genesisDid: param.genesisDid,
          privateKey: param.privateKey,
        ),
      );

      if (circuitId.startsWith('auth')) {
        return Authenticate().generateAuthProof(
          genesisDid: param.genesisDid,
          privateKey: param.privateKey,
          request: request,
          profileNonce: param.profileNonce,
          identityEntity: identityEntity,
          proofRepo: _proofRepository,
        );
      }

      final credential = await _getCredential(param: param);
      BigInt claimSubjectProfileNonce = identityEntity.profiles.keys.firstWhere(
        (k) => identityEntity.profiles[k] == credential.credentialSubject["id"],
        orElse: () => GENESIS_PROFILE_NONCE,
      );

      _proofGenerationStepsStreamManager.add(
        "creating proof for ${credential.type}",
      );

      // Generate proof param
      GenerateIden3commProofParam proofParam = GenerateIden3commProofParam(
        did: param.genesisDid,
        profileNonce: param.profileNonce,
        claimSubjectProfileNonce: claimSubjectProfileNonce,
        credential: credential,
        request: request,
        circuitData: circuitData,
        privateKey: privKey,
        challenge: challenge,
        config: param.config,
        verifierId: param.verifierDid,
        linkNonce: param.linkNonce,
        transactionData: param.transactionData,
      );

      // Generate proof
      Iden3commProofEntity proof = await _generateIden3commProofUseCase.execute(
        param: proofParam,
      );

      return proof;
    } catch (e) {
      _stacktraceManager.logError("[GetIden3commProofsUseCase] Exception: $e");
      rethrow;
    }
  }

  Future<CredentialEntity> _getCredential({
    required GetIden3commProofParam param,
  }) async {
    CredentialEntity credential;
    final request = param.request;
    if (param.credential case var existingCred?) {
      credential = existingCred;
    } else {
      _proofGenerationStepsStreamManager.add("Getting proof requests");

      final requestsAndCreds = await _getMessageRequestsAndCredsUseCase.execute(
        param: GetMessageRequestsAndCredsParam(
          // Mock message
          message: AuthorizationRequestMessage(
            from: '',
            body: AuthorizationRequestMessageBody(
              callbackUrl: '',
              reason: '',
              scope: [param.request],
            ),
          ),
          genesisDid: param.genesisDid,
          profileNonce: param.profileNonce,
          encryptionKey: param.privateKey,
          credentialSortOrderList: [CredentialSortOrder.ExpirationDescending],
        ),
      );

      final credentials = requestsAndCreds.first.credentials;

      /// Generate proof for each request
      if (credentials.isEmpty) {
        // if there are no credentials for the request - throw an error
        _stacktraceManager.addError(
          "[Authenticate] No credentials found for request: ${request.id}",
        );
        throw NoCredentialsFoundException(
          proofRequest: request,
          errorMessage: "No credentials found for request: ${request.id}",
        );
      }
      credential = credentials.first;
    }

    if (credential.expiration != null) {
      credential = await _checkCredentialExpirationAndTryRefreshIfExpired(
        claim: credential,
        param: param,
      );
    }

    return credential;
  }

  /// Check if the credential is expired and try to refresh it if it is
  /// and if it has a refresh service
  Future<CredentialEntity> _checkCredentialExpirationAndTryRefreshIfExpired({
    required CredentialEntity claim,
    required GetIden3commProofParam param,
  }) async {
    var now = DateTime.now().toUtc();
    DateTime expirationTime = DateFormat(
      "yyyy-MM-ddTHH:mm:ssZ",
    ).parse(claim.expiration!);

    var nowFormatted = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
    var expirationTimeFormatted = DateFormat(
      "yyyy-MM-dd HH:mm:ss",
    ).format(expirationTime);
    bool isExpired =
        nowFormatted.compareTo(expirationTimeFormatted) > 0 ||
        claim.state == CredentialState.expired;

    if (isExpired && claim.info.containsKey("refreshService")) {
      _proofGenerationStepsStreamManager.add(
        "Refreshing expired credential...",
      );

      CredentialEntity refreshedClaimEntity = await _refreshCredentialUseCase
          .execute(
            param: RefreshCredentialParam(
              credential: claim,
              genesisDid: param.genesisDid,
              privateKey: param.privateKey,
              // TODO Maybe add keys here
              keys: [],
            ),
          );

      claim = refreshedClaimEntity;
    }
    return claim;
  }
}
