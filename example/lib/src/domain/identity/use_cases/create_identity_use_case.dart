import 'package:polygonid_flutter_sdk/domain/common/use_case.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/repositories/identity_repositories.dart';


class CreateIdentityUseCase extends FutureUseCase<String?, String> {
  final IdentityRepository _identityRepository;

  CreateIdentityUseCase(this._identityRepository);

  @override
  Future<String> execute({String? param}) async {
    String identifier = await _identityRepository.createIdentity(privateKey: param);

    return identifier;
  }
}
