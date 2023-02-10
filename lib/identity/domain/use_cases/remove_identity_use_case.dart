import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_stype.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../../../credential/domain/use_cases/remove_all_claims_use_case.dart';
import '../repositories/identity_repository.dart';

class RemoveIdentityParam {
  final String did;
  final String privateKey;

  RemoveIdentityParam({
    required this.did,
    required this.privateKey,
  });
}

class RemoveIdentityUseCase extends FutureUseCase<RemoveIdentityParam, void> {
  final IdentityRepository _identityRepository;
  final SMTRepository _smtRepository;
  final RemoveAllClaimsUseCase _removeAllClaimsUseCase;

  RemoveIdentityUseCase(
    this._identityRepository,
    this._smtRepository,
    this._removeAllClaimsUseCase,
  );

  @override
  Future<void> execute({required RemoveIdentityParam param}) {
    return _removeAllClaimsUseCase
        .execute(
            param: RemoveAllClaimsParam(
                did: param.did, privateKey: param.privateKey))
        .then((_) => Future.wait([
              _smtRepository.removeSMT(
                type: TreeType.claims,
                did: param.did,
                privateKey: param.privateKey,
              ),
              _smtRepository.getRoot(
                type: TreeType.revocation,
                did: param.did,
                privateKey: param.privateKey,
              ),
              _smtRepository.getRoot(
                type: TreeType.roots,
                did: param.did,
                privateKey: param.privateKey,
              ),
            ]))
        .then((_) => _identityRepository
                .removeIdentity(did: param.did)
                .catchError((error) {
              logger().e("[RemoveIdentityUseCase] Error: $error");

              throw error;
            }))
        .catchError((error) {
      logger().e("[RemoveIdentityUseCase] Error: $error");

      throw error;
    });
  }
}
