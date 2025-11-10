import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:ninja_prime/ninja_prime.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/utils/credential_sort_order.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/refresh_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/generate_iden3comm_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_message_requests_and_credentials.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/infrastructure/proof_generation_stream_manager.dart';

class GetIden3commProofParam {
  final ZeroKnowledgeProofRequest request;
  final String verifierDid;
  final String genesisDid;
  final BigInt profileNonce;
  final String privateKey;
  final String? challenge;
  final EnvConfigEntity? config;

  final Map<String, dynamic>? transactionData;

  GetIden3commProofParam({
    required this.request,
    required this.verifierDid,
    required this.genesisDid,
    required this.profileNonce,
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
      Map<int, String> groupIdLinkNonceMap = {};

      _proofGenerationStepsStreamManager.add("Getting proof requests");

      final requestsAndCreds = await _getMessageRequestsAndCredsUseCase.execute(
        param: GetMessageRequestsAndCredsParam(
          proofRequests: [param.request],
          genesisDid: param.genesisDid,
          profileNonce: param.profileNonce,
          encryptionKey: param.privateKey,
          credentialSortOrderList: [CredentialSortOrder.ExpirationDescending],
        ),
      );

      final request = requestsAndCreds.first.request;
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
      CredentialEntity claim = credentials.first;

      if (claim.expiration != null) {
        claim = await _checkCredentialExpirationAndTryRefreshIfExpired(
          claim: claim,
          param: param,
        );
      }

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
      CircuitDataEntity circuitData = await _proofRepository.loadCircuitFiles(
        circuitId,
      );

      String? challenge;
      String? privKey;
      if (circuitId == CircuitTypes.mtpOnChain.id ||
          circuitId == CircuitTypes.sigOnChain.id ||
          circuitId == CircuitTypes.circuitsV3OnChain.id) {
        challenge = param.challenge;
        privKey = param.privateKey;
      }

      var identityEntity = await _getIdentityUseCase.execute(
        param: GetIdentityParam(
          genesisDid: param.genesisDid,
          privateKey: param.privateKey,
        ),
      );

      BigInt claimSubjectProfileNonce = identityEntity.profiles.keys.firstWhere(
        (k) =>
            identityEntity.profiles[k] == claim.info["credentialSubject"]["id"],
        orElse: () => GENESIS_PROFILE_NONCE,
      );

      int? groupId = request.query.groupId;
      String linkNonce = "0";
      // Check if groupId exists in the map
      if (groupId != null) {
        if (groupIdLinkNonceMap.containsKey(groupId)) {
          // Use the existing linkNonce for this groupId
          linkNonce = groupIdLinkNonceMap[groupId]!;
        } else {
          // Generate a new linkNonce for this groupId
          linkNonce = generateLinkNonce();
          groupIdLinkNonceMap[groupId] = linkNonce;
        }
      }

      _proofGenerationStepsStreamManager.add(
        "creating proof for ${claim.type}",
      );

      // Generate proof param
      GenerateIden3commProofParam proofParam = GenerateIden3commProofParam(
        did: param.genesisDid,
        profileNonce: param.profileNonce,
        claimSubjectProfileNonce: claimSubjectProfileNonce,
        credential: claim,
        request: request,
        circuitData: circuitData,
        privateKey: privKey,
        challenge: challenge,
        config: param.config,
        verifierId: param.verifierDid,
        linkNonce: linkNonce,
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

  /// We generate a random linkNonce for each groupId
  String generateLinkNonce() {
    final BigInt safeMaxVal = BigInt.parse(
      "21888242871839275222246405745257275088548364400416034343698204186575808495617",
    );
    // get max value of 2 ^ 248
    BigInt base = BigInt.parse('2');
    int exponent = 248;
    final maxVal = base.pow(exponent) - BigInt.one;
    final random = Random.secure();
    BigInt randomNumber;
    do {
      randomNumber = randomBigInt(248, max: maxVal, random: random);
      if (kDebugMode) {
        logger().i("random number $randomNumber");
        logger().i("less than safeMax ${randomNumber < safeMaxVal}");
      }
    } while (randomNumber >= safeMaxVal);

    return randomNumber.toString();
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
