import '../../../common/mappers/mapper.dart';
import 'iden3_msg_type.dart';

class Iden3MsgTypeMapper extends Mapper<Iden3MsgType, String> {
  @override
  String mapFrom(Iden3MsgType from) {
    switch (from) {
      case Iden3MsgType.auth:
        return "https://iden3-communication.io/authorization/1.0/request";
      case Iden3MsgType.offer:
        return "https://iden3-communication.io/credentials/1.0/offer";
      case Iden3MsgType.issuance:
        return "https://iden3-communication.io/credentials/1.0/issuance-response";
      case Iden3MsgType.contractFunctionCall:
        return "https://iden3-communication.io/proofs/1.0/contract-invoke-request";
      default:
        return "";
    }
  }

  @override
  Iden3MsgType mapTo(String to) {
    switch (to) {
      case "https://iden3-communication.io/authorization/1.0/request":
        return Iden3MsgType.auth;
      case "https://iden3-communication.io/credentials/1.0/offer":
        return Iden3MsgType.offer;
      case "https://iden3-communication.io/credentials/1.0/issuance-response":
        return Iden3MsgType.issuance;
      case "https://iden3-communication.io/proofs/1.0/contract-invoke-request":
        return Iden3MsgType.contractFunctionCall;
      default:
        return Iden3MsgType.unknown;
    }
  }
}
