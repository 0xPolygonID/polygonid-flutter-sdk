import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/notification_entity.dart';

abstract class InteractionRepository {
  //Stream<NotificationEntity> get notifications;

  Future<InteractionEntity> addInteraction({
    required InteractionEntity interaction,
    required String genesisDid,
    required String privateKey,
  });

  Future<List<InteractionEntity>> getInteractions({
    List<FilterEntity>? filters,
    required String genesisDid,
    required String privateKey,
  });

  Future<InteractionEntity> getInteraction({
    required String id,
    required String genesisDid,
    required String privateKey,
  });

  Future<void> removeInteractions({
    required List<String> ids,
    required String genesisDid,
    required String privateKey,
  });
}
