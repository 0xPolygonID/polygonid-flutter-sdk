import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../repositories/identity_repository.dart';

class GetDidIdentifierParam {
  final List<String> publicKey;
  final String blockchain;
  final String network;

  GetDidIdentifierParam({
    required this.publicKey,
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
            publicKey: param.publicKey,
            blockchain: param.blockchain,
            network: param.network)
        .then((didIdentifier) {
      logger().i("[GetDidIdentifierUseCase] DID identifier: $didIdentifier");

      return didIdentifier;
    }).catchError((error) {
      logger().e("[GetDidIdentifierUseCase] Error: $error");

      throw error;
    });
  }
}
