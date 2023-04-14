import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/interaction_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/check_profile_validity_use_case.dart';

class GetInteractionsParam {
  final String genesisDid;
  final BigInt profileNonce;
  final String privateKey;
  final List<InteractionType>? types;
  final List<FilterEntity>? filters;

  GetInteractionsParam({
    required this.genesisDid,
    required this.profileNonce,
    required this.privateKey,
    this.types,
    this.filters,
  });
}

class GetInteractionsUseCase
    extends FutureUseCase<GetInteractionsParam, List<InteractionEntity>> {
  final InteractionRepository _interactionRepository;
  final CheckProfileValidityUseCase _checkProfileValidityUseCase;
  final GetIdentityUseCase _getIdentityUseCase;

  GetInteractionsUseCase(
    this._interactionRepository,
    this._checkProfileValidityUseCase,
    this._getIdentityUseCase,
  );

  @override
  Future<List<InteractionEntity>> execute(
      {required GetInteractionsParam param}) {
    // we check if profile is valid and identity is existing
    return _checkProfileValidityUseCase
        .execute(
            param: CheckProfileValidityParam(profileNonce: param.profileNonce))
        .then((_) => _getIdentityUseCase
            .execute(
                param: GetIdentityParam(
                    genesisDid: param.genesisDid, privateKey: param.privateKey))
            .then((_) => _interactionRepository.getInteractions(
                filters: param.filters,
                genesisDid: param.genesisDid,
                privateKey: param.privateKey)))
        .then((interactions) {
      /// Shortcut to filter by type
      if (param.types != null) {
        interactions = interactions
            .where((interaction) => param.types!.contains(interaction.type))
            .toList();
      }

      /// Shortcut to filter by profile
      if (param.profileNonce > GENESIS_PROFILE_NONCE) {
        interactions = interactions
            .where(
                (interaction) => param.profileNonce == interaction.profileNonce)
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
