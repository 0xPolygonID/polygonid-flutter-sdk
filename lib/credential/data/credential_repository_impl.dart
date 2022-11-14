import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/credential_request_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/remote_identity_data_source.dart';

import '../../identity/domain/entities/private_identity_entity.dart';
import 'data_sources/remote_claim_data_source.dart';
import 'data_sources/storage_claim_data_source.dart';
import 'dtos/claim_proofs/claim_proof_dto.dart';
import 'mappers/claim_mapper.dart';
import 'mappers/credential_request_mapper.dart';
import 'mappers/filters_mapper.dart';
import 'mappers/id_filter_mapper.dart';
import 'mappers/revocation_status_mapper.dart';

class CredentialRepositoryImpl extends CredentialRepository {
  final RemoteClaimDataSource _remoteClaimDataSource;
  final StorageClaimDataSource _storageClaimDataSource;
  final RemoteIdentityDataSource _remoteIdentityDataSource;
  final LibIdentityDataSource _libIdentityDataSource;
  final CredentialRequestMapper _credentialRequestMapper;
  final ClaimMapper _claimMapper;
  final FiltersMapper _filtersMapper;
  final IdFilterMapper _idFilterMapper;
  final RevocationStatusMapper _revocationStatusMapper;

  CredentialRepositoryImpl(
      this._remoteClaimDataSource,
      this._storageClaimDataSource,
      this._remoteIdentityDataSource,
      this._libIdentityDataSource,
      this._credentialRequestMapper,
      this._claimMapper,
      this._filtersMapper,
      this._idFilterMapper,
      this._revocationStatusMapper);

  @override
  Future<ClaimEntity> fetchClaim(
      {required String identifier,
      required String token,
      required CredentialRequestEntity credentialRequest}) {
    return _remoteClaimDataSource
        .fetchClaim(
            token: token, url: credentialRequest.url, identifier: identifier)
        .then((dto) => _claimMapper.mapFrom(dto))
        .catchError((error) => throw FetchClaimException(error));
  }

  @override
  Future<String> getFetchMessage(
      {required CredentialRequestEntity credentialRequest}) {
    return Future.value(
        jsonEncode(_credentialRequestMapper.mapTo(credentialRequest)));
  }

  @override
  Future<void> saveClaims(
      {required List<ClaimEntity> claims,
      required String identifier,
      required String privateKey}) {
    return _storageClaimDataSource
        .storeClaims(
            claims: claims.map((claim) => _claimMapper.mapTo(claim)).toList(),
            identifier: identifier,
            privateKey: privateKey)
        .catchError((error) => throw SaveClaimException(error));
  }

  @override
  Future<List<ClaimEntity>> getClaims(
      {List<FilterEntity>? filters,
      required String identifier,
      required String privateKey}) {
    return _storageClaimDataSource
        .getClaims(
            filter: filters == null ? null : _filtersMapper.mapTo(filters),
            identifier: identifier,
            privateKey: privateKey)
        .then((claims) =>
            claims.map((claim) => _claimMapper.mapFrom(claim)).toList())
        .catchError((error) => throw GetClaimsException(error));
  }

  @override
  Future<ClaimEntity> getClaim(
      {required String claimId,
      required String identifier,
      required String privateKey}) {
    return _storageClaimDataSource
        .getClaims(
            filter: _idFilterMapper.mapTo(claimId),
            identifier: identifier,
            privateKey: privateKey)
        .then((claims) => claims.isEmpty
            ? throw ClaimNotFoundException(claimId)
            : _claimMapper.mapFrom(claims.first));
  }

  @override
  Future<void> removeClaims(
      {required List<String> claimIds,
      required String identifier,
      required String privateKey}) {
    return _storageClaimDataSource
        .removeClaims(
            claimIds: claimIds, identifier: identifier, privateKey: privateKey)
        .catchError((error) => throw RemoveClaimsException(error));
  }

  @override
  Future<Map<String, dynamic>?> fetchSchema({required String url}) {
    return _remoteClaimDataSource
        .fetchSchema(url: url)
        .catchError((error) => throw FetchSchemaException(error));
  }

  @override
  Future<Map<String, dynamic>?> fetchVocab(
      {required Map<String, dynamic>? schema, required String type}) {
    return _remoteClaimDataSource
        .fetchVocab(schema: schema, type: type)
        .catchError((error) => throw FetchVocabException(error));
  }

  Future<String> getRhsRevocationId({required ClaimEntity claim}) {
    ClaimDTO claimDTO = _claimMapper.mapTo(claim);
    try {
      return Future.value(claimDTO.info.proofs
          .where((proof) => proof.type == ClaimProofType.bjj)
          .first
          .issuer
          .id);
    } catch (error) {
      throw NullRevocationStatusException(claim);
    }
  }

  @override
  Future<Map<String, dynamic>> getRevocationStatus(
      {required ClaimEntity claim}) {
    return _remoteClaimDataSource
        .getClaimRevocationStatus(_claimMapper.mapTo(claim).info);
  }

  @override
  Future<bool> isUsingRHS({required ClaimEntity claim}) {
    return Future.value(true);
  }

  @override
  Future<int> getRevocationNonce({required ClaimEntity claim}) {
    return Future.value(_claimMapper.mapTo(claim))
        .then((claimDTO) => claimDTO.info.revNonce);
  }

  @override
  Future<String> getAuthClaim({required PrivateIdentityEntity identity}) {
    return _libIdentityDataSource.getAuthClaim(
        pubX: identity.publicKey[0], pubY: identity.publicKey[1]);
  }
}
