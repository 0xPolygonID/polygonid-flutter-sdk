import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/refresh_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/infrastructure/proof_generation_stream_manager.dart';

class CheckAndRefreshExpiredCredentialParam {
  final List<CredentialEntity> credentials;
  final String genesisDid;
  final String privateKey;

  CheckAndRefreshExpiredCredentialParam({
    required this.credentials,
    required this.genesisDid,
    required this.privateKey,
  });
}

/// Iterates [credentials] (in order) and returns the first usable one.
///
/// For each candidate:
/// - Not expired → returned immediately.
/// - Expired + `refreshService` → refresh attempted; the refreshed credential
///   is returned on success.
/// - Expired + no `refreshService`, or refresh throws → next candidate tried.
///
/// Returns `null` when every candidate is expired and cannot be refreshed.
/// The caller is responsible for deciding whether to skip (optional request)
/// or throw [ExpiredCredentialException] (required request).
class CheckAndRefreshExpiredCredentialUseCase
    extends
        FutureUseCase<
          CheckAndRefreshExpiredCredentialParam,
          CredentialEntity?
        > {
  final RefreshCredentialUseCase _refreshCredentialUseCase;
  final ProofGenerationStepsStreamManager _proofGenerationStepsStreamManager;
  final StacktraceManager _stacktraceManager;

  CheckAndRefreshExpiredCredentialUseCase(
    this._refreshCredentialUseCase,
    this._proofGenerationStepsStreamManager,
    this._stacktraceManager,
  );

  @override
  Future<CredentialEntity?> execute({
    required CheckAndRefreshExpiredCredentialParam param,
  }) async {
    for (final candidate in param.credentials) {
      final result = await _tryCandidate(
        credential: candidate,
        genesisDid: param.genesisDid,
        privateKey: param.privateKey,
      );
      if (result != null) return result;
    }
    return null;
  }

  /// Returns the credential if valid, the refreshed one if successfully
  /// refreshed, or `null` if expired and cannot be used.
  Future<CredentialEntity?> _tryCandidate({
    required CredentialEntity credential,
    required String genesisDid,
    required String privateKey,
  }) async {
    if (credential.state == CredentialState.expired) {
      // Treat state-expired credentials the same as date-expired ones below.
    } else if (credential.expiration == null) {
      return credential;
    }

    final bool isExpired;

    final expiration = credential.expiration;
    if (expiration == null) {
      // state == CredentialState.expired but no date — treat as expired.
      isExpired = true;
    } else {
      final expirationTime = DateTime.tryParse(expiration);
      if (expirationTime == null) {
        // Unparseable expiration — treat as expired and try next candidate.
        _stacktraceManager.addError(
          "[CheckAndRefreshExpiredCredentialUseCase] Could not parse"
          " expiration '$expiration' for credential"
          " ${credential.id}; treating as expired.",
          log: true,
        );
        return null;
      }
      isExpired =
          DateTime.now().toUtc().isAfter(expirationTime.toUtc()) ||
          credential.state == CredentialState.expired;
    }

    if (!isExpired) return credential;

    if (credential.info.containsKey("refreshService")) {
      try {
        _proofGenerationStepsStreamManager.add(
          "Refreshing expired credential...",
        );
        return await _refreshCredentialUseCase.execute(
          param: RefreshCredentialParam(
            credential: credential,
            genesisDid: genesisDid,
            privateKey: privateKey,
            keys: [],
          ),
        );
      } catch (e, s) {
        final credentialId = credential.id;
        final message =
            "[CheckAndRefreshExpiredCredentialUseCase] Refresh failed for credential $credentialId: $e\n$s";
        _stacktraceManager.addError(message, log: true);
        _proofGenerationStepsStreamManager.add(
          "Credential refresh failed for $credentialId: $e",
        );
        // Fall through to try the next candidate.
      }
    }

    return null;
  }
}
