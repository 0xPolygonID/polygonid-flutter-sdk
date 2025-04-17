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

import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

class VerificationResponseEntity
    extends Iden3MessageEntity<VerificationResponseBody> {
  VerificationResponseEntity({
    required super.id,
    required super.typ,
    required super.type,
    required super.thid,
    required super.from,
    required super.body,
    super.to,
    super.nextRequest,
  }) : super(messageType: Iden3MessageType.verificationResponse);

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [VerificationResponseEntity]
  factory VerificationResponseEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    final body = VerificationResponseBody.fromJson(json['body']);
    return VerificationResponseEntity(
      id: json['id'],
      typ: json['typ'],
      type: json['type'],
      thid: json['thid'],
      from: json['from'],
      to: json['to'],
      body: body,
      nextRequest: json['next_request'],
    );
  }

  @override
  String toString() => "[VerificationResponseEntity] {${super.toString()}";

  @override
  bool operator ==(Object other) =>
      super == other && other is VerificationResponseEntity;

  @override
  int get hashCode => runtimeType.hashCode;
}

class VerificationResponseBody {
  final String status;
  final String? txHash;

  VerificationResponseBody({
    required this.status,
    this.txHash,
  });

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [OfferBodyRequest]
  factory VerificationResponseBody.fromJson(Map<String, dynamic> json) {
    return VerificationResponseBody(
      status: json['status'],
      txHash: json['txHash'],
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'txHash': txHash,
      };

  @override
  String toString() =>
      "[VerificationResponseBody] {status: $status, txHash: $txHash}";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VerificationResponseBody &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          txHash == other.txHash;

  @override
  int get hashCode => runtimeType.hashCode;
}
