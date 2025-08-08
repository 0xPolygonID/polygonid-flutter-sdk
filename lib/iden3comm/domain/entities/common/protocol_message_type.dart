// Protocol constants
const String _iden3Protocol = 'https://iden3-communication.io/';
const String _didcommProtocol = 'https://didcomm.org/';

class ProtocolMessageType {
  // Private constructor to prevent instantiation
  ProtocolMessageType._();

  // AuthorizationV2RequestMessageType defines auth request type of the communication protocol
  static const authorizationRequestMessageType =
      '${_iden3Protocol}authorization/1.0/request';

  // AuthorizationResponseMessageType defines auth response type of the communication protocol
  static const authorizationResponseMessageType =
      '${_iden3Protocol}authorization/1.0/response';

  // CredentialIssuanceRequestMessageType accepts request for credential creation
  static const credentialIssuanceRequestMessageType =
      '${_iden3Protocol}credentials/1.0/issuance-request';

  // CredentialFetchRequestMessageType is type for request of credential generation
  static const credentialFetchRequestMessageType =
      '${_iden3Protocol}credentials/1.0/fetch-request';

  // CredentialOfferMessageType is type of message with credential offering
  static const credentialOfferMessageType =
      '${_iden3Protocol}credentials/1.0/offer';

  // CredentialIssuanceResponseMessageType is type for message with a credential issuance
  static const credentialIssuanceResponseMessageType =
      '${_iden3Protocol}credentials/1.0/issuance-response';

  // CredentialRefreshMessageType is type for message with a credential issuance
  static const credentialRefreshMessageType =
      '${_iden3Protocol}credentials/1.0/refresh';

  // DeviceRegistrationRequestMessageType defines device registration request type of the communication protocol
  static const deviceRegistrationRequestMessageType =
      '${_iden3Protocol}devices/1.0/registration';

  // MessageFetMessageFetchRequestMessageType defines message fetch request type of the communication protocol.
  static const messageFetchRequestMessageType =
      '${_iden3Protocol}messages/1.0/fetch';

  // ProofGenerationRequestMessageType is type for request of proof generation
  static const proofGenerationRequestMessageType =
      '${_iden3Protocol}proofs/1.0/request';

  // ProofGenerationResponseMessageType is type for response of proof generation
  static const proofGenerationResponseMessageType =
      '${_iden3Protocol}proofs/1.0/response';

  // RevocationStatusRequestMessageType is type for request of revocation status
  static const revocationStatusRequestMessageType =
      '${_iden3Protocol}revocation/1.0/request-status';

  // RevocationStatusResponseMessageType is type for response with a revocation status
  static const revocationStatusResponseMessageType =
      '${_iden3Protocol}revocation/1.0/status';

  // ContractInvokeRequestMessageType is type for request of contract invoke request
  static const contractInvokeRequestMessageType =
      '${_iden3Protocol}proofs/1.0/contract-invoke-request';

  // ContractInvokeResponseMessageType is type for response of contract invoke request
  static const contractInvokeResponseMessageType =
      '${_iden3Protocol}proofs/1.0/contract-invoke-response';

  // CredentialOnchainOfferMessageType is type of message with credential onchain offering
  static const credentialOnchainOfferMessageType =
      '${_iden3Protocol}credentials/1.0/onchain-offer';

  // ProposalRequestMessageType is type for proposal-request message
  static const proposalRequestMessageType =
      '${_iden3Protocol}credentials/0.1/proposal-request';

  // ProposalMessageType is type for proposal message
  static const proposalMessageType =
      '${_iden3Protocol}credentials/0.1/proposal';

  // PaymentRequestMessageType is type for payment-request message
  static const paymentRequestMessageType =
      '${_iden3Protocol}credentials/0.1/payment-request';

  // PaymentMessageType is type for payment message
  static const paymentMessageType = '${_iden3Protocol}credentials/0.1/payment';

  // DiscoveryProtocolQueriesMessageType is type for didcomm discovery protocol queries
  static const discoveryProtocolQueriesMessageType =
      '${_didcommProtocol}discover-features/2.0/queries';

  // DiscoveryProtocolDiscloseMessageType is type for didcomm discovery protocol disclose
  static const discoveryProtocolDiscloseMessageType =
      '${_didcommProtocol}discover-features/2.0/disclose';

  // ProblemReportMessageType is type for didcomm problem report
  static const problemReportMessageType =
      '${_didcommProtocol}report-problem/2.0/problem-report';

  // CredentialStatusUpdateMessageType is type for credential status update message
  static const credentialStatusUpdateMessageType =
      '${_iden3Protocol}credentials/1.0/status-update';

  // Attestation message types
  static const attestationRequestMessageType =
      '${_iden3Protocol}attestation/0.1/request';
  static const attestationResponseMessageType =
      '${_iden3Protocol}attestation/0.1/response';

  // Verification message types
  static const verificationRequestMessageType =
      '${_iden3Protocol}passport/0.1/verification-request';
  static const verificationResponseMessageType =
      '${_iden3Protocol}passport/0.1/verification-response';

  // List of all message types for iteration or validation
  static const List<String> allMessageTypes = [
    authorizationRequestMessageType,
    authorizationResponseMessageType,
    credentialIssuanceRequestMessageType,
    credentialFetchRequestMessageType,
    credentialOfferMessageType,
    credentialIssuanceResponseMessageType,
    credentialRefreshMessageType,
    deviceRegistrationRequestMessageType,
    messageFetchRequestMessageType,
    proofGenerationRequestMessageType,
    proofGenerationResponseMessageType,
    revocationStatusRequestMessageType,
    revocationStatusResponseMessageType,
    contractInvokeRequestMessageType,
    contractInvokeResponseMessageType,
    credentialOnchainOfferMessageType,
    proposalRequestMessageType,
    proposalMessageType,
    paymentRequestMessageType,
    paymentMessageType,
    discoveryProtocolQueriesMessageType,
    discoveryProtocolDiscloseMessageType,
    problemReportMessageType,
  ];

  // Helper method to check if a string is a valid message type
  static bool isValidMessageType(String type) {
    return allMessageTypes.contains(type);
  }
}
