import 'package:encrypt/encrypt.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/db_destination_path_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/encryption_db_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/remote_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/storage_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_proofs/claim_proof_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/encryption_key_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/filters_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/id_filter_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/revocation_status_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/offer/offer_iden3_message_entity.dart';
import 'package:sembast/sembast_io.dart';

import 'data_sources/local_claim_data_source.dart';
import 'dtos/claim_info_dto.dart';

class CredentialRepositoryImpl extends CredentialRepository {
  final RemoteClaimDataSource _remoteClaimDataSource;
  final StorageClaimDataSource _storageClaimDataSource;

  // final LibIdentityDataSource _libIdentityDataSource;
  final ClaimMapper _claimMapper;
  final FiltersMapper _filtersMapper;
  final IdFilterMapper _idFilterMapper;
  final RevocationStatusMapper _revocationStatusMapper;
  final EncryptionDbDataSource _encryptionDbDataSource;
  final DestinationPathDataSource _destinationPathDataSource;
  final LocalClaimDataSource _localClaimDataSource;
  final EncryptionKeyMapper _encryptionKeyMapper;

  CredentialRepositoryImpl(
    this._remoteClaimDataSource,
    this._storageClaimDataSource,
    // this._libIdentityDataSource,
    this._claimMapper,
    this._filtersMapper,
    this._idFilterMapper,
    this._revocationStatusMapper,
    this._encryptionDbDataSource,
    this._destinationPathDataSource,
    this._localClaimDataSource,
    this._encryptionKeyMapper,
  );

  @override
  Future<ClaimEntity> fetchClaim(
      {required String did,
      required String token,
      required OfferIden3MessageEntity message}) {
    return _remoteClaimDataSource
        .fetchClaim(token: token, url: message.body.url, did: did)
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
      required String did,
      required String privateKey}) {
    return _storageClaimDataSource
        .storeClaims(
            claims: claims.map((claim) => _claimMapper.mapTo(claim)).toList(),
            did: did,
            privateKey: privateKey)
        .catchError((error) => throw SaveClaimException(error));
  }

  @override
  Future<List<ClaimEntity>> getClaims(
      {List<FilterEntity>? filters,
      required String did,
      required String privateKey}) {
    return _storageClaimDataSource
        .getClaims(
            filter: filters == null ? null : _filtersMapper.mapTo(filters),
            did: did,
            privateKey: privateKey)
        .then((claims) =>
            claims.map((claim) => _claimMapper.mapFrom(claim)).toList())
        .catchError((error) => throw GetClaimsException(error));
  }

  @override
  Future<ClaimEntity> getClaim(
      {required String claimId,
      required String did,
      required String privateKey}) {
    return _storageClaimDataSource
        .getClaims(
            filter: _idFilterMapper.mapTo(claimId),
            did: did,
            privateKey: privateKey)
        .then((claims) => claims.isEmpty
            ? throw ClaimNotFoundException(claimId)
            : _claimMapper.mapFrom(claims.first));
  }

  @override
  Future<void> removeClaims(
      {required List<String> claimIds,
      required String did,
      required String privateKey}) {
    return _storageClaimDataSource
        .removeClaims(claimIds: claimIds, did: did, privateKey: privateKey)
        .catchError((error) => throw RemoveClaimsException(error));
  }

  @override
  Future<void> removeAllClaims(
      { required String did,
        required String privateKey}) {
    return _storageClaimDataSource
        .removeAllClaims(did: did, privateKey: privateKey)
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
  Future<String> exportClaims(
      {required String did, required String privateKey}) async {
    Map<String, Object?> exportableDb = await _storageClaimDataSource
        .getClaimsDb(did: did, privateKey: privateKey);

    Key key = _encryptionKeyMapper.mapFrom(privateKey);

    return _encryptionDbDataSource.encryptData(
      data: exportableDb,
      key: key,
    );
  }

  @override
  Future<void> importClaims(
      {required String did,
      required String privateKey,
      required String encryptedDb}) async {
    Key key = _encryptionKeyMapper.mapFrom(privateKey);

    Map<String, Object?> decryptedDb = _encryptionDbDataSource.decryptData(
      encryptedData: encryptedDb,
      key: key,
    );

    String destinationPath =
        await _destinationPathDataSource.getDestinationPath(did: did);

    return _storageClaimDataSource.saveClaimsDb(
      exportableDb: decryptedDb,
      databaseFactory: databaseFactoryIo,
      destinationPath: destinationPath,
      privateKey: privateKey,
    );
  }

  @override
  Future<List<String>> getAuthClaim({required List<String> publicKey}) {
    return _localClaimDataSource.getAuthClaim(publicKey: publicKey);
  }
}
