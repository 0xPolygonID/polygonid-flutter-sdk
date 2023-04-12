import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_genesis_state_use_case.dart';

import '../../../common/domain/domain_logger.dart';
import '../../../common/domain/use_case.dart';
import '../repositories/identity_repository.dart';

class GetDidIdentifierParam {
  final String privateKey;
  final String blockchain;
  final String network;
  final BigInt profileNonce;

  GetDidIdentifierParam({
    required this.privateKey,
    required this.blockchain,
    required this.network,
    required this.profileNonce,
  });
}

class GetDidIdentifierUseCase
    extends FutureUseCase<GetDidIdentifierParam, String> {
  final IdentityRepository _identityRepository;
  final GetGenesisStateUseCase _getGenesisStateUseCase;

  GetDidIdentifierUseCase(
      this._identityRepository, this._getGenesisStateUseCase);

  @override
  Future<String> execute({required GetDidIdentifierParam param}) {
    return _getGenesisStateUseCase
        .execute(param: param.privateKey)
        .then((genesisState) => _identityRepository.getDidIdentifier(
            blockchain: param.blockchain,
            network: param.network,
            claimsRoot: genesisState.claimsTree.data,
            profileNonce: param.profileNonce))
        .then((did) {
      logger().i("[GetDidIdentifierUseCase] did: $did");

      return did;
    }).catchError((error) {
      logger().e("[GetDidIdentifierUseCase] Error: $error");

      throw error;
    });
  }
}
