import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/pidcore_util.dart';

@injectable
class Util {
  final PolygonIdCoreUtil _polygonIdCoreUtil;

  Util(this._polygonIdCoreUtil);

  /// Validates the attestation document and returns the public key and its components.
  /// [attestationDocument] - base64 encoded attestation document.
  /// Returns an [AttestationResult] containing the public key and its components.
  /// If the attestation document is invalid, it will throw an [CoreLibraryException].
  AttestationResult validateAttestationDocument(String attestationDocument) {
    final result =
        _polygonIdCoreUtil.validateAttestationDocument(attestationDocument);
    final publicKey = result['public_key'] as String?;
    final userData = result['user_data'] as String?;

    return AttestationResult(
      publicKey: publicKey,
      userData: userData,
    );
  }
}

class AttestationResult {
  /// The public key hex encoded.
  final String? publicKey;
  final String? userData;

  AttestationResult({
    this.publicKey,
    this.userData,
  });

  @override
  String toString() {
    return 'AttestationResult{publicKey: $publicKey, userData: $userData}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttestationResult &&
          runtimeType == other.runtimeType &&
          publicKey == other.publicKey &&
          userData == other.userData;

  @override
  int get hashCode => publicKey.hashCode ^ userData.hashCode;
}
