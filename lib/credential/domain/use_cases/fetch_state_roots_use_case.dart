import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/rhs_node_entity.dart';

import '../repositories/credential_repository.dart';

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
  final CredentialRepository _credentialRepository;

  FetchStateRootsUseCase(this._credentialRepository);

  @override
  Future<RhsNodeEntity> execute({required FetchStateRootsParam param}) async {
    RhsNodeEntity rhsIdentityState = await _credentialRepository
        .fetchStateRoots(url: param.rhsBaseUrl + param.idStateHash);
    return rhsIdentityState;
  }
}
