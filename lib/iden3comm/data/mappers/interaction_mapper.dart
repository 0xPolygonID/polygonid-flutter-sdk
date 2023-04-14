import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/notification_entity.dart';

/// While it would be better to have the json serialization out of the Domain layer,
/// we are keeping it there for convenience.
class InteractionMapper
    extends Mapper<Map<String, dynamic>, InteractionEntity> {
  @override
  InteractionEntity mapFrom(Map<String, dynamic> from) {
    if (from['type'] != InteractionType.connection.toString()) {
      return NotificationEntity.fromJson(from);
    } else {
      return InteractionEntity.fromJson(from);
    }
  }

  @override
  Map<String, dynamic> mapTo(InteractionEntity to) {
    return to.toJson();
  }
}
