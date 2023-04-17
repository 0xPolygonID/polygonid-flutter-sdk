import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/interaction_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/check_profile_validity_use_case.dart';

import '../../../../common/domain/domain_constants.dart';

class AddInteractionParam {
  final String privateKey;
  final InteractionEntity interaction;

  AddInteractionParam({
    required this.privateKey,
    required this.interaction,
  });
}

class AddInteractionUseCase
    extends FutureUseCase<AddInteractionParam, InteractionEntity> {
  final InteractionRepository _interactionRepository;
  final CheckProfileValidityUseCase _checkProfileValidityUseCase;
  final GetIdentityUseCase _getIdentityUseCase;

  AddInteractionUseCase(
    this._interactionRepository,
    this._checkProfileValidityUseCase,
    this._getIdentityUseCase,
  );

  @override
  Future<InteractionEntity> execute({required AddInteractionParam param}) {
    // we check if profile is valid and identity is existing
    return _checkProfileValidityUseCase
        .execute(
            param: CheckProfileValidityParam(
                profileNonce: param.interaction.profileNonce))
        .then((_) => _getIdentityUseCase
            .execute(
                param: GetIdentityParam(
                    genesisDid: param.interaction.genesisDid,
                    privateKey: param.privateKey))
            .then((_) => _interactionRepository.addInteraction(
                interaction: param.interaction,
                genesisDid: param.interaction.genesisDid,
                privateKey: param.privateKey)))
        .then((interaction) {
      logger().i("[AddInteractionUseCase] Interaction: $interaction");

      return interaction;
    }).catchError((error) {
      logger().e("[AddInteractionUseCase] Error: $error");
      throw error;
    });
  }
}
