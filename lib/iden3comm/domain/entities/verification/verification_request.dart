/*
{
    "did_doc": {
      "@context": [
        "https://www.w3.org/ns/did/v1",
        "https://w3id.org/security/suites/ed25519-2020/v1"
      ],
      "id": "did:iden3:polygon:main:117kKobYUMLU13bvZe49VMD95AQn5imAuTXBaJfpx8",
      "keyAgreement": [
        "did:iden3:polygon:main:117kKobYUMLU13bvZe49VMD95AQn5imAuTXBaJfpx8#encryptionkey1"
      ],
      "verificationMethod": [
        {
          "id": "did:iden3:polygon:main:117kKobYUMLU13bvZe49VMD95AQn5imAuTXBaJfpx8#encryptionkey1",
          "type": "X25519KeyAgreementKey2019",
          "controller": "did:iden3:polygon:main:117kKobYUMLU13bvZe49VMD95AQn5imAuTXBaJfpx8",
          "jwk": {
             "kty": "OKP",
             "crv": "X25519",
              "x": "USER KEY",
              "alg": "ECDH-ES+A256KW"
         }
        }
      ]
    },
    "credentialProof": {
        "proof": {
            "pi_a": [
                "19984319424295735786088222090728819587442428348500427054861578953736034944056",
                "16234415280486348852409578201878324650858769494030221503792100287029384234469",
                "1"
            ],
            "pi_b": [
                [
                    "9402637461012057548325212014180341918140247083762678560888387386366254033817",
                    "2594196258333154082822531200222879013248293991717359014020514207755983276502"
                ],
                [
                    "477444661387502548043652997629667853042550950176540328748235645664448249209",
                    "10428902246548601241409446744936243803049748667800328431056157044244785975013"
                ],
                [
                    "1",
                    "0"
                ]
            ],
            "pi_c": [
                "8486814986573006745601495217944830898854659179831822545417610654179603983807",
                "10920065940813810165431562068701860077376133780569424991501312107193731390745",
                "1"
            ],
            "protocol": "groth16",
            "curve": "bn128"
        },
        "pub_signals": [
            "2319705938947615989952654766366044996080423715818076372644433669664113397438",
            "18960700174557964133969353583409906188495757612011584839381846165876431045882",
            "7668863955023794354136517968333598181890863196787275570450715710778981263898",
            "250410",
            "1744304702",
            "3532467563022391950170321692541635800576371972220969617740093781820662149190"
        ]
    },
    "dg1Hash": "623CA68CD...",
    "dgHashFunction": "sha256",
    "eContent": "3082014c020100300b0...",
    "encryptedDigest": "3082014c020100300b0...",
    "signedAttr": "3166",
    "dscPem": "-----BEGIN CERTIFICATE-----...-----END CERTIFICATE-----",
    "linkNonce": "8023"
  }
*/

import 'package:polygonid_flutter_sdk/common/json.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/zkproof_entity.dart';

@Deprecated('Use VerificationRequestMessage instead')
typedef VerificationRequestEntity = VerificationRequestMessage;

class VerificationRequestMessage extends Iden3Message<VerificationRequestBody> {
  VerificationRequestMessage({
    required super.id,
    required super.typ,
    @Deprecated('may be omitted, gonna be removed in the future') String? type,
    super.thid,
    required super.from,
    required super.body,
    super.to,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(type: Iden3MessageType.verificationRequest);

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [VerificationRequestMessage]
  factory VerificationRequestMessage.fromJson(Map<String, dynamic> json) {
    final body = VerificationRequestBody.fromJson(json['body']);
    return VerificationRequestMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      from: json['from'],
      to: json['to'],
      body: body,
    );
  }

  @override
  String toString() {
    return "[VerificationRequestMessage] {${super.toString()}";
  }

  @override
  bool operator ==(Object other) =>
      super == other && other is VerificationRequestMessage;

  @override
  int get hashCode => runtimeType.hashCode;
}

class VerificationRequestBody implements JsonEncodable {
  final Map<String, dynamic> didDoc;
  final ZKProofEntity credentialProof;

  final String dg1Hash;
  final String dgHashFunction;
  final String eContent;
  final String encryptedDigest;
  final String signedAttr;
  final String dscPem;
  final String linkNonce;

  VerificationRequestBody({
    required this.didDoc,
    required this.credentialProof,
    required this.dg1Hash,
    required this.dgHashFunction,
    required this.eContent,
    required this.encryptedDigest,
    required this.signedAttr,
    required this.dscPem,
    required this.linkNonce,
  });

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [OfferBodyRequest]
  factory VerificationRequestBody.fromJson(Map<String, dynamic> json) {
    return VerificationRequestBody(
      didDoc: json['did_doc'],
      credentialProof: ZKProofEntity.fromJson(json['credentialProof']),
      dg1Hash: json['dg1Hash'],
      dgHashFunction: json['dgHashFunction'],
      eContent: json['eContent'],
      encryptedDigest: json['encryptedDigest'],
      signedAttr: json['signedAttr'],
      dscPem: json['dscPem'],
      linkNonce: json['linkNonce'],
    );
  }

  Map<String, dynamic> toJson() => {
    'did_doc': didDoc,
    'credentialProof': credentialProof.toJson(),
    'dg1Hash': dg1Hash,
    'dgHashFunction': dgHashFunction,
    'eContent': eContent,
    'encryptedDigest': encryptedDigest,
    'signedAttr': signedAttr,
    'dscPem': dscPem,
    'linkNonce': linkNonce,
  };

  @override
  String toString() =>
      "[VerificationRequestBody] {didDoc: $didDoc, credentialProof: $credentialProof, dg1Hash: $dg1Hash, dgHashFunction: $dgHashFunction, eContent: $eContent, encryptedDigest: $encryptedDigest, signedAttr: $signedAttr, dscPem: $dscPem, linkNonce: $linkNonce}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VerificationRequestBody &&
          runtimeType == other.runtimeType &&
          didDoc == other.didDoc &&
          credentialProof == other.credentialProof &&
          dg1Hash == other.dg1Hash &&
          dgHashFunction == other.dgHashFunction &&
          eContent == other.eContent &&
          encryptedDigest == other.encryptedDigest &&
          signedAttr == other.signedAttr &&
          dscPem == other.dscPem &&
          linkNonce == other.linkNonce;

  @override
  int get hashCode => runtimeType.hashCode;
}
