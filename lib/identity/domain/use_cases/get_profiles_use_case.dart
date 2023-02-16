import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/identity_entity.dart';
import '../repositories/identity_repository.dart';
import 'get_did_use_case.dart';
import 'get_identities_use_case.dart';
import 'get_identity_use_case.dart';

class GetProfilesParam {
  final String genesisDid;

  GetProfilesParam({
    required this.genesisDid,
  });
}

class GetProfilesUseCase
    extends FutureUseCase<GetProfilesParam, Map<int, String>> {
  final IdentityRepository _identityRepository;
  final GetIdentityUseCase _getIdentityUseCase;

  GetProfilesUseCase(this._identityRepository, this._getIdentityUseCase);

  @override
  Future<Map<int, String>> execute({required GetProfilesParam param}) {
    return Future.value(_getIdentityUseCase
        .execute(param: GetIdentityParam(genesisDid: param.genesisDid))
        .then((identity) => identity.profiles));
  }
}
