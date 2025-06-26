import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/generate_non_rev_proof_use_case.dart';

import '../../../common/domain/use_case.dart';
import '../entities/claim_entity.dart';
import '../repositories/credential_repository.dart';

class GetClaimRevocationStatusParam {
  final ClaimEntity claim;
  final Map<String, dynamic>? nonRevProof;

  GetClaimRevocationStatusParam({
    required this.claim,
    this.nonRevProof,
  });
}

class GetClaimRevocationStatusUseCase
    extends FutureUseCase<GetClaimRevocationStatusParam, Map<String, dynamic>> {
  final CredentialRepository _credentialRepository;
  final GenerateNonRevProofUseCase _generateNonRevProofUseCase;
  final StacktraceManager _stacktraceManager;

  GetClaimRevocationStatusUseCase(
    this._credentialRepository,
    this._generateNonRevProofUseCase,
    this._stacktraceManager,
  );

  @override
  Future<Map<String, dynamic>> execute({
    required GetClaimRevocationStatusParam param,
  }) async {
    bool useRHS;
    try {
      useRHS = await _credentialRepository.isUsingRHS(claim: param.claim);
    } catch (error) {
      _stacktraceManager
          .logError("[GetClaimRevocationStatusUseCase] Error: $error");
      rethrow;
    }

    if (useRHS) {
      _stacktraceManager.addTrace(
          "[GetClaimRevocationStatusUseCase] Using RHS for revocation status");
      try {
        final nonRevProof = await _generateNonRevProofUseCase.execute(
          param: GenerateNonRevProofParam(
            claim: param.claim,
            nonRevProof: param.nonRevProof,
          ),
        );
        return nonRevProof;
      } catch (error) {
        try {
          final nonRevProof = await _credentialRepository.getRevocationStatus(
              claim: param.claim);
          _stacktraceManager.logTrace(
              "[GetClaimRevocationStatusUseCase] Revocation status: $nonRevProof");
          return nonRevProof;
        } catch (error) {
          _stacktraceManager
              .logError("[GetClaimRevocationStatusUseCase] Error: $error");
          rethrow;
        }
      }
    } else {
      _stacktraceManager.addTrace(
          "[GetClaimRevocationStatusUseCase] Using non-RHS for revocation status");

      try {
        final nonRevProof =
            await _credentialRepository.getRevocationStatus(claim: param.claim);
        _stacktraceManager.logTrace(
            "[GetClaimRevocationStatusUseCase] Revocation status: $nonRevProof");

        return nonRevProof;
      } catch (error) {
        _stacktraceManager
            .logError("[GetClaimRevocationStatusUseCase] Error: $error");
        rethrow;
      }
    }
  }
}
