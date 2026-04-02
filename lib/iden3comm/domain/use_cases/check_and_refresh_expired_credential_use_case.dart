import 'package:intl/intl.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
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
    extends FutureUseCase<CheckAndRefreshExpiredCredentialParam,
        CredentialEntity?> {
  final RefreshCredentialUseCase _refreshCredentialUseCase;
  final ProofGenerationStepsStreamManager _proofGenerationStepsStreamManager;

  CheckAndRefreshExpiredCredentialUseCase(
    this._refreshCredentialUseCase,
    this._proofGenerationStepsStreamManager,
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
    if (credential.expiration == null) return credential;

    final now = DateTime.now().toUtc();
    final expirationTime = DateFormat(
      "yyyy-MM-ddTHH:mm:ssZ",
    ).parse(credential.expiration!);

    final nowFormatted = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
    final expirationFormatted = DateFormat(
      "yyyy-MM-dd HH:mm:ss",
    ).format(expirationTime);

    final isExpired =
        nowFormatted.compareTo(expirationFormatted) > 0 ||
        credential.state == CredentialState.expired;

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
      } catch (_) {
        // Refresh failed — fall through to try the next candidate.
      }
    }

    return null;
  }
}
