import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/chain_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_selected_chain_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/profile/check_profile_validity_use_case.dart';

class CheckProfileAndDidCurrentEnvParam {
  final String did;
  final String privateKey;
  final BigInt profileNonce;
  final bool excludeGenesisProfile;

  CheckProfileAndDidCurrentEnvParam({
    required this.did,
    required this.privateKey,
    required this.profileNonce,
    this.excludeGenesisProfile = false,
  });
}

class CheckProfileAndDidCurrentEnvUseCase
    extends FutureUseCase<CheckProfileAndDidCurrentEnvParam, void> {
  final CheckProfileValidityUseCase _checkProfileValidityUseCase;
  final GetSelectedChainUseCase _getSelectedChainUseCase;
  final GetDidIdentifierUseCase _getDidIdentifierUseCase;
  final StacktraceManager _stacktraceManager;

  CheckProfileAndDidCurrentEnvUseCase(
    this._checkProfileValidityUseCase,
    this._getSelectedChainUseCase,
    this._getDidIdentifierUseCase,
    this._stacktraceManager,
  );

  @override
  Future<void> execute(
      {required CheckProfileAndDidCurrentEnvParam param}) async {
    try {
      // check if profile is valid, it will throw an exception if not
      await _checkProfileValidityUseCase.execute(
          param: CheckProfileValidityParam(profileNonce: param.profileNonce));
      // we get the current chain to check if the did is valid for the current environment
      final ChainConfigEntity chain = await _getSelectedChainUseCase.execute();
      // we get the did for the current environment
      final String did = await _getDidIdentifierUseCase.execute(
        param: GetDidIdentifierParam(
          privateKey: param.privateKey,
          blockchain: chain.blockchain,
          network: chain.network,
          profileNonce: GENESIS_PROFILE_NONCE,
        ),
      );

      // we check if the did is the same as the one we got from param
      if (did != param.did) {
        throw DidNotMatchCurrentEnvException(
          did: param.did,
          rightDid: did,
          errorMessage: "DID does not match current environment DID",
        );
      }

      logger().i(
          "[CheckProfileAndDidCurrentEnvUseCase] Profile ${param.profileNonce} and private key are valid for current env");
      _stacktraceManager.addTrace(
          "[CheckProfileAndDidCurrentEnvUseCase] Profile ${param.profileNonce} and private key are valid for current env");
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      logger().e("[CheckProfileAndDidCurrentEnvUseCase] Error: $error");
      _stacktraceManager
          .addTrace("[CheckProfileAndDidCurrentEnvUseCase] Error: $error");
      _stacktraceManager
          .addError("[CheckProfileAndDidCurrentEnvUseCase] Error: $error");
      throw CheckProfileValidityException(
        errorMessage: "Error checking profile for current env",
        error: error,
      );
    }
  }
}
