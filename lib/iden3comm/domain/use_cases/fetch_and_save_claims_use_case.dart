import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
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
  final GetDidIdentifierUseCase _getDidIdentifierUseCase;
  final GetFetchRequestsUseCase _getFetchRequestsUseCase;
  final GetAuthTokenUseCase _getAuthTokenUseCase;
  final SaveClaimsUseCase _saveClaimsUseCase;
  final GetClaimRevocationStatusUseCase _getClaimRevocationStatusUseCase;
  final StacktraceManager _stacktraceManager;

  FetchAndSaveClaimsUseCase(
    this._iden3commCredentialRepository,
    this._checkProfileAndDidCurrentEnvUseCase,
    this._getEnvUseCase,
    this._getDidIdentifierUseCase,
    this._getFetchRequestsUseCase,
    this._getAuthTokenUseCase,
    this._saveClaimsUseCase,
    this._getClaimRevocationStatusUseCase,
    this._stacktraceManager,
  );

  @override
  Future<List<ClaimEntity>> execute(
      {required FetchAndSaveClaimsParam param}) async {
    /// Get the corresponding fetch request from [OfferIden3MessageEntity]
    /// For each, get the auth token
    /// With the auth token, fetch the [ClaimEntity]
    /// Then save the list of [ClaimEntity]
    ///

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

    return _getFetchRequestsUseCase
        .execute(param: GetFetchRequestsParam(param.message, profileDid))
        .then((requests) async {
          List<ClaimEntity> claims = [];

          for (String request in requests) {
            await _getAuthTokenUseCase
                .execute(
                    param: GetAuthTokenParam(
                  genesisDid: param.genesisDid,
                  profileNonce: param.profileNonce,
                  privateKey: param.privateKey,
                  message: request,
                ))
                .then((authToken) => _iden3commCredentialRepository.fetchClaim(
                    did: profileDid,
                    authToken: authToken,
                    url: param.message.body.url))
                .then((claim) async {
              Map<String, dynamic> revStatus =
                  await _getClaimRevocationStatusUseCase
                      .execute(
                          param: GetClaimRevocationStatusParam(claim: claim))
                      .catchError((_) => <String, dynamic>{});

              /// FIXME: define an entity for revocation and use it in repo impl
              if (revStatus.isNotEmpty &&
                  revStatus["mtp"] != null &&
                  revStatus["mtp"]["existence"] != null &&
                  revStatus["mtp"]["existence"] == true) {
                claim = ClaimEntity(
                  id: claim.id,
                  issuer: claim.issuer,
                  did: claim.did,
                  state: ClaimState.revoked,
                  expiration: claim.expiration,
                  schema: claim.schema,
                  type: claim.type,
                  info: claim.info,
                );
              }
              claims.add(claim);
            });
          }

          return claims;
        })
        // TODO profileDid
        .then((claims) => _saveClaimsUseCase
                .execute(
                    param: SaveClaimsParam(
              claims: claims,
              genesisDid: param.genesisDid,
              privateKey: param.privateKey,
            ))
                .then((_) {
              logger().i(
                  "[FetchAndSaveClaimsUseCase] All claims have been saved: $claims");
              _stacktraceManager.addTrace(
                  "[FetchAndSaveClaimsUseCase] All claims have been saved: claimsLength ${claims.length}");
              return claims;
            }))
        .catchError((error) {
          logger().e("[FetchAndSaveClaimsUseCase] Error: $error");
          _stacktraceManager
              .addTrace("[FetchAndSaveClaimsUseCase] Error: $error");
          _stacktraceManager
              .addError("[FetchAndSaveClaimsUseCase] Error: $error");
          throw error;
        });
  }
}
