import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/interaction_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';

class RemoveInteractionsParam {
  final String genesisDid;
  final String privateKey;
  final List<int> ids;

  RemoveInteractionsParam({
    required this.genesisDid,
    required this.privateKey,
    required this.ids,
  });
}

class RemoveInteractionsUseCase
    extends FutureUseCase<RemoveInteractionsParam, void> {
  final InteractionRepository _interactionRepository;
  final CheckProfileAndDidCurrentEnvUseCase
      _checkProfileAndDidCurrentEnvUseCase;

  RemoveInteractionsUseCase(
    this._interactionRepository,
    this._checkProfileAndDidCurrentEnvUseCase,
  );

  @override
  Future<void> execute({required RemoveInteractionsParam param}) {
    return _checkProfileAndDidCurrentEnvUseCase
        .execute(
            param: CheckProfileAndDidCurrentEnvParam(
                did: param.genesisDid,
                privateKey: param.privateKey,
                profileNonce: GENESIS_PROFILE_NONCE))
        .then((_) => _interactionRepository.removeInteractions(
            ids: param.ids,
            did: param.genesisDid,
            privateKey: param.privateKey))
        .then((_) => logger().i(
            "[RemoveInteractionUseCase] Interactions with ids ${param.ids} have been removed"))
        .catchError((error) {
      logger().e("[RemoveInteractionUseCase] Error: $error");
      throw error;
    });
  }
}
