import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/connection_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

class GetConnectionsParam {
  final String did;
  final BigInt profileNonce;
  final String privateKey;

  GetConnectionsParam({
    required this.did,
    required this.profileNonce,
    required this.privateKey,
  });
}

class GetConnectionsUseCase
    extends FutureUseCase<GetConnectionsParam, List<ConnectionEntity>> {
  final Iden3commRepository _iden3commRepository;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;
  final GetIdentityUseCase _getIdentityUseCase;

  GetConnectionsUseCase(this._iden3commRepository,
      this._getCurrentEnvDidIdentifierUseCase, this._getIdentityUseCase);

  @override
  Future<List<ConnectionEntity>> execute(
      {required GetConnectionsParam param}) async {
    // if profileNonce is zero, return all profiles' credentials,
    // if profileNonce > 0 then return only credentials from that profile
    if (param.profileNonce >= GENESIS_PROFILE_NONCE) {
      // TODO check param.did and did from profile nonce are the same or return exception
      String did = await _getCurrentEnvDidIdentifierUseCase.execute(
          param: GetCurrentEnvDidIdentifierParam(
              privateKey: param.privateKey, profileNonce: param.profileNonce));
      if (param.profileNonce > GENESIS_PROFILE_NONCE) {
        return _iden3commRepository
            .getConnections(did: did, privateKey: param.privateKey)
            .then((connections) {
          logger().i("[GetConnectionsUseCase] Connections: $connections");
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
          List<ConnectionEntity> didConnections = await _iden3commRepository
              .getConnections(did: profileDid, privateKey: param.privateKey)
              .then((connections) {
            logger().i("[GetConnectionsUseCase] Connections: $connections");
            return connections;
          }).catchError((error) {
            logger().e("[GetClaimsUseCase] Error: $error");
            throw error;
          });
          result.addAll(didConnections);
        }
        return result;
      }
    } else {
      throw InvalidProfileException(param.profileNonce);
    }
  }
}
