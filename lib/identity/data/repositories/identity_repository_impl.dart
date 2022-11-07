import 'package:fast_base58/fast_base58.dart';
import 'package:polygonid_flutter_sdk/identity/data/data_sources/rpc_data_source.dart';
import 'package:web3dart/crypto.dart';

import '../../domain/entities/identity_entity.dart';
import '../../domain/entities/private_identity_entity.dart';
import '../../domain/entities/rhs_node_entity.dart';
import '../../domain/exceptions/identity_exceptions.dart';
import '../../domain/repositories/identity_repository.dart';
import '../../libs/bjj/privadoid_wallet.dart';
import '../data_sources/lib_identity_data_source.dart';
import '../data_sources/local_contract_files_data_source.dart';
import '../data_sources/local_identity_data_source.dart';
import '../data_sources/remote_identity_data_source.dart';
import '../data_sources/storage_identity_data_source.dart';
import '../data_sources/storage_key_value_data_source.dart';
import '../data_sources/wallet_data_source.dart';
import '../dtos/identity_dto.dart';
import '../dtos/private_identity_dto.dart';
import '../mappers/hex_mapper.dart';
import '../mappers/identity_dto_mapper.dart';
import '../mappers/private_identity_dto_mapper.dart';
import '../mappers/private_key_mapper.dart';
import '../mappers/rhs_node_mapper.dart';

class IdentityRepositoryImpl extends IdentityRepository {
  final WalletDataSource _walletDataSource;
  final LibIdentityDataSource _libIdentityDataSource;
  final LocalIdentityDataSource _localIdentityDataSource;
  final RemoteIdentityDataSource _remoteIdentityDataSource;
  final StorageIdentityDataSource _storageIdentityDataSource;
  final StorageKeyValueDataSource _storageKeyValueDataSource;
  final RPCDataSource _rpcDataSource;
  final LocalContractFilesDataSource _localContractFilesDataSource;
  final HexMapper _hexMapper;
  final PrivateKeyMapper _privateKeyMapper;
  final IdentityDTOMapper _identityDTOMapper;
  final PrivateIdentityDTOMapper _privateIdentityDTOMapper;
  final RhsNodeMapper _rhsNodeMapper;

  IdentityRepositoryImpl(
    this._walletDataSource,
    this._libIdentityDataSource,
    this._localIdentityDataSource,
    this._remoteIdentityDataSource,
    this._storageIdentityDataSource,
    this._storageKeyValueDataSource,
    this._rpcDataSource,
    this._localContractFilesDataSource,
    this._hexMapper,
    this._privateKeyMapper,
    this._identityDTOMapper,
    this._privateIdentityDTOMapper,
    this._rhsNodeMapper,
    //this._smtStorageRepository,
  );

  /// Get an IdentityEntity from a String secret
  /// It will create and store a new [IdentityDTO] if it doesn't exists
  ///
  /// @return the associated identifier
  @override
  Future<PrivateIdentityEntity> createIdentity(
      {String? secret, bool isStored = true}) async {
    try {
      // Create a wallet
      PrivadoIdWallet wallet = await _walletDataSource.createWallet(
          secret: _privateKeyMapper.mapFrom(secret));

      // Get the associated identifier
      String identifier = await getIdentifier(
          privateKey: (_hexMapper.mapFrom(wallet.privateKey)));

      String authClaim = await _libIdentityDataSource.getAuthClaim(
          pubX: wallet.publicKey[0], pubY: wallet.publicKey[1]);

      // Generate the smt state
      String state = "";
      //await _libIdentityDataSource.createSMT(_smtStorageRepository);

      PrivateIdentityDTO dto = PrivateIdentityDTO(
          identifier: identifier,
          publicKey: wallet.publicKey,
          state: state,
          privateKey: _hexMapper.mapFrom(wallet.privateKey),
          authClaim: authClaim);
      PrivateIdentityEntity identityEntity =
          _privateIdentityDTOMapper.mapFrom(dto);

      if (isStored) {
        await storeIdentity(
            identity: identityEntity, privateKey: identityEntity.privateKey);
      }

      return Future.value(identityEntity);
    } catch (error) {
      throw IdentityException(error);
    }
  }

  Future<String> getIdentifier({required String privateKey}) async {
    // Create a wallet
    PrivadoIdWallet wallet = PrivadoIdWallet(_hexMapper.mapTo(privateKey));

    // Get the associated identifier
    String identifier = await _libIdentityDataSource.getIdentifier(
        pubX: wallet.publicKey[0], pubY: wallet.publicKey[1]);

    return identifier;
  }

  @override
  Future<void> storeIdentity(
      {required IdentityEntity identity, required String privateKey}) async {
    try {
      String identifier = await getIdentifier(privateKey: privateKey);
      if (identifier == identity.identifier) {
        IdentityDTO dto = _identityDTOMapper.mapTo(identity);
        await _storageIdentityDataSource.storeIdentity(
            identifier: identifier, identity: dto);
        IdentityEntity identityEntity = _identityDTOMapper.mapFrom(dto);
      } else {
        throw InvalidPrivateKeyException(privateKey);
      }
    } catch (error) {
      throw IdentityException(error);
    }
  }

  /// Get an [IdentityEntity] from a String
  ///
  /// Used for retro compatibility with demo
  /*@override
  Future<IdentityEntity> getIdentityFromSecret({String? secret}) {
    return Future.value(_privateKeyMapper.mapFrom(secret)).then((key) =>
        _walletDataSource
            .createWallet(privateKey: key)
            .then((wallet) => Future.wait([
                  _libIdentityDataSource.getIdentifier(
                      pubX: wallet.publicKey[0], pubY: wallet.publicKey[1]),
                  _libIdentityDataSource.getAuthClaim(
                      pubX: wallet.publicKey[0], pubY: wallet.publicKey[1]),
                  Future.value(wallet.publicKey),
                  //_libIdentityDataSource.createSMT(_smtStorageRepository)
                ]).then((values) => IdentityEntity(
                    privateKey: _hexMapper.mapFrom(wallet.privateKey),
                    identifier: values[0] as String,
                    authClaim: values[1] as String,
                    publicKey: wallet.publicKey,
                    state: '')))
            .catchError((error) => throw IdentityException(error)));
  }*/

  /*/// Get an identifier from a publicKey
  @override
  Future<String> getIdentifierFromPubKey({List<String> publicKey}) {
    return Future.value(_privateKeyMapper.mapFrom(secret))
        .then((key) => // Create a wallet from the private key
            _walletDataSource.createWallet(privateKey: key))
        .then((wallet) => // Get the associated identifier
            _libIdentityDataSource.getIdentifier(
                pubX: wallet.publicKey[0], pubY: wallet.publicKey[1]));
  }*/

  /*@override
  Future<String?> getCurrentIdentifier() {
    return _storageKeyValueDataSource
        .get(key: currentIdentifierKey)
        .then((value) => value == null ? null : value as String);
  }*/

  /// Get an [IdentityEntity] from an identifier
  /// The [IdentityEntity] is the one previously stored and associated to the identifier
  /// Throws an [UnknownIdentityException] if not found.
  @override
  Future<IdentityEntity> getIdentity(
      {required String identifier, String? privateKey}) {
    return _storageIdentityDataSource
        .getIdentity(identifier: identifier, privateKey: privateKey)
        .then((dto) => dto is PrivateIdentityDTO
            ? _privateIdentityDTOMapper.mapFrom(dto)
            : _identityDTOMapper.mapFrom(dto))
        .catchError((error) => throw IdentityException(error),
            test: (error) => error is! UnknownIdentityException);
  }

  @override
  Future<void> removeIdentity(
      {required String identifier, required String privateKey}) {
    return _storageIdentityDataSource.removeIdentity(identifier: identifier);
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
        .then((contract) => _rpcDataSource
            .getState(bytesToHex(Base58Decode(identifier)), contract)
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
  Future<Map<String, dynamic>> getNonRevProof(
      String identityState, int revNonce, String rhsBaseUrl) {
    return _remoteIdentityDataSource
        .getNonRevocationProof(identityState, revNonce, rhsBaseUrl)
        .catchError((error) => throw NonRevProofException(error));
  }

  @override
  Future<String> getDidIdentifier({
    required String identifier,
    required String networkName,
    required String networkEnv,
  }) async {
    return _localIdentityDataSource.getDidIdentifier(
      identifier: identifier,
      networkName: networkName,
      networkEnv: networkEnv,
    );
  }

  @override
  Future<List<IdentityEntity>> getIdentities() {
    // TODO: implement getIdentities
    throw UnimplementedError();
  }
}
