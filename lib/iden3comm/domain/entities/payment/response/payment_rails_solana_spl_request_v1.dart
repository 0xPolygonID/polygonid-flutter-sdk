import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/payment/response/payment_request_message_entity.dart';

class Iden3PaymentRailsSolanaSPLRequestV1Data extends PaymentRequestData {
  final String type;
  final List<String> context;
  final String recipient;
  final String amount;
  final String expirationDate;
  final String nonce;
  final String metadata;
  final List<PaymentRequestDataSolanaProof> proof;
  final String tokenAddress;
  final List<String>? features;

  @override
  PaymentRequestDataType get paymentRequestDataType =>
      PaymentRequestDataType.railsSolanaSPLV1;

  Iden3PaymentRailsSolanaSPLRequestV1Data({
    required this.type,
    required this.context,
    required this.recipient,
    required this.amount,
    required this.expirationDate,
    required this.nonce,
    required this.metadata,
    required this.proof,
    required this.tokenAddress,
    this.features,
  });

  factory Iden3PaymentRailsSolanaSPLRequestV1Data.fromJson(
      Map<String, dynamic> json) {
    return Iden3PaymentRailsSolanaSPLRequestV1Data(
      type: json['type'],
      context: List<String>.from(json['@context']),
      recipient: json['recipient'],
      amount: json['amount'],
      expirationDate: json['expirationDate'],
      nonce: json['nonce'],
      metadata: json['metadata'],
      proof: (json['proof'] as List<dynamic>)
          .map((e) => PaymentRequestDataSolanaProof.fromJson(e))
          .toList(),
      tokenAddress: json['tokenAddress'],
      features:
          json['features'] != null ? List<String>.from(json['features']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "@context": context,
      "recipient": recipient,
      "amount": amount,
      "expirationDate": expirationDate,
      "nonce": nonce,
      "metadata": metadata,
      "proof": proof.map((e) => e.toJson()).toList(),
      "tokenAddress": tokenAddress,
      if (features != null) "features": features,
    };
  }
}

class PaymentRequestDataSolanaProof {
  final String type;
  final String proofPurpose;
  final String proofValue;
  final String signedMessage;
  final String created;
  final String pubKey;

  final PaymentRequestDataSolanaProofDomain domain;

  PaymentRequestDataSolanaProof({
    required this.type,
    required this.proofPurpose,
    required this.proofValue,
    required this.signedMessage,
    required this.created,
    required this.pubKey,
    required this.domain,
  });

  factory PaymentRequestDataSolanaProof.fromJson(Map<String, dynamic> json) {
    return PaymentRequestDataSolanaProof(
      type: json['type'],
      proofPurpose: json['proofPurpose'],
      proofValue: json['proofValue'],
      signedMessage: json['signedMessage'],
      created: json['created'],
      pubKey: json['pubKey'],
      domain: PaymentRequestDataSolanaProofDomain.fromJson(json['domain']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "proofPurpose": proofPurpose,
      "proofValue": proofValue,
      "signedMessage": signedMessage,
      "created": created,
      "pubKey": pubKey,
      "domain": domain.toJson(),
    };
  }
}

class PaymentRequestDataSolanaProofDomain {
  final String version;
  final String chainId;
  final String verifyingContract;

  PaymentRequestDataSolanaProofDomain({
    required this.version,
    required this.chainId,
    required this.verifyingContract,
  });

  factory PaymentRequestDataSolanaProofDomain.fromJson(
      Map<String, dynamic> json) {
    return PaymentRequestDataSolanaProofDomain(
      version: json['version'],
      chainId: json['chainId'],
      verifyingContract: json['verifyingContract'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "version": version,
      "chainId": chainId,
      "verifyingContract": verifyingContract,
    };
  }
}
