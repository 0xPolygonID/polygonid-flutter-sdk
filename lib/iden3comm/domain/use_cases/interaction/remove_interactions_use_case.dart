import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/interaction_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/check_profile_validity_use_case.dart';

class RemoveInteractionsParam {
  final String? genesisDid;
  final BigInt? profileNonce;
  final String? privateKey;
  final List<String> ids;

  RemoveInteractionsParam({
    this.genesisDid,
    this.profileNonce,
    this.privateKey,
    required this.ids,
  });
}

class RemoveInteractionsUseCase
    extends FutureUseCase<RemoveInteractionsParam, void> {
  final InteractionRepository _interactionRepository;
  final GetIdentityUseCase _getIdentityUseCase;

  RemoveInteractionsUseCase(
    this._interactionRepository,
    this._getIdentityUseCase,
  );

  @override
  Future<void> execute({required RemoveInteractionsParam param}) async {
    // we check if identity is existing
    if (param.genesisDid != null && param.privateKey != null) {
      await _getIdentityUseCase.execute(
          param: GetIdentityParam(
              genesisDid: param.genesisDid!, privateKey: param.privateKey));
    }
    return _interactionRepository
        .removeInteractions(
            ids: param.ids,
            genesisDid: param.genesisDid,
            privateKey: param.privateKey)
        .then((_) => logger().i(
            "[RemoveInteractionUseCase] Interactions with ids ${param.ids} have been removed"))
        .catchError((error) {
      logger().e("[RemoveInteractionUseCase] Error: $error");
      throw error;
    });
  }
}
