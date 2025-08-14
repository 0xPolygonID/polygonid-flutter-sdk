// ignore_for_file: overridden_fields

import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/payment/response/payment_rails_erc20_request_v1_data.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/payment/response/payment_rails_request_v1_data.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/payment/response/payment_rails_solana_request_v1.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/payment/response/payment_rails_solana_spl_request_v1.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/payment/response/payment_request_crypto_v1_data.dart';

/*
https://iden3-communication.io/credentials/0.1/payment-request

{
  "id": "36f9e851-d713-4b50-8f8d-8a9382f138ca",
  "thid": "36f9e851-d713-4b50-8f8d-8a9382f138ca",
  "typ": "application/iden3comm-plain-json",
  "type": "https://iden3-communication.io/credentials/0.1/payment-request",
  "body": {
     "payments": [
      {
       "credentials": [
        {
         "type": "AML",
         "context": "http://test.com"
        }
       ],
       "type": "PaymentRequest",
       "data": {
	       "type": "Iden3PaymentCryptoV1",
	       "amount": 10,
	       "id": "ox",
	       "address": "0xpay1",
	       "signature": "sig"
       },
       "agent": "https://issuer.com",
       "expiration": "timestamp",
       "description": "you can pass the verification on our KYC provider by following the next link"
     }
	  ]
  },
  "to": "did:polygonid:polygon:mumbai:2qJUZDSCFtpR8QvHyBC4eFm6ab9sJo5rqPbcaeyGC4",
  "from": "did:iden3:polygon:mumbai:x3HstHLj2rTp6HHXk2WczYP7w3rpCsRbwCMeaQ2H2"
}
*/
@Deprecated('Use PaymentRequestMessage instead')
typedef PaymentRequestEntity = PaymentRequestMessage;

class PaymentRequestMessage extends Iden3Message<PaymentRequestBody> {
  @override
  final String from;

  @override
  final String to;

  PaymentRequestMessage({
    required super.id,
    required super.typ,
    @Deprecated('may be omitted, gonna be removed in the future') String? type,
    required super.thid,
    required this.from,
    required this.to,
    required super.body,
    super.createdTime,
    super.expiresTime,
    super.attachments = const [],
  }) : super(
          type: Iden3MessageType.paymentRequest,
          from: from,
          to: to,
        );

  factory PaymentRequestMessage.fromJson(Map<String, dynamic> json) {
    return PaymentRequestMessage(
      id: json['id'],
      typ: json['typ'],
      thid: json['thid'],
      body: PaymentRequestBody.fromJson(json['body']),
      from: json['from'],
      to: json['to'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      "body": body.toJson(),
    };
  }
}

class PaymentRequestBody {
  final String agent;
  final List<PaymentRequestInfo> payments;

  PaymentRequestBody({
    required this.agent,
    required this.payments,
  });

  factory PaymentRequestBody.fromJson(Map<String, dynamic> json) {
    return PaymentRequestBody(
      agent: json['agent'],
      payments: (json['payments'] as List<dynamic>)
          .map((x) => PaymentRequestInfo.fromJson(x))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "agent": agent,
      "payments": payments.map((e) => e.toJson()).toList(),
    };
  }
}

@Deprecated('Use PaymentRequestInfo instead')
typedef PaymentRequest = PaymentRequestInfo;

class PaymentRequestInfo {
  final List<CredentialSchemaInfo> credentials;
  final List<PaymentRequestData> data;
  final String? description;

  PaymentRequestInfo({
    required this.credentials,
    required this.data,
    this.description,
  });

  factory PaymentRequestInfo.fromJson(Map<String, dynamic> json) {
    return PaymentRequestInfo(
      description: json['description'],
      credentials: (json['credentials'] as List<dynamic>)
          .map((x) => CredentialSchemaInfo.fromJson(x))
          .toList(),
      data: json['data'] is List
          ? (json['data'] as List<dynamic>)
              .map((x) => PaymentRequestDataFactory.fromJson(x))
              .toList()
          : json['data'] is Map<String, dynamic>
              ? [PaymentRequestDataFactory.fromJson(json['data'])]
              : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "credentials": credentials.map((e) => e.toJson()).toList(),
      "data": data.map((e) => e.toJson()).toList(),
    };
  }
}

enum PaymentRequestDataType {
  cryptoV1,
  railsV1,
  railsERC20V1,
  railsSolanaV1,
  railsSolanaSPLV1,
}

class PaymentRequestDataFactory {
  static PaymentRequestData fromJson(Map<String, dynamic> json) {
    String type = json['type'];

    switch (type) {
      case 'Iden3PaymentRequestCryptoV1':
        return Iden3PaymentRequestCryptoV1.fromJson(json);
      case 'Iden3PaymentRailsRequestV1':
        return Iden3PaymentRailsRequestV1.fromJson(json);
      case 'Iden3PaymentRailsERC20RequestV1':
        return Iden3PaymentRailsERC20RequestV1.fromJson(json);
      case 'Iden3PaymentRailsSolanaRequestV1':
        return Iden3PaymentRailsSolanaRequestV1Data.fromJson(json);
      case 'Iden3PaymentRailsSolanaSPLRequestV1':
        return Iden3PaymentRailsSolanaSPLRequestV1Data.fromJson(json);
      default:
        throw Exception('Unknown payment request data type: $type');
    }
  }
}

/*
"proposals": [{
			"credentials": [{
				"type": "AnimaProofOfLife",
				"context": "https://raw.githubusercontent.com/anima-protocol/claims-polygonid/main/schemas/json-ld/pol-v1.json-ld"
			}],
			"type": "SynapsCredentialProposal",
			"url": "https://synaps-backend-test.polygonid.me/verification?session={{sessionID}}&did={{holderDid}}",
			"description": "Synaps credential proposal"
		}]
*/

@Deprecated('Use CredentialSchemaInfo instead')
typedef CredentialInfo = CredentialSchemaInfo;

abstract class PaymentRequestData {
  String get type;

  PaymentRequestDataType get paymentRequestDataType;

  Map<String, dynamic> toJson();
}
