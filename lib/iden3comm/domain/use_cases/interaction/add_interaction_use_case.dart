import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
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
  final StacktraceManager _stacktraceManager;

  AddInteractionUseCase(
    this._interactionRepository,
    this._checkProfileValidityUseCase,
    this._getIdentityUseCase,
    this._stacktraceManager,
  );

  @override
  Future<InteractionBaseEntity> execute(
      {required AddInteractionParam param}) async {
    try {
      // if genesisDid and privateKey are not provided we throw an exception
      if (param.genesisDid == null || param.privateKey == null) {
        _stacktraceManager.addTrace(
            "[AddInteractionUseCase] GenesisDid and PrivateKey are required to add an interaction");
        throw PolygonIdSDKException(
          errorMessage:
              "GenesisDid and PrivateKey are required to add an interaction",
        );
      }

      // we add the interaction and return it
      InteractionBaseEntity addedInteraction =
          await _interactionRepository.addInteraction(
        interaction: param.interaction,
        genesisDid: param.genesisDid,
        privateKey: param.privateKey,
      );

      logger().i("[AddInteractionUseCase] Interaction: $addedInteraction");
      _stacktraceManager
          .addTrace("[AddInteractionUseCase] Interaction: $addedInteraction");

      return addedInteraction;
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      logger().e("[AddInteractionUseCase] Error: $error");
      throw PolygonIdSDKException(
          errorMessage: "Error adding interaction $error");
    }
  }
}
