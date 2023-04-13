import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/connection/connection_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/connection/interaction_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

class GetInteractionsParam {
  final String genesisDid;
  final int profileNonce;
  final String privateKey;
  final List<FilterEntity>? filters;
  final InteractionType? interactionType;

  GetInteractionsParam({
    required this.genesisDid,
    this.profileNonce = 0,
    required this.privateKey,
    this.filters,
    this.interactionType,
  });
}

class GetInteractionsUseCase
    extends FutureUseCase<GetInteractionsParam, List<ConnectionEntity>> {
  final Iden3commRepository _iden3commRepository;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;
  final GetIdentityUseCase _getIdentityUseCase;

  GetInteractionsUseCase(this._iden3commRepository,
      this._getCurrentEnvDidIdentifierUseCase, this._getIdentityUseCase);

  @override
  Future<List<ConnectionEntity>> execute(
      {required GetInteractionsParam param}) async {
    // if profileNonce is zero, return all profiles' credentials,
    // if profileNonce > 0 then return only credentials from that profile
    if (param.profileNonce >= 0) {
      String did = await _getCurrentEnvDidIdentifierUseCase.execute(
          param: GetCurrentEnvDidIdentifierParam(
              privateKey: param.privateKey, profileNonce: param.profileNonce));
      if (param.profileNonce > 0) {
        return _iden3commRepository
            .getInteractions(did: did, privateKey: param.privateKey)
            .then((connections) {
          logger().i("[GetInteractionsUseCase] Interactions: $connections");
          return connections;
        }).catchError((error) {
          logger().e("[GetClaimsUseCase] Error: $error");
          throw error;
        });
      } else {
        var identityEntity = await _getIdentityUseCase.execute(
            param: GetIdentityParam(
                genesisDid: did, privateKey: param.privateKey));
        List<ConnectionEntity> result = [];
        for (var profileDid in identityEntity.profiles.values) {
          List<ConnectionEntity> didInteractions = await _iden3commRepository
              .getInteractions(did: profileDid, privateKey: param.privateKey)
              .then((connections) {
            logger().i("[GetInteractionsUseCase] Interactions: $connections");
            return connections;
          }).catchError((error) {
            logger().e("[GetClaimsUseCase] Error: $error");
            throw error;
          });
          result.addAll(didInteractions);
        }
        return result;
      }
    } else {
      throw InvalidProfileException(param.profileNonce);
    }
  }
}
