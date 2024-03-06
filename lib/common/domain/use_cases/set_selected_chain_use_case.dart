import 'package:polygonid_flutter_sdk/common/domain/repositories/config_repository.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';

class SetSelectedChainUseCase extends FutureUseCase<String, void> {
  final ConfigRepository _configRepository;

  SetSelectedChainUseCase(this._configRepository);

  @override
  Future<void> execute({required String param}) {
    return _configRepository.setSelectedChainId(chainId: param);
  }
}
