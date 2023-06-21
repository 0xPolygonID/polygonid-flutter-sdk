import 'dart:async';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_package_name_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/auth_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_token_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_current_env_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/infrastructure/proof_generation_stream_manager.dart';

class AuthenticateParam {
  final AuthIden3MessageEntity message;
  final String genesisDid;
  final BigInt profileNonce;
  final String privateKey;
  final String? pushToken;
  final Map<int, Map<String, dynamic>>? nonRevocationProofs;

  AuthenticateParam(
      {required this.message,
      required this.genesisDid,
      required this.profileNonce,
      required this.privateKey,
      this.pushToken,
      this.nonRevocationProofs});
}

class AuthenticateUseCase extends FutureUseCase<AuthenticateParam, void> {
  final Iden3commRepository _iden3commRepository;
  final GetAuthTokenUseCase _getAuthTokenUseCase;
  final GetIden3commProofsUseCase _getIden3commProofsUseCase;
  final GetDidIdentifierUseCase _getDidIdentifierUseCase;
  final GetEnvUseCase _getEnvUseCase;
  final GetPackageNameUseCase _getPackageNameUseCase;
  final CheckProfileAndDidCurrentEnvUseCase
      _checkProfileAndDidCurrentEnvUseCase;
  final ProofGenerationStepsStreamManager _proofGenerationStepsStreamManager;

  AuthenticateUseCase(
    this._iden3commRepository,
    this._getIden3commProofsUseCase,
    this._getDidIdentifierUseCase,
    this._getAuthTokenUseCase,
    this._getEnvUseCase,
    this._getPackageNameUseCase,
    this._checkProfileAndDidCurrentEnvUseCase,
    this._proofGenerationStepsStreamManager,
  );

  @override
  Future<void> execute({required AuthenticateParam param}) async {
    try {
      await _checkProfileAndDidCurrentEnvUseCase.execute(
          param: CheckProfileAndDidCurrentEnvParam(
              did: param.genesisDid,
              privateKey: param.privateKey,
              profileNonce: param.profileNonce));

      EnvEntity env = await _getEnvUseCase.execute();

      String profileDid = await _getDidIdentifierUseCase.execute(
          param: GetDidIdentifierParam(
              privateKey: param.privateKey,
              blockchain: env.blockchain,
              network: env.network,
              profileNonce: param.profileNonce));

      // get proofs from credentials of all the profiles of the identity
      List<JWZProofEntity> proofs = await _getIden3commProofsUseCase.execute(
          param: GetIden3commProofsParam(
        message: param.message,
        genesisDid: param.genesisDid,
        profileNonce: param.profileNonce,
        privateKey: param.privateKey,
        ethereumUrl: env.web3Url + env.web3ApiKey,
        stateContractAddr: env.idStateContract,
        nonRevocationProofs: param.nonRevocationProofs,
      ));

      String pushUrl = env.pushUrl;

      String packageName = await _getPackageNameUseCase.execute();

      _proofGenerationStepsStreamManager
          .add("preparing authentication parameters...");
      String authResponse = await _iden3commRepository.getAuthResponse(
          did: profileDid,
          request: param.message,
          scope: proofs,
          pushUrl: pushUrl,
          pushToken: param.pushToken,
          packageName: packageName);

      _proofGenerationStepsStreamManager
          .add("preparing authentication token...");
      String authToken = await _getAuthTokenUseCase.execute(
          param: GetAuthTokenParam(
              genesisDid: param.genesisDid,
              profileNonce: param.profileNonce,
              privateKey: param.privateKey,
              message: authResponse));

      _proofGenerationStepsStreamManager.add("authenticating...");
      return _iden3commRepository.authenticate(
        request: param.message,
        authToken: authToken,
      );
    } catch (error) {
      logger().d("[AuthenticateUseCase] Error: $error");

      rethrow;
    }
  }
}
