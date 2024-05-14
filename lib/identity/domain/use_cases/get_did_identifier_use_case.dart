import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_genesis_state_use_case.dart';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';

class GetDidIdentifierParam {
  final String privateKey;
  final String blockchain;
  final String network;
  final BigInt profileNonce;

  GetDidIdentifierParam({
    required this.privateKey,
    required this.blockchain,
    required this.network,
    required this.profileNonce,
  });
}

class GetDidIdentifierUseCase
    extends FutureUseCase<GetDidIdentifierParam, String> {
  final IdentityRepository _identityRepository;
  final GetEnvUseCase _getEnvUseCase;
  final GetGenesisStateUseCase _getGenesisStateUseCase;
  final StacktraceManager _stacktraceManager;

  GetDidIdentifierUseCase(
    this._identityRepository,
    this._getEnvUseCase,
    this._getGenesisStateUseCase,
    this._stacktraceManager,
  );

  @override
  Future<String> execute({required GetDidIdentifierParam param}) async {
    EnvEntity env = await _getEnvUseCase.execute();

    return _getGenesisStateUseCase
        .execute(param: param.privateKey)
        .then(
          (genesisState) => _identityRepository.getDidIdentifier(
            blockchain: param.blockchain,
            network: param.network,
            claimsRoot: genesisState.claimsTree.data,
            profileNonce: param.profileNonce,
            config: env.config,
          ),
        )
        .then((did) {
      logger().i("[GetDidIdentifierUseCase] did: $did");

      return did;
    }).catchError((error) {
      logger().e("[GetDidIdentifierUseCase] Error: $error");
      _stacktraceManager.addTrace("[GetDidIdentifierUseCase] Error: $error");
      throw error;
    });
  }
}
