import 'dart:convert';

import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/offer/offer_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_babyjubjub_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/node_entity.dart';

import '../../identity/data/dtos/hash_dto.dart';
import '../../identity/data/dtos/node_dto.dart';
import '../../identity/data/mappers/node_mapper.dart';
import '../../identity/domain/entities/identity_entity.dart';
import 'data_sources/lib_pidcore_credential_data_source.dart';
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
  final LibPolygonIdCoreCredentialDataSource
      _libPolygonIdCoreCredentialDataSource;
  final LibBabyJubJubDataSource _libBabyJubJubDataSource;
  final CredentialRequestMapper _credentialRequestMapper;
  final LibIdentityDataSource _libIdentityDataSource;
  final ClaimMapper _claimMapper;
  final FiltersMapper _filtersMapper;
  final IdFilterMapper _idFilterMapper;
  final NodeMapper _nodeMapper;
  final RevocationStatusMapper _revocationStatusMapper;

  CredentialRepositoryImpl(
      this._remoteClaimDataSource,
      this._storageClaimDataSource,
      this._libPolygonIdCoreCredentialDataSource,
      this._libBabyJubJubDataSource,
      this._credentialRequestMapper,
      this._libIdentityDataSource,
      this._claimMapper,
      this._filtersMapper,
      this._idFilterMapper,
      this._nodeMapper,
      this._revocationStatusMapper);

  @override
  Future<ClaimEntity> fetchClaim(
      {required String identifier,
      required String token,
      required OfferIden3MessageEntity message}) {
    return _remoteClaimDataSource
        .fetchClaim(token: token, url: message.body.url, identifier: identifier)
        .then((dto) {
      /// Error in fetching schema and vocab are not blocking
      return _remoteClaimDataSource
          .fetchSchema(url: dto.info.credentialSchema.id)
          .then((schema) => _remoteClaimDataSource
                  .fetchVocab(
                      schema: schema, type: dto.info.credentialSubject.type)
                  .then((vocab) {
                dto.schema = schema;
                dto.vocab = vocab;

                return dto;
              }))
          .catchError((_) => dto)
          .then((value) => _claimMapper.mapFrom(dto));
    }).catchError((error) => throw FetchClaimException(error));
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
  Future<Map<String, dynamic>> fetchSchema({required String url}) {
    return _remoteClaimDataSource
        .fetchSchema(url: url)
        .catchError((error) => throw FetchSchemaException(error));
  }

  @override
  Future<Map<String, dynamic>> fetchVocab(
      {required Map<String, dynamic> schema, required String type}) {
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
  Future<NodeEntity> getAuthClaimNode(
      {required IdentityEntity identity}) async {
    //return _libPolygonIdCoreClaimDataSource.getAuthClaim(
    //    pubX: identity.publicKey[0], pubY: identity.publicKey[1]);

    String authClaimSchema = "ca938857241db9451ea329256b9c06e5";
    String authClaimNonce = "15930428023331155902";
    String authClaim = _libPolygonIdCoreCredentialDataSource.issueAuthClaim(
      schema: authClaimSchema,
      nonce: authClaimNonce,
      publicKey: identity.publicKey,
    );
    List<String> children = List.from(jsonDecode(authClaim));
    String hashIndex = await _libBabyJubJubDataSource.hashPoseidon4(
      children[0],
      children[1],
      children[2],
      children[3],
    );
    String hashValue = await _libBabyJubJubDataSource.hashPoseidon4(
      children[4],
      children[5],
      children[6],
      children[7],
    );
    String hashClaimNode = await _libBabyJubJubDataSource.hashPoseidon3(
        hashIndex, hashValue, BigInt.one.toString());
    NodeDTO authClaimNode = NodeDTO(
        children: [
          HashDTO.fromBigInt(BigInt.parse(hashIndex)),
          HashDTO.fromBigInt(BigInt.parse(hashValue)),
          HashDTO.fromBigInt(BigInt.one),
        ],
        hash: HashDTO.fromBigInt(BigInt.parse(hashClaimNode)),
        type: NodeTypeDTO.leaf);
    return Future.value(_nodeMapper.mapFrom(authClaimNode));
  }
}
