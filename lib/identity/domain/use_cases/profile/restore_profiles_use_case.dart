import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/identity/update_identity_use_case.dart';

class RestoreProfilesParam {
  final String genesisDid;
  final String privateKey;

  RestoreProfilesParam(this.genesisDid, this.privateKey);
}

class RestoreProfilesUseCase extends FutureUseCase<RestoreProfilesParam, void> {
  final IdentityRepository _identityRepository;
  final UpdateIdentityUseCase _updateIdentityUseCase;

  RestoreProfilesUseCase(
    this._identityRepository,
    this._updateIdentityUseCase,
  );

  @override
  Future<void> execute({required RestoreProfilesParam param}) async {
    Map<BigInt, String> restoredProfiles =
        await _identityRepository.getProfiles(
      did: param.genesisDid,
      privateKey: param.privateKey,
    );

    await _updateIdentityUseCase.execute(
        param: UpdateIdentityParam(
      privateKey: param.privateKey,
      genesisDid: param.genesisDid,
      profiles: restoredProfiles,
    ));
  }
}
