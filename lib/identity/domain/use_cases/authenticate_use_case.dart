import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';

class AuthenticateUseCase extends FutureUseCase<String, bool> {
  final IdentityRepository _identityRepository;

  AuthenticateUseCase(this._identityRepository);

  @override
  Future<bool> execute({required String param}) async {
    bool authenticated = false;
    try {
      authenticated = await _identityRepository.authenticate(authQrCodeResult: param);
    } catch (_) {}
    return authenticated;
  }
}
