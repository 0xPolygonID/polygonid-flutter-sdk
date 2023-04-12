import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/connection_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/get_identity_use_case.dart';

class GetConnectionsParam {
  final String genesisDid;
  final BigInt profileNonce;
  final String privateKey;

  GetConnectionsParam({
    required this.genesisDid,
    required this.profileNonce,
    required this.privateKey,
  });
}

class GetConnectionsUseCase
    extends FutureUseCase<GetConnectionsParam, List<ConnectionEntity>> {
  final Iden3commRepository _iden3commRepository;
  final CheckProfileAndDidCurrentEnvUseCase
      _checkProfileAndDidCurrentEnvUseCase;

  GetConnectionsUseCase(
    this._iden3commRepository,
    this._checkProfileAndDidCurrentEnvUseCase,
  );

  @override
  Future<List<ConnectionEntity>> execute(
      {required GetConnectionsParam param}) async {
    await _checkProfileAndDidCurrentEnvUseCase.execute(
        param: CheckProfileAndDidCurrentEnvParam(
            did: param.genesisDid,
            privateKey: param.privateKey,
            profileNonce: param.profileNonce));

    return _iden3commRepository
        .getConnections(
            genesisDid: param.genesisDid,
            profileNonce: param.profileNonce,
            privateKey: param.privateKey)
        .then((connections) {
      logger().i("[GetConnectionsUseCase] Connections: $connections");
      return connections;
    }).catchError((error) {
      logger().e("[GetClaimsUseCase] Error: $error");
      throw error;
    });
  }
}
