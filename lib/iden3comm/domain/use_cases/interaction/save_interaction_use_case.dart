import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/interaction_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';

class SaveInteractionParam {
  final String privateKey;
  final InteractionEntity interaction;

  SaveInteractionParam({
    required this.privateKey,
    required this.interaction,
  });
}

class SaveInteractionUseCase
    extends FutureUseCase<SaveInteractionParam, InteractionEntity> {
  final InteractionRepository _interactionRepository;
  final CheckProfileAndDidCurrentEnvUseCase
      _checkProfileAndDidCurrentEnvUseCase;

  SaveInteractionUseCase(
    this._interactionRepository,
    this._checkProfileAndDidCurrentEnvUseCase,
  );

  @override
  Future<InteractionEntity> execute({required SaveInteractionParam param}) {
    return _checkProfileAndDidCurrentEnvUseCase
        .execute(
            param: CheckProfileAndDidCurrentEnvParam(
                did: param.interaction.genesisDid,
                privateKey: param.privateKey,
                profileNonce: param.interaction.profileNonce))
        .then((_) => _interactionRepository.saveInteraction(
            interaction: param.interaction,
            did: param.interaction.genesisDid,
            privateKey: param.privateKey))
        .then((interaction) {
      logger().i("[SaveInteractionUseCase] Interaction: $interaction");

      return interaction;
    }).catchError((error) {
      logger().e("[SaveInteractionUseCase] Error: $error");
      throw error;
    });
  }
}
