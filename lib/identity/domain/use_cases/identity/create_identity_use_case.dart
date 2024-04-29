import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_public_keys_use_case.dart';

import '../../../../common/domain/domain_logger.dart';
import '../../../../common/domain/use_case.dart';
import '../../repositories/identity_repository.dart';

class CreateIdentityParam {
  final String privateKey;
  final List<BigInt> profiles;

  CreateIdentityParam({
    required this.privateKey,
    this.profiles = const [],
  });
}

class CreateIdentityUseCase
    extends FutureUseCase<CreateIdentityParam, PrivateIdentityEntity> {
  final GetPublicKeysUseCase _getPublicKeysUseCase;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;
  final StacktraceManager _stacktraceManager;

  CreateIdentityUseCase(
    this._getPublicKeysUseCase,
    this._getCurrentEnvDidIdentifierUseCase,
    this._stacktraceManager,
  );

  @override
  Future<PrivateIdentityEntity> execute({
    required CreateIdentityParam param,
  }) async {
    return Future.wait(
      [
        _getPublicKeysUseCase.execute(param: param.privateKey),
        _getCurrentEnvDidIdentifierUseCase.execute(
          param: GetCurrentEnvDidIdentifierParam(
            privateKey: param.privateKey,
            profileNonce: GENESIS_PROFILE_NONCE,
          ),
        )
      ],
      eagerError: true,
    ).then((values) async {
      String didIdentifier = values[1] as String;
      List<String> publicKey = values[0] as List<String>;
      Map<BigInt, String> profiles = {GENESIS_PROFILE_NONCE: didIdentifier};

      for (BigInt profile in param.profiles) {
        String identifier = await _getCurrentEnvDidIdentifierUseCase.execute(
          param: GetCurrentEnvDidIdentifierParam(
            privateKey: param.privateKey,
            profileNonce: profile,
          ),
        );
        profiles[profile] = identifier;
      }

      return PrivateIdentityEntity(
        did: didIdentifier,
        publicKey: publicKey,
        profiles: profiles,
        privateKey: param.privateKey,
      );
    }).then((identity) {
      logger().i(
          "[CreateIdentityUseCase] Identity created with did: ${identity.did}, for param $param");
      _stacktraceManager.addTrace(
          "[CreateIdentityUseCase] Identity created with did: ${identity.did}, for param $param");

      return identity;
    }).catchError((error) {
      logger().e("[CreateIdentityUseCase] Error: $error for param $param");
      _stacktraceManager
          .addTrace("[CreateIdentityUseCase] Error: $error for param $param");
      _stacktraceManager
          .addError("[CreateIdentityUseCase] Error: $error for param $param");

      throw error;
    });
  }
}
