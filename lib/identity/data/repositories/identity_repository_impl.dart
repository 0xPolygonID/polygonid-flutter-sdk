import 'package:encrypt/encrypt.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_constants.dart';
import 'package:polygonid_flutter_sdk/credential/data/mappers/rev_status_mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/rev_status_entity.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/db_destination_path_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/encryption_db_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_babyjubjub_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/lib_pidcore_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/common/data/data_sources/local_contract_files_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/remote_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/rpc_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/storage_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/wallet_data_source.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/hash_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/node_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/encryption_key_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/hex_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/identity_dto_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/node_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/private_key_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/rhs_node_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/state_identifier_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/node_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/rhs_node_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/identity/domain/repositories/identity_repository.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/proof_entity.dart';
import 'package:sembast/sembast_io.dart';

class IdentityRepositoryImpl extends IdentityRepository {
  final WalletDataSource _walletDataSource;
  final RemoteIdentityDataSource _remoteIdentityDataSource;
  final StorageIdentityDataSource _storageIdentityDataSource;
  final RPCIdentityDataSource _rpcIdentityDataSource;
  final LocalContractFilesDataSource _localContractFilesDataSource;
  final LibBabyJubJubDataSource _libBabyJubJubDataSource;
  final LibPolygonIdCoreIdentityDataSource _libPolygonIdCoreIdentityDataSource;
  final EncryptionDbDataSource _encryptionDbDataSource;
  final DestinationPathDataSource _destinationPathDataSource;
  final HexMapper _hexMapper;
  final PrivateKeyMapper _privateKeyMapper;
  final IdentityDTOMapper _identityDTOMapper;
  final RhsNodeMapper _rhsNodeMapper;
  final StateIdentifierMapper _stateIdentifierMapper;
  final NodeMapper _nodeMapper;
  final EncryptionKeyMapper _encryptionKeyMapper;
  final RevStatusMapper _revStatusMapper;

  IdentityRepositoryImpl(
    this._walletDataSource,
    this._remoteIdentityDataSource,
    this._storageIdentityDataSource,
    this._rpcIdentityDataSource,
    this._localContractFilesDataSource,
    this._libBabyJubJubDataSource,
    this._libPolygonIdCoreIdentityDataSource,
    this._encryptionDbDataSource,
    this._destinationPathDataSource,
    this._hexMapper,
    this._privateKeyMapper,
    this._identityDTOMapper,
    this._rhsNodeMapper,
    this._stateIdentifierMapper,
    this._nodeMapper,
    this._encryptionKeyMapper,
    this._revStatusMapper,
  );

  @override
  Future<String> getPrivateKey({required String? secret}) {
    return _walletDataSource
        .createWallet(secret: _privateKeyMapper.mapFrom(secret))
        .then((wallet) => _hexMapper.mapFrom(wallet.privateKey));
  }

  @override
  Future<List<String>> getPublicKeys({required privateKey}) {
    return _walletDataSource
        .getWallet(privateKey: _hexMapper.mapTo(privateKey))
        .then((wallet) => wallet.publicKey);
  }

  @override
  Future<NodeEntity> getAuthClaimNode({required List<String> children}) async {
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
    return _nodeMapper.mapFrom(authClaimNode);
  }

  @override
  Future<void> storeIdentity({required IdentityEntity identity}) {
    return Future.value(_identityDTOMapper.mapTo(identity)).then((dto) =>
        _storageIdentityDataSource
            .storeIdentity(did: identity.did, identity: dto)
            .catchError((error) => throw IdentityException(error)));
  }

  /// Get an [IdentityEntity] from an identifier
  /// The [IdentityEntity] is the one previously stored and associated to the identifier
  /// Throws an [UnknownIdentityException] if not found.
  @override
  Future<IdentityEntity> getIdentity({required String genesisDid}) {
    return _storageIdentityDataSource
        .getIdentity(did: genesisDid)
        .then((dto) => _identityDTOMapper.mapFrom(dto))
        .catchError((error) => throw IdentityException(error),
            test: (error) => error is! UnknownIdentityException);
  }

  @override
  Future<List<IdentityEntity>> getIdentities() {
    return _storageIdentityDataSource
        .getIdentities()
        .then((dtos) =>
            dtos.map((dto) => _identityDTOMapper.mapFrom(dto)).toList())
        .catchError((error) => throw IdentityException(error));
  }

  @override
  Future<void> removeIdentity({required String genesisDid}) {
    return _storageIdentityDataSource.removeIdentity(did: genesisDid);
  }

  /// Sign a message through a privateKey
  ///
  /// Return a signature in hexadecimal format
  @override
  Future<String> signMessage(
      {required String privateKey, required String message}) {
    return _walletDataSource
        .signMessage(privateKey: _hexMapper.mapTo(privateKey), message: message)
        .catchError((error) => throw IdentityException(error));
  }

  @override
  Future<String> getState(
      {required String identifier, required String contractAddress}) {
    return _localContractFilesDataSource
        .loadStateContract(contractAddress)
        .then((contract) => _rpcIdentityDataSource
            .getState(_stateIdentifierMapper.mapTo(identifier), contract)
            .catchError((error) => throw FetchIdentityStateException(error)));
  }

  @override
  Future<RhsNodeEntity> getStateRoots({required String url}) {
    return _remoteIdentityDataSource
        .fetchStateRoots(url: url)
        .then((dto) => _rhsNodeMapper.mapFrom(dto))
        .catchError((error) => throw FetchStateRootsException(error));
  }

  @override
  Future<RevStatusEntity> getNonRevProof(
      {required String identityState,
      required BigInt nonce,
      required String baseUrl}) {
    return _remoteIdentityDataSource
        .getNonRevocationProof(identityState, nonce, baseUrl)
        .then((value) => _revStatusMapper.mapFrom(value))
        .catchError((error) => throw NonRevProofException(error));
  }

  @override
  Future<String> getDidIdentifier({
    required String blockchain,
    required String network,
    required String claimsTreeRoot,
    required BigInt profileNonce,
  }) {
    try {
      // Get the genesis id
      String genesisDid = _libPolygonIdCoreIdentityDataSource
          .calculateGenesisId(claimsTreeRoot, blockchain, network);

      if (profileNonce == GENESIS_PROFILE_NONCE) {
        return Future.value(genesisDid);
      } else {
        String profileDid = _libPolygonIdCoreIdentityDataSource
            .calculateProfileId(genesisDid, profileNonce);

        return Future.value(profileDid);
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  @override
  Future<String> convertIdToBigInt({required String id}) {
    String idBigInt = _libPolygonIdCoreIdentityDataSource.genesisIdToBigInt(id);
    return Future.value(idBigInt);
  }

  @override
  Future<String> exportIdentity({
    required String did,
    required String privateKey,
  }) async {
    Map<String, Object?> exportableDb = await _storageIdentityDataSource
        .getIdentityDb(did: did, privateKey: privateKey);

    Key key = _encryptionKeyMapper.mapFrom(privateKey);

    return _encryptionDbDataSource.encryptData(
      data: exportableDb,
      key: key,
    );
  }

  @override
  Future<void> importIdentity({
    required String did,
    required String privateKey,
    required String encryptedDb,
  }) async {
    Key key = _encryptionKeyMapper.mapFrom(privateKey);

    Map<String, Object?> decryptedDb = _encryptionDbDataSource.decryptData(
      encryptedData: encryptedDb,
      key: key,
    );

    String destinationPath =
        await _destinationPathDataSource.getDestinationPath(did: did);

    return _storageIdentityDataSource.saveIdentityDb(
      exportableDb: decryptedDb,
      destinationPath: destinationPath,
      privateKey: privateKey,
    );
  }
}
