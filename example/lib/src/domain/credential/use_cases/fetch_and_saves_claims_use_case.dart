import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/credential_request_entity.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/credential/repositories/credential_repository.dart';

class FetchAndSavesClaimsUseCase extends FutureUseCase<List<CredentialRequestEntity>, List<ClaimEntity>> {
  final CredentialRepository _claimsRepository;

  FetchAndSavesClaimsUseCase(this._claimsRepository);

  @override
  Future<List<ClaimEntity>> execute({required List<CredentialRequestEntity> param}) {
    return _claimsRepository.fetchAndSavesClaims(credentialRequests: param);
  }
}
