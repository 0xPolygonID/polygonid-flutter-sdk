import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_public_keys_use_case.dart';

import '../../../../common/domain/domain_logger.dart';
import '../../../../common/domain/use_case.dart';
import '../../repositories/identity_repository.dart';
import '../get_did_identifier_use_case.dart';

class CreateIdentityParam {
  final String privateKey;
  final String blockchain;
  final String network;
  final List<int> profiles;

  CreateIdentityParam(
      {required this.privateKey,
      required this.blockchain,
      required this.network,
      this.profiles = const []});
}

class CreateIdentityUseCase
    extends FutureUseCase<CreateIdentityParam, PrivateIdentityEntity> {
  final IdentityRepository _identityRepository;
  final GetPublicKeysUseCase _getPublicKeysUseCase;
  final GetDidIdentifierUseCase _getDidIdentifierUseCase;

  CreateIdentityUseCase(
    this._identityRepository,
    this._getPublicKeysUseCase,
    this._getDidIdentifierUseCase,
  );

  @override
  Future<PrivateIdentityEntity> execute(
      {required CreateIdentityParam param}) async {
    return Future.wait([
      _getPublicKeysUseCase.execute(param: param.privateKey),
      _getDidIdentifierUseCase.execute(
          param: GetDidIdentifierParam(
              privateKey: param.privateKey,
              blockchain: param.blockchain,
              network: param.network))
    ], eagerError: true)
        .then((values) async {
      String didIdentifier = values[1] as String;
      List<String> publicKey = values[0] as List<String>;
      Map<int, String> profiles = {0: didIdentifier};

      for (int profile in param.profiles) {
        String identifier = await _getDidIdentifierUseCase.execute(
            param: GetDidIdentifierParam(
                privateKey: param.privateKey,
                blockchain: param.blockchain,
                network: param.network,
                profileNonce: profile));
        profiles[profile] = identifier;
      }

      return PrivateIdentityEntity(
          did: didIdentifier,
          publicKey: publicKey,
          profiles: profiles,
          privateKey: param.privateKey);
    }).then((identity) {
      logger().i(
          "[CreateIdentityUseCase] Identity created with did: ${identity.did}, for param $param");

      return identity;
    }).catchError((error) {
      logger().e("[CreateIdentityUseCase] Error: $error for param $param");

      throw error;
    });
  }
}
