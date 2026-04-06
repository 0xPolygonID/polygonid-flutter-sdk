import 'package:polygonid_flutter_sdk/common/domain/entities/env_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/utils/credential_sort_order.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/request/proof_scope_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/response/iden3comm_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_message_requests_and_credentials.dart';
import 'package:polygonid_flutter_sdk/iden3comm/util/generate_link_nonce.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/circuit_type.dart';
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
  final GetMessageRequestsAndCredsUseCase _getMessageRequestsAndCredsUseCase;
  final GetIden3commProofUseCase _getIden3commProofUseCase;
  final IsProofCircuitSupportedUseCase _isProofCircuitSupported;
  final ProofGenerationStepsStreamManager _proofGenerationStepsStreamManager;
  final StacktraceManager _stacktraceManager;

  GetIden3commProofsUseCase(
    this._getMessageRequestsAndCredsUseCase,
    this._getIden3commProofUseCase,
    this._isProofCircuitSupported,
    this._proofGenerationStepsStreamManager,
    this._stacktraceManager,
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

        // Filter out credentials whose expiration date has already passed
        // (the persisted state field may be stale).
        final viable = credentials.where((c) => !c.isExpiredByDate).toList();

        CredentialEntity? credential;

        if (viable.isNotEmpty) {
          credential = viable.first;
        } else if (request.query.isEmpty) {
          // Auth-type scope (e.g. authV3-8-32) — no credential needed,
          // proceed with null.
        } else if (request.isOptional) {
          continue;
        } else {
          // Non-optional scope with no viable credential.
          final isExpired = credentials.isNotEmpty;
          _stacktraceManager.addError(
            "[GetIden3commProofsUseCase] "
            "${isExpired ? 'All credentials expired' : 'No credentials found'}"
            " for request: ${request.id}",
          );
          if (isExpired) {
            throw ExpiredCredentialException(
              proofRequest: request,
              credential: credentials.first,
              errorMessage:
                  "All credentials are expired for request: ${request.id}",
            );
          }
          throw NoCredentialsFoundException(
            proofRequest: request,
            errorMessage: "No credentials found for request: ${request.id}",
          );
        }

        bool isCircuitSupported = await _isProofCircuitSupported.execute(
          param: request.circuitId,
        );
        if (!isCircuitSupported) {
          final error =
              "Unsupported circuit: ${request.circuitId} for request: ${request.id}";
          _stacktraceManager.addError("[GetIden3commProofsUseCase] $error");
          throw UnsupportedCircuitException(
            proofRequest: request,
            errorMessage: error,
          );
        }

        String circuitId = request.circuitId;

        String? challenge;
        if (CircuitId.fromId(circuitId).isOnChain) {
          challenge = param.challenge;
        }

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
          "#${i + 1} creating proof for ${credential?.type ?? 'auth'}",
        );

        Iden3commProofEntity proof = await _getIden3commProofUseCase.execute(
          param: GetIden3commProofParam(
            request: request,
            credential: credential,
            verifierDid: param.message.from,
            genesisDid: param.genesisDid,
            profileNonce: param.profileNonce,
            privateKey: param.privateKey,
            linkNonce: linkNonce,
            challenge: challenge,
            transactionData: param.transactionData,
            config: param.config,
          ),
        );

        proofs.add(proof);
      }

      return proofs;
    } catch (e) {
      _stacktraceManager.logError("[GetIden3commProofsUseCase] Exception: $e");
      rethrow;
    }
  }
}
