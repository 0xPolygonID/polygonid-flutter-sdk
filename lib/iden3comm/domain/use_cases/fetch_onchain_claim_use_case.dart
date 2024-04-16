import 'dart:convert';

import 'package:polygonid_flutter_sdk/assets/onchain_non_merkelized_issuer_base.g.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_selected_chain_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/lib_pidcore_credential_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_info_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/remote_iden3comm_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/local_contract_files_data_source.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/atomic_query_inputs_config_param.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class FetchOnchainClaimParam {
  final String profileDid;
  final String issuerDid;
  final String contractAddress;

  final BigInt userId;
  final BigInt credentialId;
  final String adapterVersion;

  final bool skipInterfaceSupportCheck;

  FetchOnchainClaimParam({
    required this.profileDid,
    required this.issuerDid,
    required this.contractAddress,
    required this.userId,
    required this.credentialId,
    required this.adapterVersion,
    this.skipInterfaceSupportCheck = false,
  });
}

class FetchOnchainClaimUseCase
    extends FutureUseCase<FetchOnchainClaimParam, ClaimEntity> {
  final GetSelectedChainUseCase _getSelectedChainUseCase;
  final GetEnvUseCase _getEnvUseCase;
  final LibPolygonIdCoreCredentialDataSource _coreCredentialDataSource;
  final LocalContractFilesDataSource _localContractFilesDataSource;
  final RemoteIden3commDataSource _remoteIden3commDataSource;
  final ClaimMapper _claimMapper;

  final StacktraceManager _stacktraceManager;

  FetchOnchainClaimUseCase(
    this._getSelectedChainUseCase,
    this._getEnvUseCase,
    this._coreCredentialDataSource,
    this._localContractFilesDataSource,
    this._remoteIden3commDataSource,
    this._claimMapper,
    this._stacktraceManager,
  );

  @override
  Future<ClaimEntity> execute({required FetchOnchainClaimParam param}) async {
    final chain = await _getSelectedChainUseCase.execute();
    final env = await _getEnvUseCase.execute();
    final web3Client = getItSdk<Web3Client>(param1: chain.rpcUrl);

    final deployedContract = await _localContractFilesDataSource
        .loadOnchainNonMerkelizedIssuerBaseContract(param.contractAddress);

    final contract = Onchain_non_merkelized_issuer_base(
      address: deployedContract.address,
      client: web3Client,
    );

    if (!param.skipInterfaceSupportCheck) {
      final supportsInterfaceCheck = await contract.supportsInterface(
        hexToBytes(interfaceCheckInterface),
      );

      final supportsNonMerklizedIssuerInterface =
          await contract.supportsInterface(
        hexToBytes(nonMerklizedIssuerInterface),
      );

      if (!supportsInterfaceCheck || !supportsNonMerklizedIssuerInterface) {
        throw Exception(
            "Contract at address ${param.contractAddress} does not support non-merkelized issuer interface");
      }
    }

    final rawCredential = await _fetchRawOnchainCredentialHex(
      web3Client,
      contract,
      param.userId,
      param.credentialId,
    );

    try {
      final rawClaim = _coreCredentialDataSource.w3cCredentialsFromOnchainHex(
        issuerDID: param.issuerDid,
        hexdata: rawCredential,
        version: param.adapterVersion,
        config: ConfigParam.fromEnv(env).toJsonString(),
      );

      final claimJson = jsonDecode(rawClaim);
      final claimInfoDto = ClaimInfoDTO.fromJson(claimJson);

      final claimDto = ClaimDTO(
        id: claimInfoDto.id,
        issuer: claimInfoDto.issuer,
        did: param.profileDid,
        type: claimInfoDto.credentialSubject.type,
        info: claimInfoDto,
        credentialRawValue: jsonEncode({
          "from": param.issuerDid,
          "body": claimJson,
          "type":
              "https://iden3-communication.io/credentials/1.0/onchain-offer",
        }),
      );

      final displayMethod = claimInfoDto.displayMethod;
      final futures = await Future.wait([
        _remoteIden3commDataSource
            .fetchSchema(url: claimInfoDto.credentialSchema.id)
            .then((schema) {
          claimDto.schema = schema;
          return claimDto;
        }).catchError((_) => claimDto),
        if (displayMethod != null)
          _remoteIden3commDataSource
              .fetchDisplayType(url: displayMethod.id)
              .then((displayType) {
            displayType['type'] = displayMethod.type;
            claimDto.displayType = displayType;
            return claimDto;
          }).catchError((_) {
            return claimDto;
          }),
      ]);

      return _claimMapper.mapFrom(claimDto);
    } catch (e) {
      logger().e(
          "[FetchAndSaveClaimsUseCase] Error while fetching onchain claim: $e");
      _stacktraceManager.addTrace(
          "[FetchAndSaveClaimsUseCase] Error while fetching onchain claim: $e");
      rethrow;
    }
  }

  /// Fetches the raw credential from the contract
  /// Returns credential as a raw hex string
  Future<String> _fetchRawOnchainCredentialHex(
    Web3Client web3client,
    Onchain_non_merkelized_issuer_base contract,
    BigInt userId,
    BigInt credentialId,
  ) async {
    final function = contract.self.abi.functions[5];
    final params = [
      userId,
      credentialId,
    ];

    final result = await web3client.callRaw(
      contract: contract.self.address,
      data: function.encodeCall(params),
    );

    return result;
  }
}
