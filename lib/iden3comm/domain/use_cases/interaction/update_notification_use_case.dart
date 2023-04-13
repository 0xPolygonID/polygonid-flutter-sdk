import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/notification_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/interaction_exception.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/interaction_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/save_interaction_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

class UpdateNotificationParam {
  final String privateKey;
  final int id;
  final bool? isRead;
  final NotificationState? state;

  UpdateNotificationParam({
    required this.privateKey,
    required this.id,
    this.isRead,
    this.state,
  });
}

class UpdateNotificationUseCase
    extends FutureUseCase<UpdateNotificationParam, NotificationEntity> {
  final InteractionRepository _interactionRepository;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;
  final GetIdentityUseCase _getIdentityUseCase;
  final SaveInteractionUseCase _saveInteractionUseCase;

  UpdateNotificationUseCase(
    this._interactionRepository,
    this._getCurrentEnvDidIdentifierUseCase,
    this._getIdentityUseCase,
    this._saveInteractionUseCase,
  );

  @override
  Future<NotificationEntity> execute({required UpdateNotificationParam param}) {
    return _getCurrentEnvDidIdentifierUseCase
        .execute(
            param: GetCurrentEnvDidIdentifierParam(
                privateKey: param.privateKey,
                profileNonce: GENESIS_PROFILE_NONCE))
        .then((genesisDid) => _interactionRepository.getInteraction(
            id: param.id, did: genesisDid, privateKey: param.privateKey))
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
        .then((notification) => _saveInteractionUseCase.execute(
            param: SaveInteractionParam(
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
