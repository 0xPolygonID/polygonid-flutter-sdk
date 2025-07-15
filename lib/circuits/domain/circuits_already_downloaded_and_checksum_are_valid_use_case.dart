import 'package:polygonid_flutter_sdk/circuits/data/circuit_model.dart';
import 'package:polygonid_flutter_sdk/circuits/domain/circuits_repository.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';

class CheckCircuitsUseCase extends FutureUseCase<List<CircuitModel>, bool> {
  final CircuitsRepository _circuitsRepository;

  CheckCircuitsUseCase(this._circuitsRepository);

  @override
  Future<bool> execute({required List<CircuitModel> param}) async {
    bool allCircuitsExistAndValid = true;

    for (final circuitModel in param) {
      final existAndValid =
          await _circuitsRepository.circuitExistsAndValidChecksum(
        circuitFileName: circuitModel.fileName,
        circuitId: circuitModel.circuitId,
        checksum: circuitModel.checksum,
      );

      if (!existAndValid) {
        allCircuitsExistAndValid = false;
        break;
      }
    }

    return allCircuitsExistAndValid;
  }
}
