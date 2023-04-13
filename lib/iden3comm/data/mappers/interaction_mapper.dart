import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/connection_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/notification_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/offer_notification_entity.dart';

/// While it would be better to have the json serialization out of the Domain layer,
/// we are keeping it there for convenience.
class InteractionMapper
    extends Mapper<Map<String, dynamic>, InteractionEntity> {
  @override
  InteractionEntity mapFrom(Map<String, dynamic> from) {
    if (from['type'] == InteractionType.connection.toString()) {
      return ConnectionEntity.fromJson(from);
    } else if (from['type'] == InteractionType.notification.toString()) {
      if (from['notificationType'] == NotificationType.offer.toString()) {
        return OfferNotificationEntity.fromJson(from);
      }

      return NotificationEntity.fromJson(from);
    } else {
      throw Exception("Unknown interaction type");
    }
  }

  @override
  Map<String, dynamic> mapTo(InteractionEntity to) {
    return to.toJson();
  }
}
