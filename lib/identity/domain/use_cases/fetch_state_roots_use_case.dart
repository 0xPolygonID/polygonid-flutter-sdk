import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/rhs_node_entity.dart';

import '../repositories/identity_repository.dart';

class FetchStateRootsParam {
  final String rhsBaseUrl;
  final String idStateHash;

  FetchStateRootsParam({
    required this.rhsBaseUrl,
    required this.idStateHash,
  });
}

class FetchStateRootsUseCase
    extends FutureUseCase<FetchStateRootsParam, RhsNodeEntity> {
  final IdentityRepository _identityRepository;

  FetchStateRootsUseCase(this._identityRepository);

  @override
  Future<RhsNodeEntity> execute({required FetchStateRootsParam param}) async {
    RhsNodeEntity rhsIdentityState = await _identityRepository.fetchStateRoots(
        url: param.rhsBaseUrl + param.idStateHash);
    return rhsIdentityState;
  }
}
