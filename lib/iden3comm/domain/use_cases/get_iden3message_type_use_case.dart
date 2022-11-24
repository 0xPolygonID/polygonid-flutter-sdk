import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';

import '../entities/iden3_message_entity.dart';

class GetIden3MessageTypeUseCase
    extends FutureUseCase<String, Iden3MessageType> {
  @override
  Future<Iden3MessageType> execute({required String param}) {
    Iden3MessageType type = Iden3MessageType.unknown;

    switch (param) {
      case "https://iden3-communication.io/authorization/1.0/request":
        type = Iden3MessageType.auth;
        break;
      case "https://iden3-communication.io/credentials/1.0/offer":
        type = Iden3MessageType.offer;
        break;
      case "https://iden3-communication.io/credentials/1.0/issuance-response":
        type = Iden3MessageType.issuance;
        break;
      case "https://iden3-communication.io/proofs/1.0/contract-invoke-request":
        type = Iden3MessageType.contractFunctionCall;
        break;
    }

    return Future.value(type);
  }
}
