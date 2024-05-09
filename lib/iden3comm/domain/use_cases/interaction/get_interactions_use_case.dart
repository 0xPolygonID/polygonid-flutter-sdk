import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_base_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/interaction_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/check_profile_validity_use_case.dart';

class GetInteractionsParam {
  final String? genesisDid;
  final BigInt? profileNonce;
  final String? privateKey;
  final List<InteractionType>? types;
  final List<InteractionState>? states;
  final List<FilterEntity>? filters;

  GetInteractionsParam({
    this.genesisDid,
    this.profileNonce,
    this.privateKey,
    this.types,
    this.states,
    this.filters,
  });
}

class GetInteractionsUseCase
    extends FutureUseCase<GetInteractionsParam, List<InteractionBaseEntity>> {
  final InteractionRepository _interactionRepository;
  final CheckProfileValidityUseCase _checkProfileValidityUseCase;
  final GetIdentityUseCase _getIdentityUseCase;

  GetInteractionsUseCase(
    this._interactionRepository,
    this._checkProfileValidityUseCase,
    this._getIdentityUseCase,
  );

  @override
  Future<List<InteractionBaseEntity>> execute(
      {required GetInteractionsParam param}) async {
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
    }
    return _interactionRepository
        .getInteractions(
            filters: param.filters,
            genesisDid: param.genesisDid,
            privateKey: param.privateKey)
        .then((interactions) {
      /// Shortcut to filter by type
      if (param.types != null) {
        interactions = interactions
            .where((interaction) => param.types!.contains(interaction.type))
            .toList();
      }

      /// Shortcut to filter by state
      if (param.states != null) {
        interactions = interactions
            .where((interaction) => param.states!.contains(interaction.state))
            .toList();
      }

      /// Shortcut to filter by profile
      if (param.profileNonce != null &&
          param.profileNonce! > GENESIS_PROFILE_NONCE) {
        interactions = interactions
            .where((interaction) =>
                param.profileNonce ==
                (interaction as InteractionEntity).profileNonce)
            .toList();
      }

      logger().i("[GetInteractionsUseCase] Interactions: $interactions");

      return interactions;
    }).catchError((error) {
      logger().e("[GetInteractionsUseCase] Error: $error");
      throw error;
    });
  }
}
