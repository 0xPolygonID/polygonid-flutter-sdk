import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/assets/onchain_non_merkelized_issuer_base.g.dart';
import 'package:polygonid_flutter_sdk/assets/get_issuer_id_interface.g.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/chain_config_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_selected_chain_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/lib_pidcore_credential_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_state_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/use_cases/cache_credential_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/base.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/onchain_offer_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/did_profile_info_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/iden3comm_credential_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/interaction_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/check_profile_and_did_current_env.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/fetch_onchain_claim_use_case.dart';
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
import 'package:polygonid_flutter_sdk/identity/domain/use_cases/get_did_use_case.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/atomic_query_inputs_config_param.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class FetchOnchainClaimsParam {
  final String contractAddress;
  final String genesisDid;
  final BigInt profileNonce;
  final String privateKey;

  FetchOnchainClaimsParam({
    required this.contractAddress,
    required this.genesisDid,
    required this.profileNonce,
    required this.privateKey,
  });
}

class FetchOnchainClaimsUseCase
    extends FutureUseCase<FetchOnchainClaimsParam, List<ClaimEntity>> {
  final FetchOnchainClaimUseCase _fetchOnchainClaimUseCase;
  final CheckProfileAndDidCurrentEnvUseCase
      _checkProfileAndDidCurrentEnvUseCase;
  final GetEnvUseCase _getEnvUseCase;
  final GetSelectedChainUseCase _getSelectedChainUseCase;
  final GetDidIdentifierUseCase _getDidIdentifierUseCase;
  final GetDidUseCase _getDidUseCase;
  final SaveClaimsUseCase _saveClaimsUseCase;
  final CacheCredentialUseCase _cacheCredentialUseCase;
  final LocalContractFilesDataSource _localContractFilesDataSource;
  final IdentityRepository _identityRepository;
  final DidProfileInfoRepository _didProfileInfoRepository;
  final StacktraceManager _stacktraceManager;

  FetchOnchainClaimsUseCase(
    this._fetchOnchainClaimUseCase,
    this._checkProfileAndDidCurrentEnvUseCase,
    this._getEnvUseCase,
    this._getSelectedChainUseCase,
    this._getDidIdentifierUseCase,
    this._getDidUseCase,
    this._saveClaimsUseCase,
    this._cacheCredentialUseCase,
    this._localContractFilesDataSource,
    this._identityRepository,
    this._didProfileInfoRepository,
    this._stacktraceManager,
  );

  @override
  Future<List<ClaimEntity>> execute({
    required FetchOnchainClaimsParam param,
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
          profileNonce: param.profileNonce,
        ),
      );

      final env = await _getEnvUseCase.execute();
      final chain = await _getSelectedChainUseCase.execute();

      final profileDid = await _getDidIdentifierUseCase.execute(
        param: GetDidIdentifierParam(
          privateKey: param.privateKey,
          blockchain: chain.blockchain,
          network: chain.network,
          profileNonce: param.profileNonce,
        ),
      );

      final claims = await _fetchOnchainClaims(
        param.contractAddress,
        profileDid,
        param,
      );

      return claims;
    } catch (error) {
      logger().e("[FetchAndSaveClaimsUseCase] Error: $error");
      _stacktraceManager.addTrace("[FetchAndSaveClaimsUseCase] Error: $error");
      _stacktraceManager.addError("[FetchAndSaveClaimsUseCase] Error: $error");
      rethrow;
    }
  }

  Future<List<ClaimEntity>> _fetchOnchainClaims(
    String contractAddress,
    String profileDid,
    FetchOnchainClaimsParam param,
  ) async {
    final chain = await _getSelectedChainUseCase.execute();
    final env = await _getEnvUseCase.execute();

    final web3Client = getItSdk<Web3Client>(param1: chain.rpcUrl);
    final deployedContract = await _localContractFilesDataSource
        .loadOnchainNonMerkelizedIssuerBaseContract(contractAddress);

    final issuer = Onchain_non_merkelized_issuer_base(
      address: deployedContract.address,
      client: web3Client,
    );
    final getIssuerId = Get_issuer_id_interface(
      address: deployedContract.address,
      client: web3Client,
    );

    final supportsInterfaceCheck = await issuer.supportsInterface(
      hexToBytes(interfaceCheckInterface),
    );
    final supportsNonMerklizedIssuerInterface = await issuer.supportsInterface(
      hexToBytes(nonMerklizedIssuerInterface),
    );

    final supportsGetIssuerIdInterface = await issuer.supportsInterface(
      hexToBytes(getIssuerIdInterface),
    );

    if (!supportsInterfaceCheck ||
        !supportsNonMerklizedIssuerInterface ||
        !supportsGetIssuerIdInterface) {
      throw Exception(
          "Contract at address $contractAddress does not support non-merkelized issuer interface");
    }

    final issuerIdInt = await getIssuerId.getId();
    final issuerDid = (await _identityRepository.describeId(
      id: issuerIdInt,
      config: ConfigParam.fromEnv(env),
    ))
        .did;

    final info =
        await _didProfileInfoRepository.getDidProfileInfoByInteractedWithDid(
      interactedWithDid: issuerDid,
      genesisDid: param.genesisDid,
      privateKey: param.privateKey,
    );

    BigInt nonce;
    if (info.containsKey("privateProfileNonce")) {
      nonce = BigInt.parse(info["privateProfileNonce"] as String);
    } else {
      nonce = GENESIS_PROFILE_NONCE;
    }

    final did = await _getDidIdentifierUseCase.execute(
      param: GetDidIdentifierParam(
        privateKey: param.privateKey,
        blockchain: chain.blockchain,
        network: chain.network,
        profileNonce: nonce,
      ),
    );

    final didEntity = await _getDidUseCase.execute(param: did);
    final userId =
        await _identityRepository.convertIdToBigInt(id: didEntity.identifier);

    final adapterVersion = await issuer.getCredentialAdapterVersion();

    final credentialIds =
        await issuer.getUserCredentialIds(BigInt.parse(userId));

    final claims = <ClaimEntity>[];
    for (final credentialId in credentialIds) {
      try {
        final claim = await _fetchOnchainClaimUseCase.execute(
          param: FetchOnchainClaimParam(
            profileDid: profileDid,
            issuerDid: issuerDid,
            contractAddress: contractAddress,
            userId: BigInt.parse(userId),
            credentialId: credentialId,
            adapterVersion: adapterVersion,
            skipInterfaceSupportCheck: true,
          ),
        );

        claims.add(claim);
      } catch (e) {
        logger().e(
            "[FetchAndSaveClaimsUseCase] Error while fetching onchain claim: $e");
        _stacktraceManager.addTrace(
            "[FetchAndSaveClaimsUseCase] Error while fetching onchain claim: $e");
        rethrow;
      }
    }

    return claims;
  }
}
