import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/onchain/contract_function_call_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3message_type_use_case.dart';

import '../entities/iden3_message_entity.dart';
import '../entities/request/auth/auth_request.dart';
import '../entities/request/fetch/fetch_request.dart';
import '../entities/request/offer/offer_request.dart';
import '../exceptions/iden3comm_exceptions.dart';

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
            return AuthRequest.fromJson(json);
          case Iden3MessageType.offer:
            return OfferRequest.fromJson(json);
          case Iden3MessageType.issuance:
            return FetchRequest.fromJson(json);
          case Iden3MessageType.contractFunctionCall:
            return ContractFunctionCallRequest.fromJson(json);
          case Iden3MessageType.unknown:
            throw UnsupportedIden3MsgTypeException(type);
        }
      });
    } catch (error) {
      return Future.error(error);
    }
  }
}
