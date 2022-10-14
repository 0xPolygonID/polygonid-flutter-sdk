import 'package:polygonid_flutter_sdk/constants.dart';

import '../../domain/entities/identity_entity.dart';
import '../../domain/entities/rhs_node_entity.dart';
import '../../domain/exceptions/identity_exceptions.dart';
import '../../domain/repositories/identity_repository.dart';
import '../../libs/bjj/privadoid_wallet.dart';
import '../data_sources/lib_identity_data_source.dart';
import '../data_sources/remote_identity_data_source.dart';
import '../data_sources/storage_identity_data_source.dart';
import '../data_sources/storage_key_value_data_source.dart';
import '../data_sources/wallet_data_source.dart';
import '../dtos/identity_dto.dart';
import '../mappers/hex_mapper.dart';
import '../mappers/identity_dto_mapper.dart';
import '../mappers/private_key_mapper.dart';
import '../mappers/rhs_node_mapper.dart';

enum SupportedCircuits { mtp, sig }

class IdentityRepositoryImpl extends IdentityRepository {
  final WalletDataSource _walletDataSource;
  final LibIdentityDataSource _libIdentityDataSource;
  final RemoteIdentityDataSource _remoteIdentityDataSource;
  final StorageIdentityDataSource _storageIdentityDataSource;
  final StorageKeyValueDataSource _storageKeyValueDataSource;
  final HexMapper _hexMapper;
  final PrivateKeyMapper _privateKeyMapper;
  final IdentityDTOMapper _identityDTOMapper;
  final RhsNodeMapper _rhsNodeMapper;
  //final SMTStorageRepository _smtStorageRepository;

  IdentityRepositoryImpl(
    this._walletDataSource,
    this._libIdentityDataSource,
    this._remoteIdentityDataSource,
    this._storageIdentityDataSource,
    this._storageKeyValueDataSource,
    this._hexMapper,
    this._privateKeyMapper,
    this._identityDTOMapper,
    this._rhsNodeMapper,
    //this._smtStorageRepository,
  );

  /// Get an identifier from a String
  /// It will create and store a new [IdentityDTO] if it doesn't exists
  ///
  /// @return the associated identifier
  @override
  Future<String> createIdentity({String? privateKey}) async {
    try {
      // Create a wallet
      PrivadoIdWallet wallet = await _walletDataSource.createWallet(
          privateKey: _privateKeyMapper.mapFrom(privateKey));

      // Get the associated identifier
      String identifier = await _libIdentityDataSource.getIdentifier(
          pubX: wallet.publicKey[0], pubY: wallet.publicKey[1]);

      // Generate the smt
      String smt = "";
      //await _libIdentityDataSource.createSMT(_smtStorageRepository);

      // Store the identity
      await _libIdentityDataSource
          .getAuthClaim(pubX: wallet.publicKey[0], pubY: wallet.publicKey[1])
          .then((authClaim) {
        IdentityDTO dto = IdentityDTO(
            privateKey: _hexMapper.mapFrom(wallet.privateKey),
            identifier: identifier,
            authClaim: authClaim,
            smt: smt);

        return _storageIdentityDataSource
            .storeIdentity(identifier: identifier, identity: dto)
            .then((_) => dto);
      });

      // Return the identifier
      return Future.value(identifier);
    } catch (error) {
      throw IdentityException(error);
    }
  }

  /// Get an [IdentityEntity] from a String
  ///
  /// Used for retro compatibility with demo
  @override
  Future<IdentityEntity> getIdentityFromKey({String? privateKey}) {
    return Future.value(_privateKeyMapper.mapFrom(privateKey)).then((key) =>
        _walletDataSource
            .createWallet(privateKey: key)
            .then((wallet) => Future.wait([
                  _libIdentityDataSource.getIdentifier(
                      pubX: wallet.publicKey[0], pubY: wallet.publicKey[1]),
                  _libIdentityDataSource.getAuthClaim(
                      pubX: wallet.publicKey[0], pubY: wallet.publicKey[1]),
                  //_libIdentityDataSource.createSMT(_smtStorageRepository)
                ]).then((values) => IdentityEntity(
                    privateKey: _hexMapper.mapFrom(wallet.privateKey),
                    identifier: values[0],
                    authClaim: values[1],
                    smt: "" /*values[2]*/)))
            .catchError((error) => throw IdentityException(error)));
  }

  /// Get an identifier from a [privateKey]
  @override
  Future<String> getIdentifier({String? privateKey}) {
    return Future.value(_privateKeyMapper.mapFrom(privateKey))
        .then((key) => // Create a wallet from the private key
            _walletDataSource.createWallet(privateKey: key))
        .then((wallet) => // Get the associated identifier
            _libIdentityDataSource.getIdentifier(
                pubX: wallet.publicKey[0], pubY: wallet.publicKey[1]));
  }

  @override
  Future<String?> getCurrentIdentifier() {
    return _storageKeyValueDataSource
        .get(key: currentIdentifierKey)
        .then((value) => value == null ? null : value as String);
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

  @override
  Future<void> removeIdentity({required String identifier}) {
    return _storageIdentityDataSource.removeIdentity(identifier: identifier);
  }

  /// Sign a message through an identifier
  /// The [identifier] must be one returned previously by [createIdentity]
  /// so the [IdentityDTO] is known and stored
  ///
  /// Return a signature in hexadecimal format
  @override
  Future<String> signMessage(
      {required String identifier, required String message}) {
    return _storageIdentityDataSource
        .getIdentity(identifier: identifier)
        .then((dto) => _walletDataSource.signMessage(
            privateKey: _hexMapper.mapTo(dto.privateKey), message: message))
        .catchError((error) => throw IdentityException(error));
  }

  @override
  Future<List<dynamic>> fetchIdentityState({required String id}) {
    return _remoteIdentityDataSource
        .fetchIdentityState(id: id)
        .catchError((error) => throw FetchIdentityStateException(error));
  }

  @override
  Future<RhsNodeEntity> fetchStateRoots({required String url}) {
    return _remoteIdentityDataSource
        .fetchStateRoots(url: url)
        .then((dto) => _rhsNodeMapper.mapFrom(dto))
        .catchError((error) => throw FetchStateRootsException(error));
  }
}
