import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';

class Iden3MessageTypeMapper extends Mapper<String, Iden3MessageType> {
  @override
  Iden3MessageType mapFrom(String from) {
    switch (from) {
      case "https://iden3-communication.io/authorization/1.0/request":
        return Iden3MessageType.authRequest;
      case "https://iden3-communication.io/authorization/1.0/response":
        return Iden3MessageType.authResponse;
      case "https://iden3-communication.io/credentials/1.0/offer":
        return Iden3MessageType.credentialOffer;
      case "https://iden3-communication.io/credentials/1.0/issuance-response":
        return Iden3MessageType.credentialIssuanceResponse;
      case "https://iden3-communication.io/proofs/1.0/contract-invoke-request":
        return Iden3MessageType.proofContractInvokeRequest;
      default:
        return Iden3MessageType.unknown;
    }
  }

  @override
  String mapTo(Iden3MessageType to) {
    switch (to) {
      case Iden3MessageType.authRequest:
        return "https://iden3-communication.io/authorization/1.0/request";
      case Iden3MessageType.authResponse:
        return "https://iden3-communication.io/authorization/1.0/response";
      case Iden3MessageType.credentialOffer:
        return "https://iden3-communication.io/credentials/1.0/offer";
      case Iden3MessageType.credentialIssuanceResponse:
        return "https://iden3-communication.io/credentials/1.0/issuance-response";
      case Iden3MessageType.proofContractInvokeRequest:
        return "https://iden3-communication.io/proofs/1.0/contract-invoke-request";
      default:
        return "";
    }
  }
}
