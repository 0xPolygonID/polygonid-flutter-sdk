import 'dart:convert';
import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/assets/onchain_non_merkelized_issuer_base.g.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_selected_chain_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/lib_pidcore_credential_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/cache_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/base.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/onchain_offer_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_credential_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/local_contract_files_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/state_identifier_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_identifier_use_case.dart';

import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/get_claim_revocation_status_use_case.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/save_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/offer_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_auth_token_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_fetch_requests_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/atomic_query_inputs_config_param.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class FetchAndSaveClaimsParam {
  final CredentialOfferMessageEntity message;
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
  final LocalContractFilesDataSource _localContractFilesDataSource;
  final IdentityRepository _identityRepository;
  final StateIdentifierMapper _stateIdentifierMapper;
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
    this._localContractFilesDataSource,
    this._identityRepository,
    this._stateIdentifierMapper,
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

      final List<ClaimEntity> claims;

      final message = param.message;
      if (message is OfferIden3MessageEntity) {
        claims = await _fetchClaims(message, param, profileDid);
      } else if (message is OnchainOfferIden3MessageEntity) {
        claims = await _fetchOnchainClaims(message, profileDid);
      } else {
        throw Exception("Unknown message type: ${message.runtimeType}");
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

      final config = ConfigParam(
        ipfsNodeURL: env.ipfsUrl,
        chainConfigs: env.chainConfigs,
        didMethods: env.didMethods,
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

  Future<List<ClaimEntity>> _fetchClaims(
    OfferIden3MessageEntity message,
    FetchAndSaveClaimsParam param,
    String profileDid,
  ) async {
    final requests = await _getFetchRequestsUseCase.execute(
      param: GetFetchRequestsParam(
        message,
        profileDid,
      ),
    );

    final claims = <ClaimEntity>[];
    for (final request in requests) {
      final authToken = await _getAuthTokenUseCase.execute(
        param: GetAuthTokenParam(
          genesisDid: param.genesisDid,
          profileNonce: param.profileNonce,
          privateKey: param.privateKey,
          message: request,
        ),
      );

      final claimEntity = await _iden3commCredentialRepository.fetchClaim(
        did: profileDid,
        authToken: authToken,
        url: message.body.url,
      );

      claims.add(claimEntity);
    }
    return claims;
  }

  Future<List<ClaimEntity>> _fetchOnchainClaims(
    OnchainOfferIden3MessageEntity message,
    String profileDid,
  ) async {
    final chain = await _getSelectedChainUseCase.execute();
    final env = await _getEnvUseCase.execute();

    /// FIXME: inject web3Client through constructor
    final web3Client = getItSdk<Web3Client>(param1: chain.rpcUrl);

    final address = message.body.transactionData.contractAddress;
    final deployedContract = await _localContractFilesDataSource
        .loadOnchainNonMerkelizedIssuerBaseContract(address);

    final issuer = Onchain_non_merkelized_issuer_base(
      address: deployedContract.address,
      client: web3Client,
    );

    final interface = hexToBytes(nonMerklizedIssuerInterface);

    final supportsNonMerklizedIssuerInterface =
        await issuer.supportsInterface(interface);

    if (!supportsNonMerklizedIssuerInterface) {
      throw Exception(
          "Contract at address $address does not support non-merkelized issuer interface");
    }

    final id = await _getId(chain.stateContractAddr, profileDid);
    final adapterVersion = await issuer.getCredentialAdapterVersion();

    // TODO (moria): Add a lot of layers on top of this or inject in constructor
    final credDataSource = getItSdk<LibPolygonIdCoreCredentialDataSource>();

    final claims = <ClaimEntity>[];
    for (final credential in message.body.credentials) {
      final credentialId = BigInt.parse(credential.id);

      final rawCredential = await _fetchRawCredential(
        web3Client,
        issuer,
        id,
        credentialId,
      );

      try {
        final rawClaim = credDataSource.w3cCredentialsFromOnchainHex(
          issuerDID: message.from,
          hexdata: rawCredential,
          version: adapterVersion,
          config: ConfigParam(
            ipfsNodeURL: env.ipfsUrl,
            chainConfigs: env.chainConfigs,
            didMethods: env.didMethods,
          ).toJsonString(),
        );

        if (rawClaim != null) {
          final onchainClaim = ClaimEntity.fromJson(jsonDecode(rawClaim));

          claims.add(onchainClaim);
        }
      } catch (e) {
        logger().e(
            "[FetchAndSaveClaimsUseCase] Error while fetching onchain claim: $e");
        _stacktraceManager.addTrace(
            "[FetchAndSaveClaimsUseCase] Error while fetching onchain claim: $e");
      }
    }

    return claims;
  }

  Future<BigInt> _getId(String stateContractAddress, String profileDid) async {
    final id = await _identityRepository.convertIdToBigInt(id: profileDid);
    final state = await _identityRepository.getState(
        identifier: id, contractAddress: stateContractAddress);
    final stateMapped = _stateIdentifierMapper.mapTo(state);

    return Uint8ArrayUtils.leBuff2int(hexToBytes(id));
  }

  /// Fetches the raw credential from the contract
  /// Returns credential as a raw hex string
  Future<String> _fetchRawCredential(
    Web3Client web3client,
    Onchain_non_merkelized_issuer_base contract,
    BigInt id,
    BigInt credentialId,
  ) async {
    final function = contract.self.abi.functions[5];
    final params = [
      id,
      credentialId,
    ];

    final result = await web3client.callRaw(
      contract: contract.self.address,
      data: function.encodeCall(params),
    );

    return result;
  }
}
