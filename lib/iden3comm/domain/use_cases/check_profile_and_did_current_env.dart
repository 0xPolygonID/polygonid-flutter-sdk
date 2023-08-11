import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/check_profile_validity_use_case.dart';

class CheckProfileAndDidCurrentEnvParam {
  final String did;
  final String privateKey;
  final BigInt profileNonce;
  final bool excludeGenesisProfile;

  CheckProfileAndDidCurrentEnvParam(
      {required this.did,
      required this.privateKey,
      required this.profileNonce,
      this.excludeGenesisProfile = false});
}

class CheckProfileAndDidCurrentEnvUseCase
    extends FutureUseCase<CheckProfileAndDidCurrentEnvParam, void> {
  final CheckProfileValidityUseCase _checkProfileValidityUseCase;
  final GetEnvUseCase _getEnvUseCase;
  final GetDidIdentifierUseCase _getDidIdentifierUseCase;
  final StacktraceManager _stacktraceManager;

  CheckProfileAndDidCurrentEnvUseCase(
    this._checkProfileValidityUseCase,
    this._getEnvUseCase,
    this._getDidIdentifierUseCase,
    this._stacktraceManager,
  );

  @override
  Future<void> execute({required CheckProfileAndDidCurrentEnvParam param}) {
    return _checkProfileValidityUseCase
        .execute(
            param: CheckProfileValidityParam(profileNonce: param.profileNonce))
        .then((_) => _getEnvUseCase.execute().then((env) =>
            _getDidIdentifierUseCase
                .execute(
                    param: GetDidIdentifierParam(
                        privateKey: param.privateKey,
                        blockchain: env.blockchain,
                        network: env.network,
                        profileNonce: GENESIS_PROFILE_NONCE))
                .then((did) {
              if (did != param.did) {
                throw DidNotMatchCurrentEnvException(param.did, did);
              }
            })))
        .then((identity) {
      logger().i(
          "[CheckProfileAndDidCurrentEnvUseCase] Profile ${param.profileNonce} and private key ${param.privateKey} are valid for current env");
      _stacktraceManager.addTrace(
          "[CheckProfileAndDidCurrentEnvUseCase] Profile ${param.profileNonce} and private key ${param.privateKey} are valid for current env");
      return identity;
    }).catchError((error) {
      logger().e("[CheckProfileAndDidCurrentEnvUseCase] Error: $error");
      _stacktraceManager
          .addTrace("[CheckProfileAndDidCurrentEnvUseCase] Error: $error");
      _stacktraceManager
          .addError("[CheckProfileAndDidCurrentEnvUseCase] Error: $error");
      throw error;
    });
  }
}
