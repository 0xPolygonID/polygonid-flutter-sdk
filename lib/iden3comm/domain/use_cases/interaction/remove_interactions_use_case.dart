import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/interaction_repository.dart';

class RemoveInteractionsParam {
  final String? genesisDid;
  final String? encryptionKey;
  final List<String> ids;

  RemoveInteractionsParam({
    required this.ids,
    this.genesisDid,
    this.encryptionKey,
  });
}

class RemoveInteractionsUseCase
    extends FutureUseCase<RemoveInteractionsParam, void> {
  final InteractionRepository _interactionRepository;

  RemoveInteractionsUseCase(
    this._interactionRepository,
  );

  @override
  Future<void> execute({required RemoveInteractionsParam param}) async {
    try {
      await _interactionRepository.removeInteractions(
        ids: param.ids,
        genesisDid: param.genesisDid,
        encryptionKey: param.encryptionKey,
      );
      logger().i(
          "[RemoveInteractionUseCase] Interactions with ids ${param.ids} have been removed");
    } catch (error) {
      logger().e("[RemoveInteractionUseCase] Error: $error");
      rethrow;
    }
  }
}
