import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/mappers/iden3_message_type_mapper.dart';

class Iden3MessageMapper extends FromMapper<String, Iden3MessageEntity> {
  final Iden3MessageTypeMapper _iden3MessageTypeMapper;

  Iden3MessageMapper(this._iden3MessageTypeMapper);

  @override
  Iden3MessageEntity mapFrom(String from) {
    Map<String, dynamic> json = jsonDecode(from);

    return Iden3MessageEntity(
      id: json['id'],
      typ: json['typ'],
      type: _iden3MessageTypeMapper.mapFrom(json['type']),
      thid: json['thid'],
      from: json['from'],
      to: json['to'],
      body: json['body'],
    );
  }
}
