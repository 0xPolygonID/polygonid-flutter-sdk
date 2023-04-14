import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/interaction_id_filter_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/notification_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/interaction_exception.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/interaction_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/add_interaction_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/get_interactions_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

class UpdateNotificationParam {
  final String genesisDid;
  final String privateKey;
  final String id;
  final bool? isRead;
  final NotificationState? state;

  UpdateNotificationParam({
    required this.genesisDid,
    required this.privateKey,
    required this.id,
    this.isRead,
    this.state,
  });
}

class UpdateNotificationUseCase
    extends FutureUseCase<UpdateNotificationParam, NotificationEntity> {
  final InteractionRepository _interactionRepository;
  final AddInteractionUseCase _addInteractionUseCase;

  UpdateNotificationUseCase(
    this._interactionRepository,
    this._addInteractionUseCase,
  );

  @override
  Future<NotificationEntity> execute({required UpdateNotificationParam param}) {
    return _interactionRepository
        .getInteraction(
            id: param.id,
            genesisDid: param.genesisDid,
            privateKey: param.privateKey)
        .then((interaction) => interaction is! NotificationEntity
            ? throw InvalidInteractionType(interaction.type)
            : NotificationEntity(
                id: interaction.id,
                from: interaction.from,
                genesisDid: interaction.genesisDid,
                profileNonce: interaction.profileNonce,
                type: interaction.type,
                timestamp: interaction.timestamp,
                message: interaction.message,
                isRead: param.isRead ?? interaction.isRead,
                state: param.state ?? interaction.state,
              ))
        .then((notification) => _addInteractionUseCase.execute(
            param: AddInteractionParam(
                privateKey: param.privateKey, interaction: notification)))
        .then((notification) {
      logger().i("[UpdateNotificationUseCase] Notification: $notification");

      return notification as NotificationEntity;
    }).catchError((error) {
      logger().e("[UpdateNotificationUseCase] Error: $error");
      throw error;
    });
  }
}
