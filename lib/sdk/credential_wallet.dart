import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/domain/credential/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/domain/credential/entities/credential_request_entity.dart';
import 'package:polygonid_flutter_sdk/domain/credential/use_cases/fetch_and_save_claims_use_case.dart';

@injectable
class CredentialWallet {
  final FetchAndSaveClaimsUseCase _fetchAndSaveClaimsUseCase;

  CredentialWallet(this._fetchAndSaveClaimsUseCase);

  /// Fetch a list of [ClaimEntity] and store them
  Future<List<ClaimEntity>> fetchAndSaveClaims(
      {required List<CredentialRequestEntity> credentialRequests}) {
    return _fetchAndSaveClaimsUseCase.execute(param: credentialRequests);
  }
}
