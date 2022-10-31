import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';


class Iden3MessageTypeMapper extends FromMapper<String, Iden3MessageType> {
  @override
  Iden3MessageType mapFrom(String from) {
    switch (from) {
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
