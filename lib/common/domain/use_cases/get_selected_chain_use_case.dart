import 'package:polygonid_flutter_sdk/common/domain/entities/chain_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/repositories/config_repository.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';

class GetSelectedChainUseCase extends FutureUseCase<void, ChainConfigEntity> {
  final ConfigRepository _configRepository;
  final GetEnvUseCase _getEnvUseCase;

  GetSelectedChainUseCase(this._configRepository, this._getEnvUseCase);

  @override
  Future<ChainConfigEntity> execute({dynamic param}) async {
    final selectedChainId = await _configRepository.getSelectedChainId();
    final env = await _getEnvUseCase.execute();

    if (selectedChainId != null) {
      return env.chainConfigs[selectedChainId]!;
    }

    return ChainConfigEntity(
      name: env.blockchain + " " + env.network,
      blockchain: env.blockchain,
      network: env.network,
      rpcUrl: env.rpcUrl,
      stateContractAddr: env.idStateContract,
    );
  }
}
