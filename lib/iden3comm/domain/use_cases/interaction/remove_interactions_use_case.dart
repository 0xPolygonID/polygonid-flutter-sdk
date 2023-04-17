import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/interaction_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/check_profile_validity_use_case.dart';

class RemoveInteractionsParam {
  final String genesisDid;
  final String privateKey;
  final List<String> ids;

  RemoveInteractionsParam({
    required this.genesisDid,
    required this.privateKey,
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
  Future<void> execute({required RemoveInteractionsParam param}) {
    // we check if identity is existing
    return _getIdentityUseCase
        .execute(
            param: GetIdentityParam(
                genesisDid: param.genesisDid, privateKey: param.privateKey))
        .then((_) => _interactionRepository.removeInteractions(
            ids: param.ids,
            genesisDid: param.genesisDid,
            privateKey: param.privateKey))
        .then((_) => logger().i(
            "[RemoveInteractionUseCase] Interactions with ids ${param.ids} have been removed"))
        .catchError((error) {
      logger().e("[RemoveInteractionUseCase] Error: $error");
      throw error;
    });
  }
}
