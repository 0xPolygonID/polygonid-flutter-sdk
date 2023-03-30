import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/connection_dto.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/connection_entity.dart';

class ConnectionMapper extends Mapper<ConnectionDTO, ConnectionEntity> {
  @override
  ConnectionEntity mapFrom(ConnectionDTO from) {
    return ConnectionEntity(
        from: from.from, to: from.to, interactions: from.interactions);
  }

  @override
  ConnectionDTO mapTo(ConnectionEntity to) {
    return ConnectionDTO(
      from: to.from,
      to: to.to,
      interactions: to.interactions,
    );
  }
}
