import '../../../common/domain/use_case.dart';
import '../repositories/proof_repository.dart';

class IsProofCircuitSupportedUseCase extends FutureUseCase<String, bool> {
  final ProofRepository _proofRepository;

  IsProofCircuitSupportedUseCase(this._proofRepository);

  @override
  Future<bool> execute({required String param}) {
    return _proofRepository.isCircuitSupported(circuitId: param);
  }
}
