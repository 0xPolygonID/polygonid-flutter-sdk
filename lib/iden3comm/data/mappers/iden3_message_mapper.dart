import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/iden3_message.dart';

import '../../domain/entities/iden3_message_entity.dart';
import 'iden3_message_type_mapper.dart';

class Iden3MessageMapper extends FromMapper<Iden3Message, Iden3MessageEntity> {
  final Iden3MessageTypeMapper _iden3MessageTypeMapper;

  Iden3MessageMapper(this._iden3MessageTypeMapper);

  @override
  Iden3MessageEntity mapFrom(Iden3Message from) {
    return Iden3MessageEntity(
        id: from.id,
        typ: from.typ,
        type: _iden3MessageTypeMapper.mapTo(from.type!),
        thid: from.thid,
        body: from.body,
        from: from.from,
        to: from.to);
  }
}
