import 'dart:convert';

import '../../../common/domain/use_case.dart';
import '../entities/iden3_message_entity.dart';
import '../entities/request/auth/auth_iden3_message_entity.dart';
import '../entities/request/fetch/fetch_iden3_message_entity.dart';
import '../entities/request/offer/offer_iden3_message_entity.dart';
import '../entities/request/onchain/contract_iden3_message_entity.dart';
import '../exceptions/iden3comm_exceptions.dart';
import 'get_iden3message_type_use_case.dart';

class GetIden3MessageUseCase extends FutureUseCase<String, Iden3MessageEntity> {
  final GetIden3MessageTypeUseCase _getIden3MessageTypeUseCase;

  GetIden3MessageUseCase(this._getIden3MessageTypeUseCase);

  @override
  Future<Iden3MessageEntity> execute({required String param}) {
    try {
      Map<String, dynamic> json = jsonDecode(param);

      return _getIden3MessageTypeUseCase
          .execute(param: json['type'])
          .then((type) {
        switch (type) {
          case Iden3MessageType.auth:
            return AuthIden3MessageEntity.fromJson(json);
          case Iden3MessageType.offer:
            return OfferIden3MessageEntity.fromJson(json);
          case Iden3MessageType.issuance:
            return FetchIden3MessageEntity.fromJson(json);
          case Iden3MessageType.contractFunctionCall:
            return ContractIden3MessageEntity.fromJson(json);
          case Iden3MessageType.unknown:
            throw UnsupportedIden3MsgTypeException(type);
        }
      });
    } catch (error) {
      return Future.error(error);
    }
  }
}
