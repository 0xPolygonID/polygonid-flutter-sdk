import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';

import '../dtos/request/fetch/fetch_body_request.dart';
import '../dtos/request/fetch/fetch_request.dart';
import 'iden3_message_type_data_mapper.dart';

class FetchRequestMapper extends ToMapper<FetchRequest, Iden3MessageEntity> {
  final Iden3MessageTypeDataMapper _typeMapper;

  FetchRequestMapper(this._typeMapper);

  @override
  FetchRequest mapTo(Iden3MessageEntity to) {
    return FetchRequest(
        id: to.id,
        typ: to.typ,
        type: _typeMapper.mapTo(to.type),
        thid: to.thid,
        body: FetchBodyRequest.fromJson(to.body),
        from: to.from);
  }
}
