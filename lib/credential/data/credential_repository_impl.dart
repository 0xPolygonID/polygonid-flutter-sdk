import 'package:polygonid_flutter_sdk/common/data/data_sources/mappers/filters_mapper.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/remote_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/storage_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_proofs/claim_proof_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/id_filter_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/revocation_status_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/credential/request/offer_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/db_destination_path_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/encryption_db_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/encryption_key_mapper.dart';

import 'data_sources/local_claim_data_source.dart';
import 'dtos/claim_info_dto.dart';

class CredentialRepositoryImpl extends CredentialRepository {
  final RemoteClaimDataSource _remoteClaimDataSource;
  final StorageClaimDataSource _storageClaimDataSource;
  final LocalClaimDataSource _localClaimDataSource;
  final ClaimMapper _claimMapper;
  final FiltersMapper _filtersMapper;
  final IdFilterMapper _idFilterMapper;

  CredentialRepositoryImpl(
    this._remoteClaimDataSource,
    this._storageClaimDataSource,
    this._localClaimDataSource,
    this._claimMapper,
    this._filtersMapper,
    this._idFilterMapper,
  );

  @override
  Future<void> saveClaims(
      {required List<ClaimEntity> claims,
      required String genesisDid,
      required String privateKey}) {
    return _storageClaimDataSource
        .storeClaims(
            claims: claims.map((claim) => _claimMapper.mapTo(claim)).toList(),
            did: genesisDid,
            privateKey: privateKey)
        .catchError((error) => throw SaveClaimException(error));
  }

  @override
  Future<List<ClaimEntity>> getClaims(
      {List<FilterEntity>? filters,
      required String genesisDid,
      required String privateKey}) {
    return _storageClaimDataSource
        .getClaims(
            filter: filters == null ? null : _filtersMapper.mapTo(filters),
            did: genesisDid,
            privateKey: privateKey)
        .then((claims) =>
            claims.map((claim) => _claimMapper.mapFrom(claim)).toList())
        .catchError((error) => throw GetClaimsException(error));
  }

  @override
  Future<ClaimEntity> getClaim(
      {required String claimId,
      required String genesisDid,
      required String privateKey}) {
    return _storageClaimDataSource
        .getClaims(
            filter: _idFilterMapper.mapTo(claimId),
            did: genesisDid,
            privateKey: privateKey)
        .then((claims) => claims.isEmpty
            ? throw ClaimNotFoundException(claimId)
            : _claimMapper.mapFrom(claims.first));
  }

  @override
  Future<void> removeClaims(
      {required List<String> claimIds,
      required String genesisDid,
      required String privateKey}) {
    return _storageClaimDataSource
        .removeClaims(
            claimIds: claimIds, did: genesisDid, privateKey: privateKey)
        .catchError((error) => throw RemoveClaimsException(error));
  }

  @override
  Future<void> removeAllClaims(
      {required String genesisDid, required String privateKey}) {
    return _storageClaimDataSource
        .removeAllClaims(did: genesisDid, privateKey: privateKey)
        .catchError((error) => throw RemoveClaimsException(error));
  }

  Future<String> getRhsRevocationId({required ClaimEntity claim}) {
    ClaimDTO claimDTO = _claimMapper.mapTo(claim);
    try {
      return Future.value(claimDTO.info.proofs
          .where((proof) => proof.type == "BJJSignature2021")
          .first
          .issuer
          .id);
    } catch (error) {
      throw NullRevocationStatusException(claim);
    }
  }

  Future<String> getIssuerIdentifier({required ClaimEntity claim}) {
    return Future.value(_claimMapper.mapTo(claim).info.issuer);
  }

  @override
  Future<Map<String, dynamic>> getRevocationStatus(
      {required ClaimEntity claim}) {
    return getRevocationUrl(claim: claim, rhs: false).then((revStatusUrl) =>
        _remoteClaimDataSource.getClaimRevocationStatus(revStatusUrl));
  }

  @override
  Future<bool> isUsingRHS({required ClaimEntity claim}) {
    return Future.value(_claimMapper.mapTo(claim)).then((claimDTO) =>
        (claimDTO.info.credentialStatus.type ==
            CredentialStatusType.reverseSparseMerkleTreeProof));
  }

  @override
  Future<int> getRevocationNonce(
      {required ClaimEntity claim, required bool rhs}) {
    try {
      return Future.value(_claimMapper.mapTo(claim)).then((claimDTO) =>
          (claimDTO.info.credentialStatus.type ==
                  CredentialStatusType.reverseSparseMerkleTreeProof
              ? (rhs
                  ? claimDTO.info.credentialStatus.revocationNonce!
                  : claimDTO
                      .info.credentialStatus.statusIssuer!.revocationNonce!)
              : (rhs == false
                  ? claimDTO.info.credentialStatus.revocationNonce!
                  : throw NullRevocationStatusException(claim))));
    } catch (error) {
      throw NullRevocationStatusException(claim);
    }
  }

  @override
  Future<String> getRevocationUrl(
      {required ClaimEntity claim, required bool rhs}) {
    try {
      return Future.value(_claimMapper.mapTo(claim)).then((claimDTO) =>
          (claimDTO.info.credentialStatus.type ==
                  CredentialStatusType.reverseSparseMerkleTreeProof
              ? (rhs
                  ? claimDTO.info.credentialStatus.id
                  : claimDTO.info.credentialStatus.statusIssuer!.id)
              : (rhs == false
                  ? claimDTO.info.credentialStatus.id
                  : throw NullRevocationStatusException(claim))));
    } catch (error) {
      throw NullRevocationStatusException(claim);
    }
  }

  @override
  Future<List<String>> getAuthClaim({required List<String> publicKey}) {
    return _localClaimDataSource.getAuthClaim(publicKey: publicKey);
  }
}
