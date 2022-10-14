import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';

import '../repositories/credential_repository.dart';

class FetchIdentityStateParam {
  final String id;

  FetchIdentityStateParam({
    required this.id,
  });
}

class FetchIdentityStateUseCase
    extends FutureUseCase<FetchIdentityStateParam, List<dynamic>> {
  final CredentialRepository _credentialRepository;

  FetchIdentityStateUseCase(this._credentialRepository);

  @override
  Future<List<dynamic>> execute(
      {required FetchIdentityStateParam param}) async {
    List<dynamic> issuerState =
        await _credentialRepository.fetchIdentityState(id: param.id);
    return issuerState;
  }
}
