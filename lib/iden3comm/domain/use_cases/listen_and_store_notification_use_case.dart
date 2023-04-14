import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/interaction_repository.dart';

/// Not used yet
class ListenAndStoreNotificationUseCase extends FutureUseCase<void, void> {
  final InteractionRepository _interactionRepository;

  ListenAndStoreNotificationUseCase(this._interactionRepository);

  @override
  Future<void> execute({dynamic param}) async {
    //await for (var notification in _interactionRepository.notifications) {
    try {
      // await _interactionRepository.storeInteraction(
      //     interaction: notification);
      //  logger().d(
      //      "[ListenAndStoreNotification] Notification stored: $notification");
    } catch (error) {
      logger().e(
          "[ListenAndStoreNotification] Error occurred but Stream continue: $error");
    }
  }
  //}
}
