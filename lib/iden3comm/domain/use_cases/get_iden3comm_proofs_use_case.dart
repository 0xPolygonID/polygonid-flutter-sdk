import 'package:intl/intl.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/utils/credential_sort_order.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/refresh_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/generate_iden3comm_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_message_requests_and_credentials.dart';
import 'package:polygonid_flutter_sdk/iden3comm/util/generate_link_nonce.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/is_proof_circuit_supported_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/infrastructure/proof_generation_stream_manager.dart';

class GetIden3commProofsParam {
  final Iden3Message message;
  final String genesisDid;
  final BigInt profileNonce;
  final String privateKey;
  final String? challenge;
  final EnvConfigEntity? config;

  final Map<String, dynamic>? transactionData;

  GetIden3commProofsParam({
    required this.message,
    required this.genesisDid,
    required this.profileNonce,
    required this.privateKey,
    this.challenge,
    this.config,
    this.transactionData,
  });
}

class GetIden3commProofsUseCase
    extends FutureUseCase<GetIden3commProofsParam, List<Iden3commProofEntity>> {
  final ProofRepository _proofRepository;
  final GetMessageRequestsAndCredsUseCase _getMessageRequestsAndCredsUseCase;
  final GenerateIden3commProofUseCase _generateIden3commProofUseCase;
  final IsProofCircuitSupportedUseCase _isProofCircuitSupported;
  final GetIdentityUseCase _getIdentityUseCase;
  final ProofGenerationStepsStreamManager _proofGenerationStepsStreamManager;
  final StacktraceManager _stacktraceManager;

  final RefreshCredentialUseCase _refreshCredentialUseCase;

  GetIden3commProofsUseCase(
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
  Future<List<Iden3commProofEntity>> execute({
    required GetIden3commProofsParam param,
  }) async {
    try {
      List<Iden3commProofEntity> proofs = [];
      Map<int, String> groupIdLinkNonceMap = {};

      _proofGenerationStepsStreamManager.add("Getting proof requests");

      final requestsAndCreds = await _getMessageRequestsAndCredsUseCase.execute(
        param: GetMessageRequestsAndCredsParam(
          message: param.message,
          genesisDid: param.genesisDid,
          profileNonce: param.profileNonce,
          encryptionKey: param.privateKey,
          credentialSortOrderList: [CredentialSortOrder.ExpirationDescending],
        ),
      );

      final requests = requestsAndCreds.map((pair) => pair.request).toList();

      if (requests.isEmpty) {
        _stacktraceManager.logTrace(
          "[GetIden3commProofsUseCase] No proof requests found",
        );
        return [];
      }

      /// Generate proof for each request
      for (int i = 0; i < requestsAndCreds.length; i++) {
        ProofScopeRequest request = requestsAndCreds[i].request;
        List<CredentialEntity> credentials = requestsAndCreds[i].credentials;

        // if there are no credentials for the request
        if (credentials.isEmpty) {
          // if the request is optional, continue to the next request
          if (request.isOptional) {
            continue;
          } else {
            // if the request is not optional, throw an error
            _stacktraceManager.addError(
              "[Authenticate] No credentials found for request: ${request.id}",
            );
            throw NoCredentialsFoundException(
              proofRequest: request,
              errorMessage: "No credentials found for request: ${request.id}",
            );
          }
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
        bool isCorrectType = claim.type == request.query.type;

        if (isCorrectType && isCircuitSupported) {
          String circuitId = request.circuitId;
          CircuitDataEntity circuitData = await _proofRepository
              .loadCircuitFiles(circuitId);

          String? challenge;
          String? privKey;

          final parsedCircuitId = CircuitId.fromId(circuitId);
          if (parsedCircuitId.isOnChain) {
            privKey = param.privateKey;
            challenge = param.challenge;
          }

          var identityEntity = await _getIdentityUseCase.execute(
            param: GetIdentityParam(
              genesisDid: param.genesisDid,
              privateKey: param.privateKey,
            ),
          );

          BigInt claimSubjectProfileNonce = identityEntity.profiles.keys
              .firstWhere(
                (k) =>
                    identityEntity.profiles[k] ==
                    claim.info["credentialSubject"]["id"],
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
            "#${i + 1} creating proof for ${claim.type}",
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
            verifierId: param.message.from,
            linkNonce: linkNonce,
            transactionData: param.transactionData,
          );

          // Generate proof
          Iden3commProofEntity proof = await _generateIden3commProofUseCase
              .execute(param: proofParam);

          proofs.add(proof);
        }
      }

      return proofs;
    } catch (e) {
      _stacktraceManager.logError("[GetIden3commProofsUseCase] Exception: $e");
      rethrow;
    }
  }

  /// Check if the credential is expired and try to refresh it if it is
  /// and if it has a refresh service
  Future<CredentialEntity> _checkCredentialExpirationAndTryRefreshIfExpired({
    required CredentialEntity claim,
    required GetIden3commProofsParam param,
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
