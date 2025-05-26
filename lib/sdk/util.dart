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
    final publicKey = result['public_key'] as String;
    final publicKeyX = result['public_key_x_int'] as String?;
    final publicKeyY = result['public_key_y_int'] as String?;

    return AttestationResult(
      publicKey: publicKey,
      publicKeyX: publicKeyX,
      publicKeyY: publicKeyY,
    );
  }
}

class AttestationResult {
  /// The public key base64 encoded PKIX, ASN.1 DER form.
  final String publicKey;

  /// X & Y only would be presented if EC signing was used.
  /// If RSA used, there would be only publicKey.
  final String? publicKeyX;
  final String? publicKeyY;

  AttestationResult({
    required this.publicKey,
    this.publicKeyX,
    this.publicKeyY,
  });

  @override
  String toString() {
    return 'AttestationResult{publicKey: $publicKey, publicKeyX: $publicKeyX, publicKeyY: $publicKeyY}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttestationResult &&
          runtimeType == other.runtimeType &&
          publicKey == other.publicKey &&
          publicKeyX == other.publicKeyX &&
          publicKeyY == other.publicKeyY;

  @override
  int get hashCode =>
      publicKey.hashCode ^ publicKeyX.hashCode ^ publicKeyY.hashCode;
}
