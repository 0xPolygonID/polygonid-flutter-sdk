import 'dart:typed_data';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../credential/data/dtos/credential_dto.dart';
import '../repositories/proof_repository.dart';

class GetAtomicQueryInputsParam {
  final String challenge;
  final CredentialDTO credential;
  final String circuitId;
  final String key;
  final List<int> values;
  final int operator;
  final String pubX;
  final String pubY;
  final String? signature;

  GetAtomicQueryInputsParam(
      this.challenge,
      this.credential,
      this.circuitId,
      this.key,
      this.values,
      this.operator,
      this.pubX,
      this.pubY,
      this.signature);
}

class GetAtomicQueryInputsUseCase
    extends FutureUseCase<GetAtomicQueryInputsParam, Uint8List?> {
  final ProofRepository _proofRepository;

  GetAtomicQueryInputsUseCase(this._proofRepository);

  @override
  Future<Uint8List?> execute({required GetAtomicQueryInputsParam param}) {
    return _proofRepository
        .calculateAtomicQueryInputs(
            param.challenge,
            param.credential,
            param.circuitId,
            param.key,
            param.values,
            param.operator,
            param.pubX,
            param.pubY,
            param.signature)
        .then((inputs) {
      logger().i("[GetAtomicQueryInputsUseCase] Atomic query inputs: $inputs");

      return inputs;
    }).catchError((error) {
      logger().e("[GetAtomicQueryInputsUseCase] Error: $error");

      throw error;
    });
  }
}
