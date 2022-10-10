import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk_example/src/domain/iden3comm/repositories/iden3comm_repository.dart';

///
class AuthenticateParam {
  final String issuerMessage;
  final String identifier;

  AuthenticateParam({
    required this.issuerMessage,
    required this.identifier,
  });
}

///
class AuthenticateUseCase extends FutureUseCase<AuthenticateParam, void> {
  final Iden3CommRepository _iden3commRepository;

  AuthenticateUseCase(this._iden3commRepository);

  @override
  Future<void> execute({required AuthenticateParam param}) async {
    await _iden3commRepository.authenticate(
      issuerMessage: param.issuerMessage,
      identifier: param.identifier,
    );
  }
}
