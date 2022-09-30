import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../repositories/iden3comm_repository.dart';

class GetAuthTokenParam {
  final String identifier;
  final String message;

  GetAuthTokenParam(this.identifier, this.message);
}

class GetAuthTokenUseCase extends FutureUseCase<GetAuthTokenParam, String> {
  final Iden3commRepository _iden3commRepository;

  GetAuthTokenUseCase(this._iden3commRepository);

  @override
  Future<String> execute({required GetAuthTokenParam param}) async {
    return _iden3commRepository
        .getAuthToken(identifier: param.identifier, message: param.message)
        .then((token) {
      logger().i("[GetAuthTokenUseCase] Auth token: $token");

      return token;
    }).catchError((error) {
      logger().e("[GetAuthTokenUseCase] Error: $error");

      throw error;
    });
  }
}
