import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_base_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/interaction_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/check_profile_validity_use_case.dart';

class AddInteractionParam {
  final String? genesisDid;
  final String? privateKey;
  final InteractionBaseEntity interaction;

  AddInteractionParam({
    this.genesisDid,
    this.privateKey,
    required this.interaction,
  });
}

class AddInteractionUseCase
    extends FutureUseCase<AddInteractionParam, InteractionBaseEntity> {
  final InteractionRepository _interactionRepository;
  final CheckProfileValidityUseCase _checkProfileValidityUseCase;
  final GetIdentityUseCase _getIdentityUseCase;

  AddInteractionUseCase(
    this._interactionRepository,
    this._checkProfileValidityUseCase,
    this._getIdentityUseCase,
  );

  @override
  Future<InteractionBaseEntity> execute(
      {required AddInteractionParam param}) async {
    // we check if identity is existing
    if (param.genesisDid != null && param.privateKey != null) {
      await _getIdentityUseCase.execute(
          param: GetIdentityParam(
              genesisDid: param.genesisDid!, privateKey: param.privateKey));
    }
    return _interactionRepository
        .addInteraction(
            interaction: param.interaction,
            genesisDid: param.genesisDid,
            privateKey: param.privateKey)
        .then((interaction) {
      logger().i("[AddInteractionUseCase] Interaction: $interaction");

      return interaction;
    }).catchError((error) {
      logger().e("[AddInteractionUseCase] Error: $error");
      throw error;
    });
  }
}
