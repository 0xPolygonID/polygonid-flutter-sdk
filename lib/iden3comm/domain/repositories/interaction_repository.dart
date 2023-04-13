import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/connection/interaction_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/connection/notification_entity.dart';

abstract class InteractionRepository {
  Stream<NotificationEntity> get notifications;

  Future<InteractionEntity> storeInteraction(
      {required InteractionEntity interaction,
      required String did,
      required String privateKey});

  Future<List<InteractionEntity>> getInteractions(
      {List<FilterEntity>? filters,
      required String did,
      required String privateKey});
}
