import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';

import '../entities/common/iden3_message_entity.dart';

class GetIden3MessageTypeUseCase
    extends FutureUseCase<String, Iden3MessageType> {
  @override
  Future<Iden3MessageType> execute({required String param}) {
    Iden3MessageType type = Iden3MessageType.unknown;

    switch (param) {
      case "https://iden3-communication.io/authorization/1.0/request":
        type = Iden3MessageType.authRequest;
        break;
      case "https://iden3-communication.io/authorization/1.0/response":
        type = Iden3MessageType.authResponse;
        break;
      case "https://iden3-communication.io/credentials/1.0/offer":
        type = Iden3MessageType.credentialOffer;
        break;
      case "https://iden3-communication.io/credentials/1.0/onchain-offer":
        type = Iden3MessageType.onchainCredentialOffer;
        break;
      case "https://iden3-communication.io/credentials/1.0/issuance-response":
        type = Iden3MessageType.credentialIssuanceResponse;
        break;
      case "https://iden3-communication.io/proofs/1.0/contract-invoke-request":
        type = Iden3MessageType.proofContractInvokeRequest;
        break;
      case "https://iden3-communication.io/credentials/1.0/status-update":
        type = Iden3MessageType.credentialStatusUpdate;
        break;
    }

    return Future.value(type);
  }
}
