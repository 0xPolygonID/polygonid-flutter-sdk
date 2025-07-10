import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';

abstract class InteractionRepository {
  //Stream<NotificationEntity> get notifications;

  Future<InteractionEntity> addInteraction({
    required InteractionEntity interaction,
    String? genesisDid,
    String? encryptionKey,
  });

  Future<List<InteractionEntity>> getInteractions({
    List<FilterEntity>? filters,
    String? genesisDid,
    String? encryptionKey,
  });

  Future<InteractionEntity> getInteraction({
    required String id,
    String? genesisDid,
    String? encryptionKey,
  });

  Future<void> removeInteractions({
    required List<String> ids,
    String? genesisDid,
    String? encryptionKey,
  });
}
