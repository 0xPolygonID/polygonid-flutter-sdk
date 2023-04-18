import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_base_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';

abstract class InteractionRepository {
  //Stream<NotificationEntity> get notifications;

  Future<InteractionBaseEntity> addInteraction({
    required InteractionBaseEntity interaction,
    String? genesisDid,
    String? privateKey,
  });

  Future<List<InteractionBaseEntity>> getInteractions({
    List<FilterEntity>? filters,
    String? genesisDid,
    String? privateKey,
  });

  Future<InteractionBaseEntity> getInteraction({
    required String id,
    String? genesisDid,
    String? privateKey,
  });

  Future<void> removeInteractions({
    required List<String> ids,
    String? genesisDid,
    String? privateKey,
  });
}
