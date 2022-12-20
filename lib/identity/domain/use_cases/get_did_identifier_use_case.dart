import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../repositories/identity_repository.dart';

class GetDidIdentifierParam {
  final String privateKey;
  final String blockchain;
  final String network;

  GetDidIdentifierParam({
    required this.privateKey,
    required this.blockchain,
    required this.network,
  });
}

class GetDidIdentifierUseCase
    extends FutureUseCase<GetDidIdentifierParam, String> {
  final IdentityRepository _identityRepository;

  GetDidIdentifierUseCase(this._identityRepository);

  @override
  Future<String> execute({required GetDidIdentifierParam param}) {
    return _identityRepository
        .getDidIdentifier(
            privateKey: param.privateKey,
            blockchain: param.blockchain,
            network: param.network)
        .then((did) {
      logger().i("[GetDidIdentifierUseCase] did: $did");

      return did;
    }).catchError((error) {
      logger().e("[GetDidIdentifierUseCase] Error: $error");

      throw error;
    });
  }
}
