import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/pidcore_util.dart';

@injectable
class Util {
  final PolygonIdCoreUtil _polygonIdCoreUtil;

  Util(this._polygonIdCoreUtil);

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
  final String publicKey;
  final String? publicKeyX;
  final String? publicKeyY;

  AttestationResult({
    required this.publicKey,
    this.publicKeyX,
    this.publicKeyY,
  });
}
