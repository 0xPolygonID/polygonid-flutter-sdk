import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/gist_proof_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:web3dart/web3dart.dart';

import '../repositories/proof_repository.dart';

class GetGistProofUseCase extends FutureUseCase<String, GistProofEntity> {
  final ProofRepository _proofRepository;
  final IdentityRepository _identityRepository;
  final GetEnvUseCase _getEnvUseCase;
  final GetDidUseCase _getDidUseCase;

  GetGistProofUseCase(
    this._proofRepository,
    this._identityRepository,
    this._getEnvUseCase,
    this._getDidUseCase,
  );

  @override
  Future<GistProofEntity> execute({required String param}) async {
    return Future.wait([
      _getEnvUseCase.execute(),
      _getDidUseCase.execute(param: param).then(
          (did) => _identityRepository.convertIdToBigInt(id: did.identifier))
    ])
        .then((values) => _proofRepository.getGistProof(
            web3client:
                getItSdk.get<Web3Client>(param1: (values[0] as EnvEntity)),
            idAsInt: values[1] as String,
            contractAddress: (values[0] as EnvEntity).idStateContract))
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
