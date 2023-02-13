import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/update_identity_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/did_entity.dart';
import '../entities/identity_entity.dart';
import '../repositories/identity_repository.dart';
import 'get_did_identifier_use_case.dart';
import 'get_did_use_case.dart';
import 'get_identities_use_case.dart';
import 'get_identity_use_case.dart';

class RemoveProfileParam {
  final int profileNonce;
  final String genesisDid;
  final String privateKey;

  RemoveProfileParam({
    required this.profileNonce,
    required this.genesisDid,
    required this.privateKey,
  });
}

class RemoveProfileUseCase
    extends FutureUseCase<RemoveProfileParam, void> {
  final IdentityRepository _identityRepository;
  final GetIdentityUseCase _getIdentityUseCase;
  final GetDidUseCase _getDidUseCase;
  final UpdateIdentityUseCase _updateIdentityUseCase;

  RemoveProfileUseCase(this._identityRepository, this._getIdentityUseCase, this._getDidUseCase, this._updateIdentityUseCase);

  @override
  Future<void> execute({required RemoveProfileParam param}) async {
    var identityEntity = await _getIdentityUseCase
        .execute(param: GetIdentityParam(genesisDid: param.genesisDid, privateKey: param.privateKey));
    if (identityEntity is PrivateIdentityEntity) {

      var didEntity = await _getDidUseCase.execute(param: param.genesisDid);

      List<int> profiles = identityEntity.profiles.keys.toList();
      profiles.remove(param.profileNonce);

      await _updateIdentityUseCase.execute(param: UpdateIdentityParam(
          privateKey: param.privateKey,
          blockchain: didEntity.blockchain,
          network: didEntity.network,
          profiles:profiles));
    } else {
      throw InvalidPrivateKeyException(param.privateKey);
    }
  }
}
