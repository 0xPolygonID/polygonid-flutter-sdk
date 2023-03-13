import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/update_identity_use_case.dart';

import 'get_did_use_case.dart';
import 'get_identity_use_case.dart';

class RemoveProfileParam {
  final int profileNonce;
  final String privateKey;

  RemoveProfileParam({
    required this.profileNonce,
    required this.privateKey,
  });
}

class RemoveProfileUseCase extends FutureUseCase<RemoveProfileParam, void> {
  final GetIdentityUseCase _getIdentityUseCase;
  final GetDidUseCase _getDidUseCase;
  final UpdateIdentityUseCase _updateIdentityUseCase;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;

  RemoveProfileUseCase(
    this._getIdentityUseCase,
    this._getDidUseCase,
    this._updateIdentityUseCase,
    this._getCurrentEnvDidIdentifierUseCase,
  );

  @override
  Future<void> execute({required RemoveProfileParam param}) async {
    var genesisDid = await _getCurrentEnvDidIdentifierUseCase.execute(
        param: GetCurrentEnvDidIdentifierParam(privateKey: param.privateKey));
    var identityEntity = await _getIdentityUseCase.execute(
        param: GetIdentityParam(
            genesisDid: genesisDid, privateKey: param.privateKey));

    if (identityEntity is PrivateIdentityEntity) {
      var didEntity = await _getDidUseCase.execute(param: genesisDid);
      List<int> profiles = identityEntity.profiles.keys.toList();
      profiles.remove(param.profileNonce);

      await _updateIdentityUseCase.execute(
          param: UpdateIdentityParam(
              privateKey: param.privateKey, profiles: profiles));
    } else {
      throw InvalidPrivateKeyException(param.privateKey);
    }
  }
}
