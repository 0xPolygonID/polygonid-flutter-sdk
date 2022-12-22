import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../entities/node_entity.dart';

class GetAuthClaimParam {
  final List<String> children;

  GetAuthClaimParam({
    required this.children,
  });
}

class GetAuthClaimUseCase extends FutureUseCase<GetAuthClaimParam, NodeEntity> {
  final IdentityRepository _identityRepository;

  GetAuthClaimUseCase(this._identityRepository);

  @override
  Future<NodeEntity> execute({required GetAuthClaimParam param}) async {
    return _identityRepository
        .getAuthClaimNode(children: param.children)
        .then((authClaim) {
      logger().i("[GetAuthClaimUseCase] auth claim: $authClaim");
      return authClaim;
    }).catchError((error) {
      logger().e("[GetAuthClaimUseCase] Error: $error");
      throw error;
    });
  }
}
