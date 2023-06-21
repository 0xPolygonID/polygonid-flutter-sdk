import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/generate_non_rev_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_non_rev_proof_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';

class GetClaimRevocationNonceUseCase extends FutureUseCase<ClaimEntity, int> {
  final CredentialRepository _credentialRepository;

  GetClaimRevocationNonceUseCase(this._credentialRepository);

  @override
  Future<int> execute({required ClaimEntity param}) async {
    return _credentialRepository.isUsingRHS(claim: param).then((rhs) =>
        _credentialRepository.getRevocationNonce(claim: param, rhs: rhs));
  }
}
