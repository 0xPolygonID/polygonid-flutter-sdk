import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/pidcore_util.dart';
import 'package:polygonid_flutter_sdk/common/utils/did_doc_compose.dart';
import 'package:polygonid_flutter_sdk/common/utils/push_service.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/did_doc/did_document.dart';

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

  /// Encrypts the input plaintext using provided keyset into JWE format.
  /// [message] - The plaintext message to be encrypted.
  /// [recipientDidDocs] - List of recipient DID Documents.
  /// [recipientAlg] - Optional map of recipient algorithms. DID as key and algorithm as value.
  /// Returns the encrypted message in JWE format.
  String anonPack({
    required Map<String, dynamic> message,
    required List<DIDDocument> recipientDidDocs,
    Map<String, String>? recipientAlg,
  }) {
    final json = {
      'message': message,
      'recipientDidDocs': recipientDidDocs.map((e) {
        return {
          'didDocument': e.toJson(),
          'didResolutionMetadata': null,
          'didDocumentMetadata': null
        };
      }).toList(),
      if (recipientAlg != null) 'recipientAlg': recipientAlg,
    };
    final input = jsonEncode(json);

    return _polygonIdCoreUtil.anonPack(input);
  }

  /// Decrypts the input ciphertext using provided keyset from JWE format.
  /// [ciphertext] - The encrypted message in JWE format.
  /// [keys] - List of keys to decrypt the message.
  /// Returns the decrypted plaintext message.
  String anonUnpack(
      Map<String, dynamic> ciphertext, List<Map<String, dynamic>> keys) {
    final json = {
      'ciphertext': ciphertext,
      'keySet': {
        'keys': keys,
      },
    };
    final input = jsonEncode(json);

    return _polygonIdCoreUtil.anonUnpack(input);
  }

  Future<DIDDocument> createDidDocument(
    String profileDid, {
    PushServiceData? pushServiceData,
    String? redirectUrl,
    List<String>? keyAgreement,
    List<VerificationMethod>? verificationMethod,
  }) async {
    return composeDidDoc(
      did: profileDid,
      redirectUrl: redirectUrl,
      pushServiceData: pushServiceData,
      keyAgreement: keyAgreement,
      verificationMethod: verificationMethod,
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
