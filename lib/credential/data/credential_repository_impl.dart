import 'package:polygonid_flutter_sdk/assets/onchain_non_merkelized_issuer_base.g.dart';
import 'package:polygonid_flutter_sdk/common/data/data_sources/mappers/filters_mapper.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/domain/use_cases/get_env_use_case.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/utils/credential_sort_order.dart';
import 'package:polygonid_flutter_sdk/common/utils/credential_status_url_parser.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/credential_cache_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/remote_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/storage_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/local_contract_files_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/proof_type.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/sdk/di/injector.dart';
import 'package:web3dart/web3dart.dart';

import 'data_sources/local_claim_data_source.dart';
import 'dtos/claim_info_dto.dart';

class CredentialRepositoryImpl extends CredentialRepository {
  final RemoteClaimDataSource _remoteClaimDataSource;
  final CredentialStorageDataSource _credentialStorageDS;
  final LocalClaimDataSource _localClaimDataSource;
  final CredentialCacheDataSource _cacheCredentialDataSource;
  final CredentialMapper _credentialMapper;
  final FiltersMapper _filtersMapper;
  final GetEnvUseCase _getEnvUseCase;
  final LocalContractFilesDataSource _localContractFilesDataSource;
  final IdentityRepository _identityRepository;
  final StacktraceManager _stacktraceManager;

  CredentialRepositoryImpl(
    this._remoteClaimDataSource,
    this._credentialStorageDS,
    this._localClaimDataSource,
    this._cacheCredentialDataSource,
    this._credentialMapper,
    this._filtersMapper,
    this._getEnvUseCase,
    this._localContractFilesDataSource,
    this._identityRepository,
    this._stacktraceManager,
  );

  @override
  Future<void> saveCredentials({
    required List<CredentialEntity> credentials,
    required String genesisDid,
    required String encryptionKey,
  }) async {
    try {
      final credentialDTOList = credentials
          .map((claim) => _credentialMapper.mapTo(claim))
          .toList();
      await _credentialStorageDS.storeCredentials(
        credentials: credentialDTOList,
        did: genesisDid,
        encryptionKey: encryptionKey,
      );
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      _stacktraceManager.addError(
        'Error while saving claims in the DB\n${error.toString()}',
      );
      throw SaveClaimException(
        errorMessage:
            'Error while saving claims in the DB\n${error.toString()}',
        error: error,
      );
    }
  }

  @override
  Future<List<CredentialEntity>> getCredentials({
    List<FilterEntity>? filters,
    required String genesisDid,
    required String encryptionKey,
    List<CredentialSortOrder> credentialSortOrderList = const [],
  }) async {
    try {
      final claimDTOs = await _credentialStorageDS.getCredentials(
        filter: filters == null ? null : _filtersMapper.mapTo(filters),
        did: genesisDid,
        encryptionKey: encryptionKey,
        credentialSortOrderList: credentialSortOrderList,
      );

      final claimEntityList = claimDTOs
          .map((claim) => _credentialMapper.mapFrom(claim))
          .toList();
      return claimEntityList;
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      _stacktraceManager.addError(
        'Error while getting claims from DB\n${error.toString()}',
      );
      throw GetClaimsException(
        errorMessage: "Error while getting claims from DB\n${error.toString()}",
        error: error,
      );
    }
  }

  @override
  Future<CredentialEntity> getCredential({
    required String claimId,
    required String genesisDid,
    required String encryptionKey,
  }) async {
    try {
      CredentialDTO claimDTO = await _credentialStorageDS.getCredential(
        credentialId: claimId,
        did: genesisDid,
        encryptionKey: encryptionKey,
      );

      CredentialEntity claimEntity = _credentialMapper.mapFrom(claimDTO);
      return claimEntity;
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (e) {
      _stacktraceManager.addError(
        'Error while getting claim from DB\n${e.toString()}',
      );
      throw CredentialNotFoundException(
        id: claimId,
        errorMessage: 'Credential not found',
      );
    }
  }

  @override
  Future<CredentialEntity> getCredentialByPartialId({
    required String partialId,
    required String genesisDid,
    required String encryptionKey,
  }) async {
    try {
      final claimDTOs = await _credentialStorageDS.getCredentialByPartialId(
        partialId: partialId,
        did: genesisDid,
        encryptionKey: encryptionKey,
      );

      if (claimDTOs.isEmpty || claimDTOs.length > 1) {
        _stacktraceManager.addError(
          'Error while getting claim by partial id from DB\n',
        );
        throw CredentialNotFoundException(
          id: partialId,
          errorMessage: 'Credential by partial id not found',
        );
      }

      CredentialEntity claimEntity = _credentialMapper.mapFrom(claimDTOs.first);
      return claimEntity;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeCredentials({
    required List<String> claimIds,
    required String genesisDid,
    required String encryptionKey,
  }) async {
    try {
      await _credentialStorageDS.removeCredential(
        credentialIds: claimIds,
        did: genesisDid,
        encryptionKey: encryptionKey,
      );
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      _stacktraceManager.addError(
        'Error while removing claims from DB\n${error.toString()}',
      );
      throw RemoveClaimsException(
        errorMessage:
            'Error while removing claims from DB\n${error.toString()}',
        error: error,
      );
    }
  }

  @override
  Future<void> removeAllCredentials({
    required String genesisDid,
    required String encryptionKey,
  }) async {
    try {
      await _credentialStorageDS.removeAllCredentials(
        did: genesisDid,
        encryptionKey: encryptionKey,
      );
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      _stacktraceManager.addError(
        'Error while removing all claims from DB\n${error.toString()}',
      );
      throw RemoveClaimsException(
        errorMessage:
            'Error while removing all claims from DB\n${error.toString()}',
        error: error,
      );
    }
  }

  @override
  Future<String?> getRhsRevocationId({required CredentialEntity claim}) async {
    final credential = _credentialMapper.mapTo(claim);
    try {
      final signatureProofs = credential.info.proof
          ?.where((proof) => proof.type == ProofType.BJJSignature2021.name)
          .toList();
      return signatureProofs?.firstOrNull?.issuer.id;
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      _stacktraceManager.addError(
        'Error while getting revocation id\n${error.toString()}',
      );
      throw NullRevocationStatusException(
        credential: credential,
        errorMessage: 'error while getting revocation id',
      );
    }
  }

  @override
  Future<String> getIssuerIdentifier({required CredentialEntity claim}) async {
    return _credentialMapper.mapTo(claim).info.issuer;
  }

  @override
  Future<Map<String, dynamic>> getRevocationStatus({
    required CredentialEntity claim,
  }) async {
    final credential = _credentialMapper.mapTo(claim);

    if (credential.info.credentialStatus.type.onchain) {
      return _getOnchainRevocationStatus(credential: credential);
    }

    final revStatusUrl = await getRevocationUrl(credential: credential);
    return _remoteClaimDataSource.getClaimRevocationStatus(revStatusUrl);
  }

  Future<Map<String, dynamic>> _getOnchainRevocationStatus({
    required CredentialDTO credential,
  }) async {
    final env = await _getEnvUseCase.execute();

    final status = credential.info.credentialStatus;
    final id = CredentialStatusUrlParser.parse(status.id);

    final issuerId = await _identityRepository.convertIdToBigInt(
      id: id.identifier,
    );

    final chain = env.chainConfigs[id.contractChainId];

    final web3Client = getItSdk<Web3Client>(param1: chain!.rpcUrl);

    final deployedContract = _localContractFilesDataSource
        .loadOnchainIssuerContract(id.contractAddress!);

    final abi = Onchain_non_merkelized_issuer_base(
      address: deployedContract.address,
      client: web3Client,
    );

    final BigInt revocationNonce;
    if (status.revocationNonce != null) {
      revocationNonce = BigInt.from(status.revocationNonce!);
    } else if (id.revocationNonce != null) {
      revocationNonce = id.revocationNonce!;
    } else {
      _stacktraceManager.addError(
        'Error while getting revocation url\nRevocation nonce not found',
      );
      throw NullRevocationStatusException(
        credential: credential,
        errorMessage: 'Revocation nonce not found',
      );
    }

    dynamic revocationStatusRaw;

    final state = id.state;
    if (state == null) {
      revocationStatusRaw = await abi.getRevocationStatus((
        id: BigInt.parse(issuerId),
        nonce: revocationNonce,
      ));
    } else {
      revocationStatusRaw = await abi.getRevocationStatusByIdAndState((
        id: BigInt.parse(issuerId),
        nonce: revocationNonce,
        state: state,
      ));
    }

    final issuer = revocationStatusRaw[0] as List;
    final mtp = revocationStatusRaw[1] as List;

    final List<BigInt> siblings = (mtp[2] as List<dynamic>)
        .map((e) => e as BigInt)
        .toList();

    final revocationStatus = {
      'issuer': {
        'state': issuer[0] as BigInt,
        'claimsTreeRoot': issuer[1] as BigInt,
        'revocationTreeRoot': issuer[2] as BigInt,
        'rootOfRoots': issuer[3] as BigInt,
      },
      'mtp': {
        'root': mtp[0] as BigInt,
        'existence': mtp[1] as bool,
        'siblings': siblings,
        'index': mtp[3] as BigInt,
        'value': mtp[4] as BigInt,
        'auxExistence': mtp[5] as bool,
        'auxIndex': mtp[6] as BigInt,
        'auxValue': mtp[7] as BigInt,
      },
    };

    return revocationStatus;
  }

  @override
  Future<int> getRevocationNonce({required CredentialDTO credential}) async {
    try {
      final status = credential.info.credentialStatus;

      final nonce =
          status.revocationNonce ?? status.statusIssuer?.revocationNonce;
      if (nonce != null) {
        return nonce;
      }

      throw NullRevocationStatusException(
        credential: credential,
        errorMessage: 'Revocation nonce not found',
      );
    } catch (error) {
      _stacktraceManager.addError(
        'Error while getting revocation nonce\n$error',
      );
      if (error is PolygonIdSDKException) rethrow;
      throw NullRevocationStatusException(
        credential: credential,
        errorMessage: 'Error while getting revocation nonce',
        error: error,
      );
    }
  }

  @override
  Future<String> getRevocationUrl({required CredentialDTO credential}) async {
    final rhs = credential.info.credentialStatus.type.useRHS;

    final type = credential.info.credentialStatus.type;
    if (type == CredentialStatusType.reverseSparseMerkleTreeProof) {
      if (rhs) {
        return credential.info.credentialStatus.id;
      } else {
        return credential.info.credentialStatus.statusIssuer!.id;
      }
    } else if (rhs == false) {
      return credential.info.credentialStatus.id;
    } else {
      _stacktraceManager.addError(
        'Error while getting revocation url\nRevocation url not found',
      );
      throw NullRevocationStatusException(
        credential: credential,
        errorMessage: 'Revocation url not found',
      );
    }
  }

  @override
  List<String> getAuthClaim({required List<String> publicKey}) {
    return _localClaimDataSource.getAuthClaim(publicKey: publicKey);
  }

  @override
  Future<bool> cacheCredential({required String credential, String? config}) {
    return _cacheCredentialDataSource.cacheCredential(
      credential: credential,
      config: config,
    );
  }

  @override
  void cleanCache({String? config}) {
    _cacheCredentialDataSource.cleanCache(config);
  }

  @override
  Future<String> coreClaimFromCredential({
    required String credential,
    String? config,
  }) {
    return _localClaimDataSource.coreClaimFromCredential(
      credential: credential,
      config: config,
    );
  }
}
