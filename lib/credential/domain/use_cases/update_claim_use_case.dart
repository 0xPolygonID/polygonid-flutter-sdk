import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/claim_entity.dart';
import '../repositories/credential_repository.dart';

class UpdateClaimParam {
  final String id;
  final String? issuer;
  final String genesisDid;
  final CredentialState? state;
  final String? expiration;
  final String? type;
  final Map<String, dynamic>? data;
  final String encryptionKey;

  UpdateClaimParam({
    required this.id,
    this.issuer,
    required this.genesisDid,
    this.state,
    this.expiration,
    this.type,
    this.data,
    required this.encryptionKey,
  });
}

class UpdateClaimUseCase
    extends FutureUseCase<UpdateClaimParam, CredentialEntity> {
  final CredentialRepository _credentialRepository;
  final StacktraceManager _stacktraceManager;

  UpdateClaimUseCase(
    this._credentialRepository,
    this._stacktraceManager,
  );

  @override
  Future<CredentialEntity> execute({required UpdateClaimParam param}) async {
    /// Get the [ClaimEntity] associated with the [param.id]
    /// If found, we update the info with the corresponding [param]
    /// then update in storage
    try {
      final claim = await _credentialRepository.getCredential(
        claimId: param.id,
        genesisDid: param.genesisDid,
        encryptionKey: param.encryptionKey,
      );

      final updatedClaim = CredentialEntity(
        id: param.id,
        issuer: param.issuer ?? claim.issuer,
        did: claim.did,
        state: param.state ?? claim.state,
        expiration: param.expiration ?? claim.expiration,
        type: param.type ?? claim.type,
        info: param.data ?? claim.info,
        credentialRawValue: claim.credentialRawValue,
      );

      await _credentialRepository.saveCredentials(
        credentials: [updatedClaim],
        genesisDid: param.genesisDid,
        encryptionKey: param.encryptionKey,
      );

      logger().i(
          "[UpdateClaimUseCase] Claim with id ${param.id} has been updated: $updatedClaim");
      _stacktraceManager.logTrace(
          "[UpdateClaimUseCase] Claim with id ${param.id} has been updated: $updatedClaim");
      return updatedClaim;
    } catch (error) {
      _stacktraceManager.logError("[UpdateClaimUseCase] Error: $error");
      rethrow;
    }
  }
}
