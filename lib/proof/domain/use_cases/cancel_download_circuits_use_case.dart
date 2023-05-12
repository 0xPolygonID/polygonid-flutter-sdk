import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';

class CancelDownloadCircuitsUseCase extends FutureUseCase<void, void> {
  final ProofRepository _proofRepository;

  CancelDownloadCircuitsUseCase(this._proofRepository);

  @override
  Future<void> execute({void param}) {
    return _proofRepository.cancelDownloadCircuits().then((value) {
      logger().i("[CancelDownloadCircuitsUseCase] circuits download cancelled");
    });
  }
}
