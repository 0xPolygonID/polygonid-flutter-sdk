import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/utils/credential_sort_order.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_and_refresh_expired_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/generate_auth_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/generate_iden3comm_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_message_requests_and_credentials.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
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
  final GetMessageRequestsAndCredsUseCase _getMessageRequestsAndCredsUseCase;
  final GenerateIden3commProofUseCase _generateIden3commProofUseCase;
  final GenerateAuthProofUseCase _generateAuthProofUseCase;
  final IsProofCircuitSupportedUseCase _isProofCircuitSupported;
  final GetIdentityUseCase _getIdentityUseCase;
  final ProofGenerationStepsStreamManager _proofGenerationStepsStreamManager;
  final StacktraceManager _stacktraceManager;
  final CheckAndRefreshExpiredCredentialUseCase
      _checkAndRefreshExpiredCredentialUseCase;

  GetIden3commProofUseCase(
    this._getMessageRequestsAndCredsUseCase,
    this._generateIden3commProofUseCase,
    this._generateAuthProofUseCase,
    this._isProofCircuitSupported,
    this._getIdentityUseCase,
    this._proofGenerationStepsStreamManager,
    this._stacktraceManager,
    this._checkAndRefreshExpiredCredentialUseCase,
  );

  @override
  Future<Iden3commProofEntity> execute({
    required GetIden3commProofParam param,
  }) async {
    try {
      final request = param.request;

      String circuitId = request.circuitId;
      bool isCircuitSupported = await _isProofCircuitSupported.execute(
        param: circuitId,
      );
      if (!isCircuitSupported) {
        _stacktraceManager.addError(
          "[GetIden3commProofsUseCase] Unsupported circuit: $circuitId for request: ${request.id}",
        );
        throw UnsupportedCircuitException(
          proofRequest: request,
          errorMessage:
              "Unsupported circuit: $circuitId for request: ${request.id}",
        );
      }

      if (circuitId.startsWith('auth')) {
        final challenge = request.params?['challenge']?.toString();
        if (challenge == null) {
          throw NullAuthChallengeException(
            proofRequest: request,
            errorMessage: "Challenge is null",
          );
        }

        return _generateAuthProofUseCase.execute(
          param: GenerateAuthProofParam(
            genesisDid: param.genesisDid,
            privateKey: param.privateKey,
            profileNonce: param.profileNonce,
            requestId: request.id,
            circuitId: request.circuitId,
            challenge: challenge,
          ),
        );
      }

      var identityEntity = await _getIdentityUseCase.execute(
        param: GetIdentityParam(
          genesisDid: param.genesisDid,
          privateKey: param.privateKey,
        ),
      );

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
        privateKey: param.privateKey,
        challenge: param.challenge,
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
    final List<CredentialEntity> candidates;
    final request = param.request;

    if (param.credential case var existingCred?) {
      // Credential supplied directly by the caller — use it as the sole candidate.
      candidates = [existingCred];
    } else {
      _proofGenerationStepsStreamManager.add("Getting proof requests");

      final requestsAndCreds = await _getMessageRequestsAndCredsUseCase.execute(
        param: GetMessageRequestsAndCredsParam.fromRequest(
          request: request,
          genesisDid: param.genesisDid,
          profileNonce: param.profileNonce,
          encryptionKey: param.privateKey,
          credentialSortOrderList: [CredentialSortOrder.ExpirationDescending],
        ),
      );

      candidates = requestsAndCreds.first.credentials;

      if (candidates.isEmpty) {
        _stacktraceManager.addError(
          "[GetIden3commProofUseCase] No credentials found for request: ${request.id}",
        );
        throw NoCredentialsFoundException(
          proofRequest: request,
          errorMessage: "No credentials found for request: ${request.id}",
        );
      }
    }

    final refreshed = await _checkAndRefreshExpiredCredentialUseCase.execute(
      param: CheckAndRefreshExpiredCredentialParam(
        credentials: candidates,
        genesisDid: param.genesisDid,
        privateKey: param.privateKey,
      ),
    );

    if (refreshed == null) {
      _stacktraceManager.addError(
        "[GetIden3commProofUseCase] All credentials expired for request: ${param.request.id}",
      );
      throw ExpiredCredentialException(
        proofRequest: param.request,
        credential: candidates.first,
        errorMessage:
            "All credentials are expired and cannot be refreshed for request: ${param.request.id}",
      );
    }

    return refreshed;
  }
}
