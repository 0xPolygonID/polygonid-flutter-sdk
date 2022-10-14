import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';

import '../repositories/identity_repository.dart';

class FetchIdentityStateParam {
  final String id;

  FetchIdentityStateParam({
    required this.id,
  });
}

class FetchIdentityStateUseCase
    extends FutureUseCase<FetchIdentityStateParam, List<dynamic>> {
  final IdentityRepository _identityRepository;

  FetchIdentityStateUseCase(this._identityRepository);

  @override
  Future<List<dynamic>> execute(
      {required FetchIdentityStateParam param}) async {
    List<dynamic> issuerState =
        await _identityRepository.fetchIdentityState(id: param.id);
    return issuerState;
  }
}
