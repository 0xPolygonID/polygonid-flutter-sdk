import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/attestation/attestation_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/attestation/attestation_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_request_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/response/auth_response_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/response/problem_report_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/credential_proposal_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/credential_refresh_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/offer_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/onchain_offer_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/response/credential_proposal_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/response/credential_status_update_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/response/fetch_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/payment/payment_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/payment/response/payment_request_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/request/contract_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/request/contract_response_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/verification/verification_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/verification/verification_response.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';

class GetIden3MessageUseCase extends FutureUseCase<String, Iden3MessageEntity> {
  final StacktraceManager _stacktraceManager;

  GetIden3MessageUseCase(
    this._stacktraceManager,
  );

  @override
  Future<Iden3MessageEntity> execute({required String param}) async {
    try {
      Map<String, dynamic> json = jsonDecode(param);

      final rawType = json['type'] ?? '';
      final type = Iden3MessageType.fromType(rawType);

      switch (type) {
        case Iden3MessageType.authRequest:
          return AuthorizationRequestMessage.fromJson(json);
        case Iden3MessageType.authResponse:
          return AuthorizationResponseMessage.fromJson(json);
        case Iden3MessageType.credentialOffer:
          return CredentialsOfferMessage.fromJson(json);
        case Iden3MessageType.onchainCredentialOffer:
          return CredentialsOnchainOfferMessage.fromJson(json);
        case Iden3MessageType.credentialIssuanceResponse:
          return CredentialFetchRequestMessage.fromJson(json);
        case Iden3MessageType.proofContractInvokeRequest:
          return ContractInvokeRequestMessage.fromJson(json);
        case Iden3MessageType.proofContractInvokeResponse:
          return ContractInvokeResponseMessage.fromJson(json);
        case Iden3MessageType.credentialRefresh:
          return CredentialRefreshMessage.fromJson(json);
        case Iden3MessageType.credentialStatusUpdate:
          return CredentialStatusUpdateMessage.fromJson(json);
        case Iden3MessageType.credentialProposalRequest:
          return ProposalRequestMessage.fromJson(json);
        case Iden3MessageType.credentialProposal:
          return ProposalMessage.fromJson(json);
        case Iden3MessageType.problemReport:
          return ProblemReportMessage.fromJson(json);
        case Iden3MessageType.paymentRequest:
          return PaymentRequestMessage.fromJson(json);
        case Iden3MessageType.payment:
          return PaymentMessage.fromJson(json);
        case Iden3MessageType.attestationRequest:
          return AttestationRequestMessage.fromJson(json);
        case Iden3MessageType.attestationResponse:
          return AttestationResponseMessage.fromJson(json);
        case Iden3MessageType.verificationRequest:
          return VerificationRequestMessage.fromJson(json);
        case Iden3MessageType.verificationResponse:
          return VerificationResponseMessage.fromJson(json);
        case Iden3MessageType.fetchRequest:
          return CredentialFetchRequestMessage.fromJson(json);
        default:
          throw UnsupportedIden3MsgTypeException(
            type: type,
            errorMessage: "Unsupported message type: $type",
            message: json,
          );
      }
    } catch (error) {
      _stacktraceManager.addError("[GetIden3MessageUseCase] error: $error");
      return Future.error(error);
    }
  }
}
