import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/fetch_identity_state_use_case.dart';

class GenerateNonRevProofParam {
  final ClaimEntity claim;
  final Map<String, dynamic>? nonRevProof;

  GenerateNonRevProofParam({
    required this.claim,
    this.nonRevProof,
  });
}

class GenerateNonRevProofUseCase
    extends FutureUseCase<GenerateNonRevProofParam, Map<String, dynamic>> {
  final IdentityRepository _identityRepository;
  final CredentialRepository _credentialRepository;
  final FetchIdentityStateUseCase _fetchIdentityStateUseCase;

  GenerateNonRevProofUseCase(this._identityRepository,
      this._credentialRepository, this._fetchIdentityStateUseCase);

  @override
  Future<Map<String, dynamic>> execute(
      {required GenerateNonRevProofParam param}) {
    return _credentialRepository
        .getIssuerIdentifier(claim: param.claim)
        .then((id) => _fetchIdentityStateUseCase.execute(param: id))
        .then((identityState) {
      if (param.nonRevProof != null &&
          param.nonRevProof!.isNotEmpty &&
          identityState == param.nonRevProof!["issuer"]["state"]) {
        return param.nonRevProof!;
      } else {
        return Future.wait<dynamic>([
          _credentialRepository.getRevocationNonce(
              claim: param.claim, rhs: true),
          _credentialRepository.getRevocationUrl(claim: param.claim, rhs: true),
        ])
            .then((values) => _identityRepository.getNonRevProof(
                identityState: identityState,
                nonce: BigInt.from(values[0]),
                baseUrl: values[1],
                cachedNonRevProof: param.nonRevProof))
            .then((nonRevProof) {
          logger()
              .i("[GenerateNonRevProofUseCase] Non rev proof: $nonRevProof");

          return nonRevProof;
        }).catchError((error) {
          logger().e("[GenerateNonRevProofUseCase] Error: $error");
          throw error;
        });
      }
    });
  }
}
