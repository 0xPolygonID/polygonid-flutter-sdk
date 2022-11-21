import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';

import '../dtos/request/offer/offer_body_request.dart';
import '../dtos/request/offer/offer_request.dart';
import 'iden3_message_type_data_mapper.dart';

class OfferRequestMapper extends ToMapper<OfferRequest, Iden3MessageEntity> {
  final Iden3MessageTypeDataMapper _typeMapper;

  OfferRequestMapper(this._typeMapper);

  @override
  OfferRequest mapTo(Iden3MessageEntity to) {
    return OfferRequest(
        id: to.id,
        typ: to.typ,
        type: _typeMapper.mapTo(to.type),
        thid: to.thid,
        body: OfferBodyRequest.fromJson(to.body),
        from: to.from);
  }
}
