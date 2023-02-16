import '../../../common/domain/use_case.dart';
import '../repositories/identity_repository.dart';
import 'get_identity_use_case.dart';

class GetProfilesUseCase extends FutureUseCase<String, Map<int, String>> {
  final IdentityRepository _identityRepository;
  final GetIdentityUseCase _getIdentityUseCase;

  GetProfilesUseCase(this._identityRepository, this._getIdentityUseCase);

  @override
  Future<Map<int, String>> execute({required String param}) {
    return Future.value(_getIdentityUseCase
        .execute(param: GetIdentityParam(genesisDid: param))
        .then((identity) => identity.profiles));
  }
}
