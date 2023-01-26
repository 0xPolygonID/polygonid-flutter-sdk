import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_config_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_proof_entity.dart';

import '../repositories/proof_repository.dart';

class GetGistProofUseCase extends FutureUseCase<String, GistProofEntity> {
  final ProofRepository _proofRepository;
  final IdentityRepository _identityRepository;
  final GetEnvConfigUseCase _getEnvConfigUseCase;
  final GetDidUseCase _getDidUseCase;

  GetGistProofUseCase(
    this._proofRepository,
    this._identityRepository,
    this._getEnvConfigUseCase,
    this._getDidUseCase,
  );

  @override
  Future<GistProofEntity> execute({required String param}) async {
    return Future.wait([
      _getEnvConfigUseCase.execute(
          param: PolygonIdConfig.idStateContractAddress),
      _getDidUseCase.execute(param: param).then(
          (did) => _identityRepository.convertIdToBigInt(id: did.identifier))
    ])
        .then((values) => _proofRepository.getGistProof(
            idAsInt: values[1], contractAddress: values[0]))
        .then((proof) {
      logger()
          .i("[GetGistProofUseCase] Gist proof $proof for identifier $param");

      return proof;
    }).catchError((error) {
      logger().e("[GetGistProofUseCase] Error: $error");

      throw error;
    });
  }
}
