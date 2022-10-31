import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_config_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../repositories/identity_repository.dart';

class GenerateNonRevProofUseCase
    extends FutureUseCase<ClaimEntity, Map<String, dynamic>> {
  final IdentityRepository _identityRepository;
  final CredentialRepository _credentialRepository;
  final GetEnvConfigUseCase _getEnvConfigUseCase;

  GenerateNonRevProofUseCase(this._identityRepository,
      this._credentialRepository, this._getEnvConfigUseCase);

  @override
  Future<Map<String, dynamic>> execute({required ClaimEntity param}) {
    return Future.wait<dynamic>([
      _getEnvConfigUseCase.execute(
          param: PolygonIdConfig.reverseHashServiceUrl),
      _credentialRepository.getRhsRevocationId(claim: param),
      _credentialRepository.getRevocationNonce(claim: param),
    ])
        .then((values) =>
            _identityRepository.getNonRevProof(values[2], values[1], values[0]))
        .then((nonRevProof) {
      logger().i("[GenerateNonRevProofUseCase] Non rev proof: $nonRevProof");

      return nonRevProof;
    }).catchError((error) {
      logger().e("[GenerateNonRevProofUseCase] Error: $error");

      throw error;
    });
  }
}
