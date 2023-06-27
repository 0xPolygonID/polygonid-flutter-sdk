import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_mtproof_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/repositories/proof_repository.dart';

class GetGistMTProofUseCase extends FutureUseCase<String, GistMTProofEntity> {
  final ProofRepository _proofRepository;
  final IdentityRepository _identityRepository;
  final GetEnvUseCase _getEnvUseCase;
  final GetDidUseCase _getDidUseCase;

  GetGistMTProofUseCase(
    this._proofRepository,
    this._identityRepository,
    this._getEnvUseCase,
    this._getDidUseCase,
  );

  @override
  Future<GistMTProofEntity> execute({required String param}) async {
    return Future.wait([
      _getEnvUseCase.execute(),
      _getDidUseCase.execute(param: param).then(
          (did) => _identityRepository.convertIdToBigInt(id: did.identifier))
    ])
        .then((values) => _proofRepository.getGistProof(
            idAsInt: values[1] as String,
            contractAddress: (values[0] as EnvEntity).idStateContract))
        .then((proof) {
      logger()
          .i("[GetGistMTProofUseCase] Gist proof $proof for identifier $param");

      return proof;
    }).catchError((error) {
      logger().e("[GetGistMTProofUseCase] Error: $error");

      throw error;
    });
  }
}
