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

    return AttestationResult(
      publicKey: publicKey,
    );
  }
}

class AttestationResult {
  /// The public key hex encoded.
  final String publicKey;

  AttestationResult({
    required this.publicKey,
  });

  @override
  String toString() {
    return 'AttestationResult{publicKey: $publicKey}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttestationResult &&
          runtimeType == other.runtimeType &&
          publicKey == other.publicKey;

  @override
  int get hashCode => publicKey.hashCode;
}
