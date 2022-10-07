import '../../../common/mappers/mapper.dart';
import '../../domain/entities/iden3_message_entity.dart';

class Iden3MessageTypeMapper extends Mapper<Iden3MessageType, String> {
  @override
  String mapFrom(Iden3MessageType from) {
    switch (from) {
      case Iden3MessageType.auth:
        return "https://iden3-communication.io/authorization/1.0/request";
      case Iden3MessageType.offer:
        return "https://iden3-communication.io/credentials/1.0/offer";
      case Iden3MessageType.issuance:
        return "https://iden3-communication.io/credentials/1.0/issuance-response";
      case Iden3MessageType.contractFunctionCall:
        return "https://iden3-communication.io/proofs/1.0/contract-invoke-request";
      default:
        return "";
    }
  }

  @override
  Iden3MessageType mapTo(String to) {
    switch (to) {
      case "https://iden3-communication.io/authorization/1.0/request":
        return Iden3MessageType.auth;
      case "https://iden3-communication.io/credentials/1.0/offer":
        return Iden3MessageType.offer;
      case "https://iden3-communication.io/credentials/1.0/issuance-response":
        return Iden3MessageType.issuance;
      case "https://iden3-communication.io/proofs/1.0/contract-invoke-request":
        return Iden3MessageType.contractFunctionCall;
      default:
        return Iden3MessageType.unknown;
    }
  }
}
