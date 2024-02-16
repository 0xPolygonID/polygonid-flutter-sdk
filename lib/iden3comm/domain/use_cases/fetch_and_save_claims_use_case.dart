import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_selected_chain_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/cache_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_credential_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';

import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claim_revocation_status_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/save_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/offer_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_token_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_fetch_requests_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/atomic_query_inputs_config_param.dart';

class FetchAndSaveClaimsParam {
  final OfferIden3MessageEntity message;
  final String genesisDid;
  final BigInt profileNonce;
  final String privateKey;

  FetchAndSaveClaimsParam({
    required this.message,
    required this.genesisDid,
    required this.profileNonce,
    required this.privateKey,
  });
}

class FetchAndSaveClaimsUseCase
    extends FutureUseCase<FetchAndSaveClaimsParam, List<ClaimEntity>> {
  final Iden3commCredentialRepository _iden3commCredentialRepository;
  final CheckProfileAndDidCurrentEnvUseCase
      _checkProfileAndDidCurrentEnvUseCase;
  final GetEnvUseCase _getEnvUseCase;
  final GetSelectedChainUseCase _getSelectedChainUseCase;
  final GetDidIdentifierUseCase _getDidIdentifierUseCase;
  final GetFetchRequestsUseCase _getFetchRequestsUseCase;
  final GetAuthTokenUseCase _getAuthTokenUseCase;
  final SaveClaimsUseCase _saveClaimsUseCase;
  final GetClaimRevocationStatusUseCase _getClaimRevocationStatusUseCase;
  final CacheCredentialUseCase _cacheCredentialUseCase;
  final StacktraceManager _stacktraceManager;

  FetchAndSaveClaimsUseCase(
    this._iden3commCredentialRepository,
    this._checkProfileAndDidCurrentEnvUseCase,
    this._getEnvUseCase,
    this._getSelectedChainUseCase,
    this._getDidIdentifierUseCase,
    this._getFetchRequestsUseCase,
    this._getAuthTokenUseCase,
    this._saveClaimsUseCase,
    this._getClaimRevocationStatusUseCase,
    this._cacheCredentialUseCase,
    this._stacktraceManager,
  );

  @override
  Future<List<ClaimEntity>> execute({
    required FetchAndSaveClaimsParam param,
  }) async {
    /// Get the corresponding fetch request from [OfferIden3MessageEntity]
    /// For each, get the auth token
    /// With the auth token, fetch the [ClaimEntity]
    /// Then save the list of [ClaimEntity]

    try {
      await _checkProfileAndDidCurrentEnvUseCase.execute(
          param: CheckProfileAndDidCurrentEnvParam(
              did: param.genesisDid,
              privateKey: param.privateKey,
              profileNonce: param.profileNonce));

      final env = await _getEnvUseCase.execute();
      final chain = await _getSelectedChainUseCase.execute();

      String profileDid = await _getDidIdentifierUseCase.execute(
          param: GetDidIdentifierParam(
              privateKey: param.privateKey,
              blockchain: chain.blockchain,
              network: chain.network,
              profileNonce: param.profileNonce));

      final List<String> requests = await _getFetchRequestsUseCase.execute(
          param: GetFetchRequestsParam(
        param.message,
        profileDid,
      ));

      List<ClaimEntity> claims = [];
      for (String request in requests) {
        final String authToken = await _getAuthTokenUseCase.execute(
            param: GetAuthTokenParam(
          genesisDid: param.genesisDid,
          profileNonce: param.profileNonce,
          privateKey: param.privateKey,
          message: request,
        ));

        ClaimEntity claimEntity =
            await _iden3commCredentialRepository.fetchClaim(
                did: profileDid,
                authToken: authToken,
                url: param.message.body.url);

        claims.add(claimEntity);
      }

      await _saveClaimsUseCase.execute(
          param: SaveClaimsParam(
        claims: claims,
        genesisDid: param.genesisDid,
        privateKey: param.privateKey,
      ));

      logger()
          .i("[FetchAndSaveClaimsUseCase] All claims have been saved: $claims");
      _stacktraceManager.addTrace(
          "[FetchAndSaveClaimsUseCase] All claims have been saved: claimsLength ${claims.length}");

      final config = AtomicQueryInputsConfigParam(
        ipfsNodeURL: env.ipfsUrl,
        chainConfigs: env.chainConfigs,
      );

      for (final claim in claims) {
        // cache claim
        try {
          await _cacheCredentialUseCase.execute(
            param: CacheCredentialParam(
              credential: jsonEncode(
                {
                  "verifiableCredentials": claim.toJson(),
                },
              ),
              config: jsonEncode(config.toJson()),
            ),
          );
        } catch (e) {
          logger()
              .e("[FetchAndSaveClaimsUseCase] Error while caching claim: $e");
          _stacktraceManager.addTrace(
              "[FetchAndSaveClaimsUseCase] Error while caching claim: $e");
        }
      }

      return claims;
    } catch (error) {
      logger().e("[FetchAndSaveClaimsUseCase] Error: $error");
      _stacktraceManager.addTrace("[FetchAndSaveClaimsUseCase] Error: $error");
      _stacktraceManager.addError("[FetchAndSaveClaimsUseCase] Error: $error");
      rethrow;
    }
  }
}
