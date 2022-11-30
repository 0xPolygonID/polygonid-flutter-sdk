import 'package:polygonid_flutter_sdk/identity/data/data_sources/rpc_data_source.dart';

import '../../domain/entities/identity_entity.dart';
import '../../domain/entities/private_identity_entity.dart';
import '../../domain/entities/rhs_node_entity.dart';
import '../../domain/exceptions/identity_exceptions.dart';
import '../../domain/repositories/identity_repository.dart';
import '../../libs/bjj/privadoid_wallet.dart';
import '../data_sources/lib_identity_data_source.dart';
import '../data_sources/local_contract_files_data_source.dart';
import '../data_sources/remote_identity_data_source.dart';
import '../data_sources/storage_identity_data_source.dart';
import '../data_sources/wallet_data_source.dart';
import '../dtos/identity_dto.dart';
import '../mappers/did_mapper.dart';
import '../mappers/hex_mapper.dart';
import '../mappers/identity_dto_mapper.dart';
import '../mappers/private_key_mapper.dart';
import '../mappers/rhs_node_mapper.dart';
import '../mappers/state_identifier_mapper.dart';

class IdentityRepositoryImpl extends IdentityRepository {
  final WalletDataSource _walletDataSource;
  final LibIdentityDataSource _libIdentityDataSource;
  final RemoteIdentityDataSource _remoteIdentityDataSource;
  final StorageIdentityDataSource _storageIdentityDataSource;
  final RPCDataSource _rpcDataSource;
  final LocalContractFilesDataSource _localContractFilesDataSource;
  final HexMapper _hexMapper;
  final PrivateKeyMapper _privateKeyMapper;
  final IdentityDTOMapper _identityDTOMapper;
  final RhsNodeMapper _rhsNodeMapper;
  final StateIdentifierMapper _stateIdentifierMapper;
  final DidMapper _didMapper;

  IdentityRepositoryImpl(
    this._walletDataSource,
    this._libIdentityDataSource,
    this._remoteIdentityDataSource,
    this._storageIdentityDataSource,
    this._rpcDataSource,
    this._localContractFilesDataSource,
    this._hexMapper,
    this._privateKeyMapper,
    this._identityDTOMapper,
    this._rhsNodeMapper,
    this._stateIdentifierMapper,
    this._didMapper,
  );

  /// Get a [PrivateIdentityEntity] from a String secret
  /// It will create a new [PrivateIdentity]
  ///
  /// @return the associated identifier
  @override
  Future<PrivateIdentityEntity> createIdentity(
      {String? secret, required String accessMessage}) async {
    try {
      // Create a wallet
      PrivadoIdWallet wallet = await _walletDataSource.createWallet(
          secret: _privateKeyMapper.mapFrom(secret),
          accessMessage: accessMessage);

      // Get the associated identifier
      String identifier = await getIdentifier(
          privateKey: (_hexMapper.mapFrom(wallet.privateKey)));

      PrivateIdentityEntity identityEntity = _identityDTOMapper.mapPrivateFrom(
          IdentityDTO(identifier: identifier, publicKey: wallet.publicKey),
          _hexMapper.mapFrom(wallet.privateKey));
      return Future.value(identityEntity);
    } catch (error) {
      return Future.error(IdentityException(error));
    }
  }

  @override
  Future<String> getIdentifier({required String privateKey}) async {
    // Create a wallet
    PrivadoIdWallet wallet = await _walletDataSource.getWallet(
        privateKey: _hexMapper.mapTo(privateKey));

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
      return Future.error(IdentityException(error));
    }
  }

  /// Get an [IdentityEntity] from an identifier
  /// The [IdentityEntity] is the one previously stored and associated to the identifier
  /// Throws an [UnknownIdentityException] if not found.
  @override
  Future<IdentityEntity> getIdentity({required String identifier}) {
    return _storageIdentityDataSource
        .getIdentity(identifier: identifier)
        .then((dto) => _identityDTOMapper.mapFrom(dto))
        .catchError((error) => throw IdentityException(error),
            test: (error) => error is! UnknownIdentityException);
  }

  /// Get an [PrivateIdentityEntity] from an identifier and a privateKey
  /// The [PrivateIdentityEntity] is the one previously stored and associated to the identifier
  /// And we and the private info (privateKey and authClaim)
  /// Throws an [UnknownIdentityException] if not found.
  @override
  Future<PrivateIdentityEntity> getPrivateIdentity(
      {required String identifier, required String privateKey}) {
    return _storageIdentityDataSource
        .getIdentity(identifier: identifier)
        .then((dto) => _walletDataSource
            .getWallet(privateKey: _hexMapper.mapTo(privateKey))
            .then((wallet) => _libIdentityDataSource
                    .getIdentifier(
                        pubX: wallet.publicKey[0], pubY: wallet.publicKey[1])
                    .then((identifierFromKey) {
                  if (identifierFromKey != identifier) {
                    throw InvalidPrivateKeyException(privateKey);
                  }

                  return _identityDTOMapper.mapPrivateFrom(dto, privateKey);
                })))
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
  Future<Map<String, dynamic>> getNonRevProof(
      {required String identityState,
      required int nonce,
      required String baseUrl}) {
    return _remoteIdentityDataSource
        .getNonRevocationProof(identityState, nonce, baseUrl)
        .catchError((error) => throw NonRevProofException(error));
  }

  @override
  Future<String> getDidIdentifier({
    required String identifier,
    required String networkName,
    required String networkEnv,
  }) {
    return Future.value(
        _didMapper.mapTo(DidMapperParam(identifier, networkName, networkEnv)));
  }

  @override
  Future<List<IdentityEntity>> getIdentities() {
    // TODO: implement getIdentities
    throw UnimplementedError();
  }
}
