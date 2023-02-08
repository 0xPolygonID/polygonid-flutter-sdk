import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';

class DisposeCircuitsDownloadStreamUseCase extends FutureUseCase<void, void> {
  final ProofRepository _proofRepository;

  DisposeCircuitsDownloadStreamUseCase(this._proofRepository);

  @override
  Future<void> execute({void param}) async {
    return _proofRepository.disposeCircuitsDownloadInfoStreamController();
  }
}
