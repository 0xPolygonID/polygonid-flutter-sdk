import 'package:polygonid_flutter_sdk/circuits/domain/circuits_repository.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';

class RemoveCircuitsUseCase extends FutureUseCase<List<String>, bool> {
  final CircuitsRepository _circuitsRepository;

  RemoveCircuitsUseCase(this._circuitsRepository);

  @override
  Future<bool> execute({required List<String> param}) async {
    bool allCircuitsRemoved = true;

    for (final circuitFileName in param) {
      final removed = await _circuitsRepository.removeCircuit(
          circuitFileName: circuitFileName);

      if (!removed) {
        allCircuitsRemoved = false;
        break;
      }
    }

    return allCircuitsRemoved;
  }
}
