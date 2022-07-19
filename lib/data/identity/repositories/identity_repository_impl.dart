import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/constants.dart';
import 'package:polygonid_flutter_sdk/data/identity/data_sources/jwz_data_source.dart';
import 'package:polygonid_flutter_sdk/data/identity/data_sources/storage_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/data/identity/dtos/identity_dto.dart';
import 'package:polygonid_flutter_sdk/domain/identity/entities/circuit_data.dart';
import 'package:polygonid_flutter_sdk/domain/identity/entities/identity.dart';
import 'package:polygonid_flutter_sdk/domain/identity/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/privadoid_wallet.dart';

import '../../../domain/identity/repositories/identity_repository.dart';
import '../data_sources/lib_identity_data_source.dart';
import '../data_sources/storage_key_value_data_source.dart';
import '../mappers/hex_mapper.dart';
import '../mappers/private_key_mapper.dart';

class IdentityRepositoryImpl extends IdentityRepository {
  final LibIdentityDataSource _libIdentityDataSource;
  final StorageIdentityDataSource _storageIdentityDataSource;
  final StorageKeyValueDataSource _storageKeyValueDataSource;
  final JWZDataSource _jwzDataSource;
  final HexMapper _hexMapper;
  final PrivateKeyMapper _privateKeyMapper;

  IdentityRepositoryImpl(
      this._libIdentityDataSource,
      this._storageIdentityDataSource,
      this._storageKeyValueDataSource,
      this._jwzDataSource,
      this._hexMapper,
      this._privateKeyMapper);

  /// Get an identifier from a String
  /// It will create and store a new [IdentityDTO] if it doesn't exists
  ///
  /// @return the associated identifier
  @override
  Future<String> createIdentity({String? privateKey}) async {
    try {
      Uint8List? key = _privateKeyMapper.mapFrom(privateKey);

      // Create a wallet from the private key
      PrivadoIdWallet wallet =
          await _libIdentityDataSource.createWallet(privateKey: key);

      // Get the associated identifier
      String identifier = await _libIdentityDataSource
          .createWallet(privateKey: key)
          .then((wallet) => _libIdentityDataSource.getIdentifier(
              pubX: wallet.publicKey[0], pubY: wallet.publicKey[1]));

      // Then try to find a previously stored identity
      await _storageIdentityDataSource
          .getIdentity(identifier: identifier)
          .onError<UnknownIdentityException>((error, _) {
        // If not found, store the new one
        return _libIdentityDataSource
            .getAuthClaim(pubX: wallet.publicKey[0], pubY: wallet.publicKey[1])
            .then((authClaim) {
          IdentityDTO dto = IdentityDTO(
              privateKey: _hexMapper.mapFrom(wallet.privateKey),
              identifier: identifier,
              authClaim: authClaim);

          return _storageIdentityDataSource
              .storeIdentity(identifier: identifier, identity: dto)
              .then((_) => dto);
        });
      });

      // Return the identifier
      return Future.value(identifier);
    } catch (error) {
      throw IdentityException(error);
    }
  }

  /// Get an [Identity] from a String
  ///
  /// Used for retro compatibility with demo
  @override
  Future<Identity> getIdentity({String? privateKey}) {
    return Future.value(_privateKeyMapper.mapFrom(privateKey)).then((key) =>
        _libIdentityDataSource
            .createWallet(privateKey: key)
            .then((wallet) => Future.wait([
                  _libIdentityDataSource.getIdentifier(
                      pubX: wallet.publicKey[0], pubY: wallet.publicKey[1]),
                  _libIdentityDataSource.getAuthClaim(
                      pubX: wallet.publicKey[0], pubY: wallet.publicKey[1])
                ]).then((values) => Identity(
                    privateKey: _hexMapper.mapFrom(wallet.privateKey),
                    identifier: values[0],
                    authClaim: values[1])))
            .catchError((error) => throw IdentityException(error)));
  }

  /// Sign a message through an identifier
  /// @param [identifier] must be one returned previously by [createIdentity]
  /// so the [IdentityDTO] is known and stored
  ///
  /// Return a signature in hexadecimal format
  @override
  Future<String> signMessage(
      {required String identifier, required String message}) {
    return _storageIdentityDataSource
        .getIdentity(identifier: identifier)
        .then((dto) => _libIdentityDataSource.signMessage(
            privateKey: _hexMapper.mapTo(dto.privateKey), message: message))
        .catchError((error) => throw IdentityException(error));
  }

  @override
  Future<String?> getCurrentIdentifier() {
    return _storageKeyValueDataSource
        .get(key: currentIdentifierKey)
        .then((value) => value == null ? null : value as String);
  }

  @override
  Future<void> removeIdentity({required String identifier}) {
    return _storageIdentityDataSource.removeIdentity(identifier: identifier);
  }

  @override
  Future<String> getAuthToken(
      {required String identifier,
      required CircuitData circuitData,
      required String message}) {
    return _storageIdentityDataSource.getIdentity(identifier: identifier).then(
        (dto) => _jwzDataSource.getAuthToken(
            privateKey: _hexMapper.mapTo(dto.privateKey),
            authClaim: dto.authClaim,
            message: message,
            circuitId: circuitData.circuitId,
            datFile: circuitData.datFile,
            zKeyFile: circuitData.zKeyFile));
  }

  @override
  Future<void> removeCurrentIdentity() {
    return getCurrentIdentifier().then((identifier) {
      if (identifier != null) {
        return removeIdentity(identifier: identifier).then((_) => null);
      }
    });
  }
}
