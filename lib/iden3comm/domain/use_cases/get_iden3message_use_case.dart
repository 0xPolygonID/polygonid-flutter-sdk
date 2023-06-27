import 'dart:convert';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/authorization/request/auth_request_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/offer_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/response/fetch_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/proof/request/contract_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';

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
          case Iden3MessageType.authRequest:
            return AuthIden3MessageEntity.fromJson(json);
          case Iden3MessageType.credentialOffer:
            return OfferIden3MessageEntity.fromJson(json);
          case Iden3MessageType.credentialIssuanceResponse:
            return FetchIden3MessageEntity.fromJson(json);
          case Iden3MessageType.proofContractInvokeRequest:
            return ContractIden3MessageEntity.fromJson(json);
          case Iden3MessageType.authResponse:
          case Iden3MessageType.unknown:
            throw UnsupportedIden3MsgTypeException(type);
        }
      });
    } catch (error) {
      return Future.error(error);
    }
  }
}
