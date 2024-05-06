import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';

class GetClaimRevocationNonceUseCase extends FutureUseCase<ClaimEntity, int> {
  final CredentialRepository _credentialRepository;

  GetClaimRevocationNonceUseCase(this._credentialRepository);

  @override
  Future<int> execute({required ClaimEntity param}) async {
    return _credentialRepository.isUsingRHS(claim: param).then((rhs) =>
        _credentialRepository.getRevocationNonce(claim: param, rhs: rhs));
  }
}
