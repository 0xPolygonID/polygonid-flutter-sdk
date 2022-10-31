import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';

import '../../../common/mappers/to_mapper.dart';

class Iden3MessageTypeDataMapper extends ToMapper<String, Iden3MessageType> {
  @override
  String mapTo(Iden3MessageType to) {
    switch (to) {
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
}
