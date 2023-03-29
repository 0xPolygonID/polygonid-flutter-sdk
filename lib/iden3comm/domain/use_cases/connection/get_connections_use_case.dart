import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/connection_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';
import '../../repositories/iden3comm_repository.dart';

class GetConnectionsParam {
  final String did;
  final int profileNonce;
  final String privateKey;

  GetConnectionsParam({
    required this.did,
    this.profileNonce = 0,
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
    // if profileNonce is zero, return all profiles claims,
    // if profileNonce > 0 then return only claims from that profile
    if (param.profileNonce >= 0) {
      if (param.profileNonce > 0) {
        String did = await _getCurrentEnvDidIdentifierUseCase.execute(
            param: GetCurrentEnvDidIdentifierParam(
                privateKey: param.privateKey,
                profileNonce: param.profileNonce));
        return _iden3commRepository
            .getConnections(did: param.did, privateKey: param.privateKey)
            .then((connections) {
          logger().i("[GetConnectionsUseCase] Connections: $connections");
          return connections;
        }).catchError((error) {
          logger().e("[GetClaimsUseCase] Error: $error");
          throw error;
        });
      } else {
        String genesisDid = await _getCurrentEnvDidIdentifierUseCase.execute(
            param:
                GetCurrentEnvDidIdentifierParam(privateKey: param.privateKey));
        var identityEntity = await _getIdentityUseCase.execute(
            param: GetIdentityParam(
                genesisDid: genesisDid, privateKey: param.privateKey));
        List<ConnectionEntity> result = [];
        for (var did in identityEntity.profiles.values) {
          List<ConnectionEntity> didConnections = await _iden3commRepository
              .getConnections(did: param.did, privateKey: param.privateKey)
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
