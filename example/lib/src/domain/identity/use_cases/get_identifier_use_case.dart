import 'package:polygonid_flutter_sdk/domain/common/use_case.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/identity/repositories/identity_repositories.dart';

class GetIdentifierUseCase extends FutureUseCase<void, String?> {
  final IdentityRepository _identityRepository;

  GetIdentifierUseCase(this._identityRepository);

  @override
  Future<String?> execute({void param}) {
    return _identityRepository.getCurrentIdentifier();
  }
}
