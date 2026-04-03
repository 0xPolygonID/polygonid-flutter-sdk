import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/refresh_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/update_claim_use_case.dart';
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

/// Iterates [credentials], marks any newly-expired ones in the DB, and
/// returns the first usable credential.
///
/// Phase 1 — classify all credentials:
///   - Not expired → added to the valid list.
///   - Expired + state not already `expired` → state persisted to DB;
///     added to the expired list if it has a `refreshService`.
///   - Unparseable expiration date → skipped entirely (error logged).
///
/// Phase 2 — if any valid credentials exist, return the first one
///   immediately (no refresh is attempted).
///
/// Phase 3 — all candidates are expired: attempt refresh (in order) for
///   each credential that advertises a `refreshService`.
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
  final UpdateClaimUseCase _updateClaimUseCase;
  final ProofGenerationStepsStreamManager _proofGenerationStepsStreamManager;
  final StacktraceManager _stacktraceManager;

  CheckAndRefreshExpiredCredentialUseCase(
    this._refreshCredentialUseCase,
    this._updateClaimUseCase,
    this._proofGenerationStepsStreamManager,
    this._stacktraceManager,
  );

  @override
  Future<CredentialEntity?> execute({
    required CheckAndRefreshExpiredCredentialParam param,
  }) async {
    final valid = <CredentialEntity>[];
    final expiredRefreshable = <CredentialEntity>[];

    // Phase 1: classify all credentials and persist newly-discovered
    // expirations so the DB is consistent before any routing decision.
    for (final credential in param.credentials) {
      final isExpired = await _classifyAndMarkExpired(
        credential: credential,
        genesisDid: param.genesisDid,
        privateKey: param.privateKey,
      );
      if (isExpired == null) continue; // unparseable expiration — skip
      if (!isExpired) {
        valid.add(credential);
      } else if (credential.info.containsKey("refreshService")) {
        expiredRefreshable.add(credential);
      }
    }

    // Phase 2: prefer a valid credential over any refresh attempt.
    if (valid.isNotEmpty) return valid.first;

    // Phase 3: all candidates are expired — try to refresh (in order).
    for (final candidate in expiredRefreshable) {
      final refreshed = await _tryRefresh(
        credential: candidate,
        genesisDid: param.genesisDid,
        privateKey: param.privateKey,
      );
      if (refreshed != null) return refreshed;
    }

    return null;
  }

  /// Checks whether [credential] is expired and, if it is and its stored
  /// state is not yet [CredentialState.expired], writes the update to the DB.
  ///
  /// Returns `false` (valid), `true` (expired), or `null` (unparseable — skip).
  Future<bool?> _classifyAndMarkExpired({
    required CredentialEntity credential,
    required String genesisDid,
    required String privateKey,
  }) async {
    // Already flagged in the DB — nothing to persist.
    if (credential.state == CredentialState.expired) return true;

    // No expiration date → credential never expires.
    final expiration = credential.expiration;
    if (expiration == null) return false;

    final expirationTime = DateTime.tryParse(expiration);
    if (expirationTime == null) {
      _stacktraceManager.addError(
        "[CheckAndRefreshExpiredCredentialUseCase] Could not parse"
        " expiration '$expiration' for credential"
        " ${credential.id}; treating as expired.",
        log: true,
      );
      return null;
    }

    if (!DateTime.now().toUtc().isAfter(expirationTime.toUtc())) return false;

    // Newly discovered as expired — persist to DB.
    try {
      await _updateClaimUseCase.execute(
        param: UpdateClaimParam(
          id: credential.id,
          genesisDid: genesisDid,
          state: CredentialState.expired,
          encryptionKey: privateKey,
        ),
      );
    } catch (e) {
      _stacktraceManager.addError(
        "[CheckAndRefreshExpiredCredentialUseCase] Failed to mark"
        " credential ${credential.id} as expired in DB: $e",
        log: true,
      );
      // Non-fatal — still treat as expired for routing purposes.
    }

    return true;
  }

  /// Attempts to refresh [credential] via its `refreshService`.
  ///
  /// Returns the refreshed [CredentialEntity] on success, or `null` if the
  /// refresh throws (the error is logged and a failure step is emitted).
  Future<CredentialEntity?> _tryRefresh({
    required CredentialEntity credential,
    required String genesisDid,
    required String privateKey,
  }) async {
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
      _stacktraceManager.addError(
        "[CheckAndRefreshExpiredCredentialUseCase] Refresh failed for"
        " credential $credentialId: $e\n$s",
        log: true,
      );
      _proofGenerationStepsStreamManager.add(
        "Credential refresh failed for $credentialId: $e",
      );
      return null;
    }
  }
}
