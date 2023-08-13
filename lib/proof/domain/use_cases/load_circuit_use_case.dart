import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/circuit_data_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';

class LoadCircuitUseCase extends FutureUseCase<String, CircuitDataEntity> {
  final ProofRepository _proofRepository;
  final StacktraceManager _stacktraceManager;

  LoadCircuitUseCase(
    this._proofRepository,
    this._stacktraceManager,
  );

  @override
  Future<CircuitDataEntity> execute({required String param}) async {
    return _proofRepository.loadCircuitFiles(param).then((circuit) {
      logger().i("[LoadCircuitUseCase] Circuit: $circuit");
      _stacktraceManager.addTrace("[LoadCircuitUseCase] Circuit: $circuit");

      return circuit;
    }).catchError((error) {
      logger().e("[LoadCircuitUseCase] Error: $error");
      _stacktraceManager.addTrace("[LoadCircuitUseCase] Error: $error");
      _stacktraceManager.addError("[LoadCircuitUseCase] Error: $error");

      throw error;
    });
  }
}
