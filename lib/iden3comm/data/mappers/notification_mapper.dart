import 'package:polygonid_flutter_sdk/common/mappers/from_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/notification_entity.dart';

class NotificationMapper extends FromMapper<String, NotificationEntity> {
  @override
  NotificationEntity mapFrom(String from) {
    /// TODO: Implement this method when we have the specs
    return NotificationEntity(
        notificationType: NotificationType.generic,
        from: "fom",
        genesisDid: "genesisDid",
        profileNonce: BigInt.from(0),
        payload: from);
  }
}
