import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/interaction_id_filter_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_base_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/interaction_exception.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/interaction_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/add_interaction_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/interaction/get_interactions_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/check_profile_validity_use_case.dart';

class UpdateInteractionParam {
  final String? genesisDid;
  final BigInt? profileNonce;
  final String? privateKey;
  final String id;
  final InteractionState? state;

  UpdateInteractionParam({
    this.genesisDid,
    this.profileNonce,
    this.privateKey,
    required this.id,
    this.state,
  });
}

class UpdateInteractionUseCase
    extends FutureUseCase<UpdateInteractionParam, InteractionBaseEntity> {
  final InteractionRepository _interactionRepository;
  final CheckProfileValidityUseCase _checkProfileValidityUseCase;
  final GetIdentityUseCase _getIdentityUseCase;
  final AddInteractionUseCase _addInteractionUseCase;

  UpdateInteractionUseCase(
    this._interactionRepository,
    this._checkProfileValidityUseCase,
    this._getIdentityUseCase,
    this._addInteractionUseCase,
  );

  @override
  Future<InteractionBaseEntity> execute(
      {required UpdateInteractionParam param}) async {
    // we check if profile is valid and identity is existing
    if (param.genesisDid != null &&
        param.profileNonce != null &&
        param.privateKey != null) {
      await _checkProfileValidityUseCase
          .execute(
              param:
                  CheckProfileValidityParam(profileNonce: param.profileNonce!))
          .then((_) => _getIdentityUseCase.execute(
              param: GetIdentityParam(
                  genesisDid: param.genesisDid!,
                  privateKey: param.privateKey)));

      InteractionBaseEntity interactionToBeUpdated;
      try {
        // search if interaction is in base
        interactionToBeUpdated =
            await _interactionRepository.getInteraction(id: param.id);
        await _interactionRepository.removeInteractions(ids: [param.id]);
      } catch (e) {
        interactionToBeUpdated = await _interactionRepository.getInteraction(
            id: param.id,
            genesisDid: param.genesisDid,
            privateKey: param.privateKey);
      }

      if (interactionToBeUpdated != null) {
        InteractionEntity updatedInteraction = InteractionEntity(
          id: interactionToBeUpdated.id,
          from: interactionToBeUpdated.from,
          genesisDid: param.genesisDid!,
          profileNonce: param.profileNonce!,
          type: interactionToBeUpdated.type,
          timestamp: interactionToBeUpdated.timestamp,
          message: interactionToBeUpdated.message,
          state: param.state ?? interactionToBeUpdated.state,
        );
        return _addInteractionUseCase.execute(
            param: AddInteractionParam(
                genesisDid: param.genesisDid,
                profileNonce: param.profileNonce,
                privateKey: param.privateKey,
                interaction: updatedInteraction));
      } else {
        throw InteractionNotFoundException(param.id);
      }
    } else {
      return _interactionRepository
          .getInteraction(id: param.id)
          .then((interactionToBeUpdated) => InteractionBaseEntity(
                id: interactionToBeUpdated.id,
                from: interactionToBeUpdated.from,
                type: interactionToBeUpdated.type,
                timestamp: interactionToBeUpdated.timestamp,
                message: interactionToBeUpdated.message,
                state: param.state ?? interactionToBeUpdated.state,
              ))
          .then((interaction) => _addInteractionUseCase.execute(
              param: AddInteractionParam(interaction: interaction)))
          .then((interaction) {
        logger().i("[UpdateInteractionUseCase] Interaction: $interaction");

        return interaction;
      }).catchError((error) {
        logger().e("[UpdateNotificationUseCase] Error: $error");
        throw error;
      });
    }
  }
}
