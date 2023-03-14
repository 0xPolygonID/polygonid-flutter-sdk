import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/smt_repository.dart';

import '../../../../common/domain/domain_logger.dart';
import '../../../../common/domain/use_case.dart';

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
  final SMTRepository _smtRepository;

  RemoveIdentityStateUseCase(this._smtRepository);

  @override
  Future<void> execute({required RemoveIdentityStateParam param}) {
    return Future.wait([
      _smtRepository.removeSMT(
          type: TreeType.claims, did: param.did, privateKey: param.privateKey),
      _smtRepository.removeSMT(
          type: TreeType.revocation,
          did: param.did,
          privateKey: param.privateKey),
      _smtRepository.removeSMT(
          type: TreeType.roots, did: param.did, privateKey: param.privateKey),
    ])
        .then((did) => logger().i(
            "[RemoveIdentityStateUseCase] State has been removed for did: $did"))
        .catchError((error) {
      logger().e("[RemoveIdentityStateUseCase] Error: $error");

      throw error;
    });
  }
}
