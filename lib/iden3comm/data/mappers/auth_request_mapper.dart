import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/request/auth/auth_request.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';

import '../dtos/request/auth/auth_body_request.dart';
import 'iden3_message_type_data_mapper.dart';

class AuthRequestMapper extends ToMapper<AuthRequest, Iden3MessageEntity> {
  final Iden3MessageTypeDataMapper _typeMapper;

  AuthRequestMapper(this._typeMapper);

  @override
  AuthRequest mapTo(Iden3MessageEntity to) {
    return AuthRequest(
        id: to.id,
        typ: to.typ,
        type: _typeMapper.mapTo(to.type),
        thid: to.thid,
        body: AuthBodyRequest.fromJson(to.body),
        from: to.from);
  }
}
