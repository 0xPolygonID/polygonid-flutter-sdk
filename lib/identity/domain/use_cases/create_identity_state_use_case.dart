import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../credential/domain/use_cases/get_auth_claim_use_case.dart';
import '../entities/did_entity.dart';
import '../entities/identity_entity.dart';
import '../repositories/identity_repository.dart';
import 'get_did_identifier_use_case.dart';
import 'get_did_use_case.dart';
import 'get_identities_use_case.dart';
import 'get_identity_use_case.dart';
import 'get_public_keys_use_case.dart';

class CreateIdentityStateParam {
  final String did;
  final String privateKey;

  CreateIdentityStateParam({
    required this.did,
    required this.privateKey,
  });
}

class CreateIdentityStateUseCase
    extends FutureUseCase<CreateIdentityStateParam, void> {
  final IdentityRepository _identityRepository;
  final GetPublicKeysUseCase _getPublicKeysUseCase;
  final GetAuthClaimUseCase _getAuthClaimUseCase;


  CreateIdentityStateUseCase(this._identityRepository, this._getPublicKeysUseCase,
  this._getAuthClaimUseCase);

  @override
  Future<void> execute({required CreateIdentityStateParam param}) async {

    List<String> publicKeys = await _getPublicKeysUseCase
        .execute(param: param.privateKey);

    // Get AuthClaim
    List<String> authClaim =
    await _getAuthClaimUseCase.execute(param: publicKeys);

    await _identityRepository.createIdentityState(
        did: param.did,
        privateKey: param.privateKey);
  }
}
