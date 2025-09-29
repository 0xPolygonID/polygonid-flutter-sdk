// Protocol constants
const String _iden3Protocol = 'https://iden3-communication.io/';
const String _didcommProtocol = 'https://didcomm.org/';

class ProtocolMessageType {
  // Private constructor to prevent instantiation
  ProtocolMessageType._();

  ///
  /// Authorization
  ///

  static const authorizationRequestMessageType =
      '${_iden3Protocol}authorization/1.0/request';

  static const authorizationResponseMessageType =
      '${_iden3Protocol}authorization/1.0/response';

  ///
  /// Credentials
  ///

  static const credentialIssuanceRequestMessageType =
      '${_iden3Protocol}credentials/1.0/issuance-request';

  static const credentialIssuanceResponseMessageType =
      '${_iden3Protocol}credentials/1.0/issuance-response';

  static const credentialFetchRequestMessageType =
      '${_iden3Protocol}credentials/1.0/fetch-request';

  static const credentialOfferMessageType =
      '${_iden3Protocol}credentials/1.0/offer';

  static const credentialStatusUpdateMessageType =
      '${_iden3Protocol}credentials/1.0/status-update';

  static const credentialRefreshMessageType =
      '${_iden3Protocol}credentials/1.0/refresh';

  static const credentialOnchainOfferMessageType =
      '${_iden3Protocol}credentials/1.0/onchain-offer';

  ///
  /// Credentials payments
  ///

  static const proposalRequestMessageType =
      '${_iden3Protocol}credentials/0.1/proposal-request';

  static const proposalMessageType =
      '${_iden3Protocol}credentials/0.1/proposal';

  static const paymentRequestMessageType =
      '${_iden3Protocol}credentials/0.1/payment-request';

  static const paymentMessageType = '${_iden3Protocol}credentials/0.1/payment';

  ///
  /// Proofs
  ///

  static const contractInvokeRequestMessageType =
      '${_iden3Protocol}proofs/1.0/contract-invoke-request';

  static const contractInvokeResponseMessageType =
      '${_iden3Protocol}proofs/1.0/contract-invoke-response';

  ///
  /// Revocation
  ///

  static const revocationStatusRequestMessageType =
      '${_iden3Protocol}revocation/1.0/request-status';

  static const revocationStatusResponseMessageType =
      '${_iden3Protocol}revocation/1.0/status';

  ///
  /// Problem report
  ///

  static const problemReportMessageType =
      '${_didcommProtocol}report-problem/2.0/problem-report';

  ///
  /// Attestation and verification
  ///

  static const attestationRequestMessageType =
      '${_iden3Protocol}attestation/0.1/request';
  static const attestationResponseMessageType =
      '${_iden3Protocol}attestation/0.1/response';

  static const verificationRequestMessageType =
      '${_iden3Protocol}passport/0.1/verification-request';
  static const verificationResponseMessageType =
      '${_iden3Protocol}passport/0.1/verification-response';

  ///
  /// Resource management
  ///

  static const resourceRequestMessageType =
      '$_iden3Protocol/resource-management/0.1/request';
  static const resourcePermissionsUpdateRequestMessageType =
      '$_iden3Protocol/resource-management/0.1/permissions-update-request';
  static const resourcePermissionsUpdateMessageType =
      '$_iden3Protocol/resource-management/0.1/permissions-update';
  static const resourceDeliveryMessageType =
      '$_iden3Protocol/resource-management/0.1/delivery';

  static const resourcePermissionsRequestsListMessageType =
      '$_iden3Protocol/resource-management/0.1/permissions-requests-list';
  static const resourcePermissionsListFetchMessageType =
      '$_iden3Protocol/resource-management/0.1/permissions-list-fetch';
  static const resourcePermissionsListMessageType =
      '$_iden3Protocol/resource-management/0.1/permissions-list';
}
