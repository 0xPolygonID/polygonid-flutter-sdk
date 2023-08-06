import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/generate_non_rev_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_non_rev_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';

import '../../../common/domain/domain_logger.dart';
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
  final GetNonRevProofUseCase _getNonRevProofUseCase;
  final StacktraceStreamManager _stacktraceStreamManager;

  GetClaimRevocationStatusUseCase(
    this._credentialRepository,
    this._generateNonRevProofUseCase,
    this._getNonRevProofUseCase,
    this._stacktraceStreamManager,
  );

  @override
  Future<Map<String, dynamic>> execute(
      {required GetClaimRevocationStatusParam param}) async {
    bool useRHS = await _credentialRepository
        .isUsingRHS(claim: param.claim)
        .catchError((error) {
      _stacktraceStreamManager
          .addTrace("[GetClaimRevocationStatusUseCase] Error: $error");
      logger().e("[GetClaimRevocationStatusUseCase] Error: $error");
      throw error;
    });
    if (useRHS) {
      _stacktraceStreamManager.addTrace(
          "[GetClaimRevocationStatusUseCase] Using RHS for revocation status");
      try {
        Map<String, dynamic> status = await _generateNonRevProofUseCase.execute(
            param: GenerateNonRevProofParam(
                claim: param.claim, nonRevProof: param.nonRevProof));
        return status;
      } catch (error) {
        Map<String, dynamic> status = await _getNonRevProofUseCase
            .execute(param: param.claim)
            .catchError((error) {
          _stacktraceStreamManager
              .addTrace("[GetClaimRevocationStatusUseCase] Error: $error");
          logger().e("[GetClaimRevocationStatusUseCase] Error: $error");
          throw error;
        });
        _stacktraceStreamManager.addTrace(
            "[GetClaimRevocationStatusUseCase] Revocation status: $status");
        logger()
            .i("[GetClaimRevocationStatusUseCase] Revocation status: $status");
        return status;
      }
    } else {
      _stacktraceStreamManager.addTrace(
          "[GetClaimRevocationStatusUseCase] Using non-RHS for revocation status");
      return _getNonRevProofUseCase.execute(param: param.claim).then((status) {
        _stacktraceStreamManager.addTrace(
            "[GetClaimRevocationStatusUseCase] Revocation status: $status");
        logger()
            .i("[GetClaimRevocationStatusUseCase] Revocation status: $status");
        return status;
      }).catchError((error) {
        _stacktraceStreamManager
            .addTrace("[GetClaimRevocationStatusUseCase] Error: $error");
        logger().e("[GetClaimRevocationStatusUseCase] Error: $error");
        throw error;
      });
    }
  }
}
