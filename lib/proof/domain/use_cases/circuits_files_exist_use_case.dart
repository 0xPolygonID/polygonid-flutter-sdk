import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';

class CircuitsFilesExistUseCase extends FutureUseCase<String, bool> {
  final ProofRepository _proofRepository;

  CircuitsFilesExistUseCase(this._proofRepository);

  @override
  Future<bool> execute({required String param}) {
    return _proofRepository
        .circuitsFilesExist(circuitsFileName: param)
        .then((value) {
      logger().i("[CircuitsFilesExistUseCase] circuits files exist: $value");
      return value;
    });
  }
}
