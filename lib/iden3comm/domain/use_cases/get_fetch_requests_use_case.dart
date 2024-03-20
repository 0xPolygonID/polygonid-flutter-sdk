import 'dart:convert';

import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/response/fetch_body_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/response/fetch_iden3_message_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../common/domain/use_case.dart';
import '../entities/credential/request/offer_iden3_message_entity.dart';

class GetFetchRequestsParam {
  final OfferIden3MessageEntity message;
  final String did;

  GetFetchRequestsParam(this.message, this.did);
}

class GetFetchRequestsUseCase
    extends FutureUseCase<GetFetchRequestsParam, List<String>> {
  @override
  Future<List<String>> execute({required GetFetchRequestsParam param}) async {
    return param.message.body.credentials
        .map((credential) => jsonEncode(FetchIden3MessageEntity(
            id: const Uuid().v4(),
            typ: param.message.typ,
            type:
                "https://iden3-communication.io/credentials/1.0/fetch-request",
            thid: param.message.thid,
            body: FetchBodyRequest(id: credential.id),
            from: param.did,
            to: param.message.from)))
        .toList();
  }
}
