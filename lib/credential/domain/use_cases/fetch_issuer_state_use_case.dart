import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';

import '../repositories/credential_repository.dart';

class FetchIssuerStateParam {
  final String id;

  FetchIssuerStateParam({
    required this.id,
  });
}

class FetchIssuerStateUseCase
    extends FutureUseCase<FetchIssuerStateParam, List<dynamic>> {
  final CredentialRepository _credentialRepository;

  FetchIssuerStateUseCase(this._credentialRepository);

  @override
  Future<List<dynamic>> execute({required FetchIssuerStateParam param}) async {
    List<dynamic> issuerState =
        await _credentialRepository.fetchIssuerState(id: param.id);
    return issuerState;
  }
}
