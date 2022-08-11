import 'dart:convert';

import 'package:polygonid_flutter_sdk/data/credential/data_sources/remote_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/domain/credential/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/domain/credential/entities/credential_request_entity.dart';
import 'package:polygonid_flutter_sdk/domain/credential/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/domain/identity/repositories/credential_repository.dart';

import 'data_sources/storage_claim_data_source.dart';
import 'mappers/claim_mapper.dart';
import 'mappers/credential_request_mapper.dart';

class CredentialRepositoryImpl extends CredentialRepository {
  final RemoteClaimDataSource _remoteClaimDataSource;
  final StorageClaimDataSource _storageClaimDataSource;
  final CredentialRequestMapper _credentialRequestMapper;
  final ClaimMapper _claimMapper;

  CredentialRepositoryImpl(
      this._remoteClaimDataSource,
      this._storageClaimDataSource,
      this._credentialRequestMapper,
      this._claimMapper);

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
  Future<void> saveClaims({required List<ClaimEntity> claims}) {
    return _storageClaimDataSource
        .storeClaims(
            claims: claims.map((claim) => _claimMapper.mapTo(claim)).toList())
        .catchError((error) => throw SaveClaimException(error));
  }
}
