import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/rhs_node_entity.dart';

import '../repositories/credential_repository.dart';

class FetchIdentityStateParam {
  final String rhsBaseUrl;
  final String idStateHash;

  FetchIdentityStateParam({
    required this.rhsBaseUrl,
    required this.idStateHash,
  });
}

class FetchIdentityStateUseCase
    extends FutureUseCase<FetchIdentityStateParam, RhsNodeEntity> {
  final CredentialRepository _credentialRepository;

  FetchIdentityStateUseCase(this._credentialRepository);

  @override
  Future<RhsNodeEntity> execute(
      {required FetchIdentityStateParam param}) async {
    RhsNodeEntity rhsIdentityState = await _credentialRepository
        .fetchIdentityState(url: param.rhsBaseUrl + param.idStateHash);
    return rhsIdentityState;
  }
}
