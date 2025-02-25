import 'package:polygonid_flutter_sdk/circuits/domain/circuits_repository.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';

class CancelCircuitsDownloadUseCase extends FutureUseCase<void, void> {
  final CircuitsRepository _circuitsRepository;

  CancelCircuitsDownloadUseCase(this._circuitsRepository);

  @override
  Future<void> execute({void param}) {
    return _circuitsRepository.cancelCircuitsDownload().then((value) {
      logger().i("[CancelCircuitsDownloadUseCase] circuits download cancelled");
    });
  }
}
