import 'package:polygonid_flutter_sdk/common/data/data_sources/mappers/filters_mapper.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/domain/error_exception.dart';
import 'package:polygonid_flutter_sdk/common/infrastructure/stacktrace_stream_manager.dart';
import 'package:polygonid_flutter_sdk/common/utils/credential_sort_order.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/credential_cache_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/remote_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/storage_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/proof_type.dart';

import 'data_sources/local_claim_data_source.dart';
import 'dtos/claim_info_dto.dart';

class CredentialRepositoryImpl extends CredentialRepository {
  final RemoteClaimDataSource _remoteClaimDataSource;
  final CredentialStorageDataSource _credentialStorageDataSource;
  final LocalClaimDataSource _localClaimDataSource;
  final CredentialCacheDataSource _cacheCredentialDataSource;
  final CredentialMapper _credentialMapper;
  final FiltersMapper _filtersMapper;
  final StacktraceManager _stacktraceManager;

  CredentialRepositoryImpl(
    this._remoteClaimDataSource,
    this._credentialStorageDataSource,
    this._localClaimDataSource,
    this._cacheCredentialDataSource,
    this._credentialMapper,
    this._filtersMapper,
    this._stacktraceManager,
  );

  @override
  Future<void> saveCredentials({
    required List<CredentialEntity> credentials,
    required String genesisDid,
    required String encryptionKey,
  }) async {
    try {
      final List<CredentialDTO> credentialDTOList =
          credentials.map((claim) => _credentialMapper.mapTo(claim)).toList();
      await _credentialStorageDataSource.storeCredentials(
        credentials: credentialDTOList,
        did: genesisDid,
        encryptionKey: encryptionKey,
      );
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      _stacktraceManager
          .addError('Error while saving claims in the DB\n${error.toString()}');
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
      final claimDTOs = await _credentialStorageDataSource.getCredentials(
        filter: filters == null ? null : _filtersMapper.mapTo(filters),
        did: genesisDid,
        encryptionKey: encryptionKey,
        credentialSortOrderList: credentialSortOrderList,
      );

      final List<CredentialEntity> claimEntityList =
          claimDTOs.map((claim) => _credentialMapper.mapFrom(claim)).toList();
      return claimEntityList;
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      _stacktraceManager
          .addError('Error while getting claims from DB\n${error.toString()}');
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
      CredentialDTO claimDTO = await _credentialStorageDataSource.getCredential(
        credentialId: claimId,
        did: genesisDid,
        encryptionKey: encryptionKey,
      );

      CredentialEntity claimEntity = _credentialMapper.mapFrom(claimDTO);
      return claimEntity;
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (e) {
      _stacktraceManager
          .addError('Error while getting claim from DB\n${e.toString()}');
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
      final claimDTOs =
          await _credentialStorageDataSource.getCredentialByPartialId(
        partialId: partialId,
        did: genesisDid,
        encryptionKey: encryptionKey,
      );

      if (claimDTOs.isEmpty || claimDTOs.length > 1) {
        _stacktraceManager
            .addError('Error while getting claim by partial id from DB\n');
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
      await _credentialStorageDataSource.removeCredential(
        credentialIds: claimIds,
        did: genesisDid,
        encryptionKey: encryptionKey,
      );
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      _stacktraceManager
          .addError('Error while removing claims from DB\n${error.toString()}');
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
      await _credentialStorageDataSource.removeAllCredentials(
        did: genesisDid,
        encryptionKey: encryptionKey,
      );
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      _stacktraceManager.addError(
          'Error while removing all claims from DB\n${error.toString()}');
      throw RemoveClaimsException(
        errorMessage:
            'Error while removing all claims from DB\n${error.toString()}',
        error: error,
      );
    }
  }

  @override
  Future<String?> getRhsRevocationId({required CredentialEntity claim}) async {
    CredentialDTO claimDTO = _credentialMapper.mapTo(claim);
    try {
      final signatureProofs = claimDTO.info.proof
          ?.where((proof) => proof.type == ProofType.BJJSignature2021.name)
          .toList();
      return signatureProofs?.firstOrNull?.issuer.id;
    } on PolygonIdSDKException catch (_) {
      rethrow;
    } catch (error) {
      _stacktraceManager
          .addError('Error while getting revocation id\n${error.toString()}');
      throw NullRevocationStatusException(
        claim: claim,
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
    final revStatusUrl = await getRevocationUrl(claim: claim, rhs: false);
    return _remoteClaimDataSource.getClaimRevocationStatus(revStatusUrl);
  }

  @override
  Future<bool> isUsingRHS({required CredentialEntity claim}) async {
    final claimDTO = _credentialMapper.mapTo(claim);
    return claimDTO.info.credentialStatus.type ==
        CredentialStatusType.reverseSparseMerkleTreeProof;
  }

  @override
  Future<int> getRevocationNonce({
    required CredentialEntity claim,
    required bool rhs,
  }) {
    try {
      return Future.value(_credentialMapper.mapTo(claim)).then(
        (claimDTO) => (claimDTO.info.credentialStatus.type ==
                CredentialStatusType.reverseSparseMerkleTreeProof
            ? (rhs
                ? claimDTO.info.credentialStatus.revocationNonce!
                : claimDTO.info.credentialStatus.statusIssuer!.revocationNonce!)
            : (rhs == false
                ? claimDTO.info.credentialStatus.revocationNonce!
                : throw NullRevocationStatusException(
                    claim: claim,
                    errorMessage: 'Revocation nonce not found',
                  ))),
      );
    } catch (error) {
      _stacktraceManager.addError(
          'Error while getting revocation nonce\n${error.toString()}');
      throw NullRevocationStatusException(
        claim: claim,
        errorMessage: 'error while getting revocation nonce',
      );
    }
  }

  @override
  Future<String> getRevocationUrl({
    required CredentialEntity claim,
    required bool rhs,
  }) async {
    final credentialDTO = _credentialMapper.mapTo(claim);
    final type = credentialDTO.info.credentialStatus.type;
    if (type == CredentialStatusType.reverseSparseMerkleTreeProof) {
      if (rhs) {
        return credentialDTO.info.credentialStatus.id;
      } else {
        return credentialDTO.info.credentialStatus.statusIssuer!.id;
      }
    } else if (rhs == false) {
      return credentialDTO.info.credentialStatus.id;
    } else {
      _stacktraceManager.addError(
          'Error while getting revocation url\nRevocation url not found');
      throw NullRevocationStatusException(
        claim: claim,
        errorMessage: 'Revocation url not found',
      );
    }
  }

  @override
  Future<List<String>> getAuthClaim({required List<String> publicKey}) async {
    return _localClaimDataSource.getAuthClaim(publicKey: publicKey);
  }

  @override
  Future<bool> cacheCredential({
    required String credential,
    String? config,
  }) {
    return _cacheCredentialDataSource.cacheCredential(
      credential: credential,
      config: config,
    );
  }

  @override
  void cleanCache({
    String? config,
  }) {
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
