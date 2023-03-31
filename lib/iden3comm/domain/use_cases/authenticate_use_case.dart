import 'dart:async';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_package_name_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/auth_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_token_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/infrastructure/proof_generation_stream_manager.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';

class AuthenticateParam {
  final AuthIden3MessageEntity message;
  final String did;
  int profileNonce;
  final String privateKey;
  final String? pushToken;

  AuthenticateParam(
      {required this.message,
      required this.did,
      this.profileNonce = 0,
      required this.privateKey,
      this.pushToken});
}

class AuthenticateUseCase extends FutureUseCase<AuthenticateParam, void> {
  final Iden3commRepository _iden3commRepository;
  final GetAuthTokenUseCase _getAuthTokenUseCase;
  final GetIden3commProofsUseCase _getIden3commProofsUseCase;
  final GetEnvUseCase _getEnvUseCase;
  final GetPackageNameUseCase _getPackageNameUseCase;
  final GetCurrentEnvDidIdentifierUseCase _getCurrentEnvDidIdentifierUseCase;
  final ProofGenerationStepsStreamManager _proofGenerationStepsStreamManager;

  AuthenticateUseCase(
    this._iden3commRepository,
    this._getIden3commProofsUseCase,
    this._getAuthTokenUseCase,
    this._getEnvUseCase,
    this._getPackageNameUseCase,
    this._getCurrentEnvDidIdentifierUseCase,
    this._proofGenerationStepsStreamManager,
  );

  @override
  Future<void> execute({required AuthenticateParam param}) async {
    //_proofGenerationStepsStreamManager.reset();

    try {
      List<JWZProofEntity> proofs = await _getIden3commProofsUseCase.execute(
          param: GetIden3commProofsParam(
        message: param.message,
        did: param.did,
        profileNonce: param.profileNonce,
        privateKey: param.privateKey,
      ));

      String pushUrl =
          await _getEnvUseCase.execute().then((env) => env.pushUrl);

      String didIdentifier = await _getCurrentEnvDidIdentifierUseCase.execute(
          param: GetCurrentEnvDidIdentifierParam(
              privateKey: param.privateKey, profileNonce: param.profileNonce));

      String packageName = await _getPackageNameUseCase.execute();

      _proofGenerationStepsStreamManager
          .add("preparing authentication parameters...");
      String authResponse = await _iden3commRepository.getAuthResponse(
          did: param.did,
          request: param.message,
          scope: proofs,
          pushUrl: pushUrl,
          pushToken: param.pushToken,
          didIdentifier: didIdentifier,
          packageName: packageName);

      _proofGenerationStepsStreamManager
          .add("preparing authentication token...");
      String authToken = await _getAuthTokenUseCase.execute(
          param: GetAuthTokenParam(
              did: param.did,
              privateKey: param.privateKey,
              message: authResponse));

      _proofGenerationStepsStreamManager.add("authenticating...");
      return _iden3commRepository.authenticate(
        request: param.message,
        authToken: authToken,
      );
    } catch (error) {
      logger().e("[AuthenticateUseCase] Error: $error");

      rethrow;
    }
  }
}
