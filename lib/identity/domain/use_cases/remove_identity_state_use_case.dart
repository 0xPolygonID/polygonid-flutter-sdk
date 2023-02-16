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

class RemoveIdentityStateParam {
  final String did;
  final String privateKey;

  RemoveIdentityStateParam({
    required this.did,
    required this.privateKey,
  });
}

class RemoveIdentityStateUseCase
    extends FutureUseCase<RemoveIdentityStateParam, void> {
  final IdentityRepository _identityRepository;

  RemoveIdentityStateUseCase(this._identityRepository);

  @override
  Future<void> execute({required RemoveIdentityStateParam param}) async {
    return _identityRepository.removeIdentityState(
        did: param.did, privateKey: param.privateKey);
  }
}
