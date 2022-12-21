import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/circuit_data_entity.dart';
import '../repositories/proof_repository.dart';

class LoadCircuitUseCase extends FutureUseCase<String, CircuitDataEntity> {
  final ProofRepository _proofRepository;

  LoadCircuitUseCase(this._proofRepository);

  @override
  Future<CircuitDataEntity> execute({required String param}) async {
    return _proofRepository.loadCircuitFiles(param).then((circuit) {
      logger().i("[LoadCircuitUseCase] Circuit: $circuit");

      return circuit;
    }).catchError((error) {
      logger().e("[LoadCircuitUseCase] Error: $error");

      throw error;
    });
  }
}
