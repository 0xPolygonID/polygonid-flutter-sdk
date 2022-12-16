import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/common/utils/encrypt_sembast_codec.dart';
import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/db_destination_path_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/remote_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/storage_claim_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_proofs/claim_proof_dto.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/claim_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/filters_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/id_filter_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/revocation_status_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/data/data_sources/encryption_db_data_source.dart';
import 'package:polygonid_flutter_sdk/credential/data/dtos/claim_dto.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/credential/domain/exceptions/credential_exceptions.dart';
import 'package:polygonid_flutter_sdk/credential/domain/repositories/credential_repository.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/offer/offer_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';
import 'package:sembast/sembast_io.dart';

class CredentialRepositoryImpl extends CredentialRepository {
  final RemoteClaimDataSource _remoteClaimDataSource;
  final StorageClaimDataSource _storageClaimDataSource;
  final LibIdentityDataSource _libIdentityDataSource;
  final ClaimMapper _claimMapper;
  final FiltersMapper _filtersMapper;
  final IdFilterMapper _idFilterMapper;
  final RevocationStatusMapper _revocationStatusMapper;
  final EncryptionDbDataSource _encryptionDbDataSource;
  final DestinationPathDataSource _destinationPathDataSource;

  CredentialRepositoryImpl(
    this._remoteClaimDataSource,
    this._storageClaimDataSource,
    this._libIdentityDataSource,
    this._claimMapper,
    this._filtersMapper,
    this._idFilterMapper,
    this._revocationStatusMapper,
    this._encryptionDbDataSource,
    this._destinationPathDataSource,
  );

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
  Future<String> getAuthClaim({required PrivateIdentityEntity identity}) {
    return _libIdentityDataSource.getAuthClaim(
        pubX: identity.publicKey[0], pubY: identity.publicKey[1]);
  }

  @override
  Future<String> exportEncryptedClaimsDb(
      {required String identifier, required String privateKey}) async {
    Map<String, Object?> exportableDb = await _storageClaimDataSource
        .getClaimsDb(identifier: identifier, privateKey: privateKey);
    return _encryptionDbDataSource.encryptData(
        data: exportableDb, privateKey: privateKey);
  }

  @override
  Future<void> importEncryptedClaimsDb(
      {required String identifier,
      required String privateKey,
      required String encryptedDb}) async {
    Map<String, Object?> decryptedDb = _encryptionDbDataSource.decryptData(
        encryptedData: encryptedDb, privateKey: privateKey);

    String destinationPath = await _destinationPathDataSource
        .getDestinationPath(identifier: identifier);

    //TODO this need to be a DS to get codec? @Flavien
    var codec = getEncryptSembastCodec(password: privateKey);

    return _storageClaimDataSource.saveClaimsDb(
      exportableDb: decryptedDb,
      databaseFactory: databaseFactoryIo,
      destinationPath: destinationPath,
      codec: codec,
    );
  }
}
