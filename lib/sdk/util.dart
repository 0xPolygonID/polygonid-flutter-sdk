import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/pidcore_util.dart';
import 'package:polygonid_flutter_sdk/common/utils/did_doc_compose.dart';
import 'package:polygonid_flutter_sdk/common/utils/push_service.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_info_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_request_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/response/auth_response_iden3_message_entity.dart';
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
    final result = _polygonIdCoreUtil.validateAttestationDocument(
      attestationDocument,
    );
    final publicKey = result['public_key'] as String?;
    final userData = result['user_data'] as String?;

    return AttestationResult(publicKey: publicKey, userData: userData);
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
          'didDocumentMetadata': null,
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
  String anonUnpack(Map<String, dynamic> ciphertext,
      List<Map<String, dynamic>> keys,) {
    final json = {
      'ciphertext': ciphertext,
      'keySet': {'keys': keys},
    };
    final input = jsonEncode(json);

    return _polygonIdCoreUtil.anonUnpack(input);
  }

  String decryptJwe(Map<String, dynamic> jwe, List<Map<String, dynamic>> keys) {
    final json = {
      'ciphertext': jwe,
      'keySet': {'keys': keys},
    };
    final input = jsonEncode(json);

    return _polygonIdCoreUtil.decryptJwe(input);
  }

  W3CCredential decryptEncryptedCredential(
      Map<String, dynamic> encryptedCredentialIssuanceMessage,
      List<Map<String, dynamic>> keys,) {
    final json = {
      'encryptedCredentialIssuanceMessage': encryptedCredentialIssuanceMessage,
      'keySet': {'keys': keys},
    };
    final input = jsonEncode(json);

    final result = _polygonIdCoreUtil.decryptEncryptedCredential(input);

    return W3CCredential.fromJson(jsonDecode(result));
  }

  bool verifyProof(W3CCredential credential) {
    final input = jsonEncode(credential.toJson());

    return _polygonIdCoreUtil.verifyProof(input);
  }

  /// Verifies an authorization response against the original request and a set of keys.
  /// [request] - The original authorization request.
  /// [response] - The authorization response to be verified. Can be plain iden3
  /// message, JWE or JWZ format.
  /// [keys] - List of keys to verify the response if it is JWE format.
  /// Returns a string indicating the verification result.
  AuthorizationResponseMessage verifyAuthResponse({
    required AuthorizationRequestMessage request,
    required dynamic response,
    List<Map<String, dynamic>> keys = const [],
    String acceptedStateTransitionDelay = '8784h',
    String acceptedProofGenerationDelay = '8784h',
  }) {
    final input = jsonEncode({
      'authRequest': request.toJson(),
      'authResponse': response,
      'keySet': {'keys': keys},
      'options': {
        'accepted_state_transition_delay': acceptedStateTransitionDelay,
        'accepted_proof_generation_delay': acceptedProofGenerationDelay,
      },
    });

    final result = _polygonIdCoreUtil.verifyAuthResponse(input);

    return AuthorizationResponseMessage.fromJson(jsonDecode(result));
  }

  Future<DIDDocument> createDidDocument(String profileDid, {
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

  AttestationResult({this.publicKey, this.userData});

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
