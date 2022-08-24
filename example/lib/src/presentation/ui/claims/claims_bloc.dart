import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk_example/src/common/bloc/bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/credential/use_cases/fetch_and_saves_claims_use_case.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/use_cases/get_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/claims/claims_state.dart';

class ClaimsBloc extends Bloc<ClaimsState> {
  final FetchAndSavesClaimsUseCase _fetchAndSavesClaimsUseCase;
  final GetIdentifierUseCase _getIdentifierUseCase;

  ClaimsBloc(this._fetchAndSavesClaimsUseCase, this._getIdentifierUseCase);

  ///
  Future<void> fetchAndSaveClaims() async {
    List<ClaimEntity> claimList = await _fetchAndSavesClaimsUseCase.execute(param: []); //TODO @Emanuel pass List<CredentialRequestEntity> as param
  }
}
