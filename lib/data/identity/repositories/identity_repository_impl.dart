import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/data/identity/data_sources/storage_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/data/identity/dtos/identity_dto.dart';
import 'package:polygonid_flutter_sdk/domain/identity/entities/identity.dart';
import 'package:polygonid_flutter_sdk/domain/identity/exceptions/identity_exceptions.dart';
import 'package:polygonid_flutter_sdk/privadoid_wallet.dart';

import '../../../domain/identity/repositories/identity_repository.dart';
import '../data_sources/lib_identity_data_source.dart';
import '../mappers/hex_mapper.dart';
import '../mappers/private_key_mapper.dart';

class IdentityRepositoryImpl extends IdentityRepository {
  final LibIdentityDataSource _libIdentityDataSource;
  final StorageIdentityDataSource _storageIdentityDataSource;
  final HexMapper _hexMapper;
  final PrivateKeyMapper _privateKeyMapper;

  IdentityRepositoryImpl(this._libIdentityDataSource,
      this._storageIdentityDataSource, this._hexMapper, this._privateKeyMapper);

  /// Get an [Identity] from a String
  ///
  /// For now we return a full [Identity] to refactor little by little
  /// and not break the integration, but we will return just an identifier
  /// to not expose the private key and ease the SDK usage.
  @override
  Future<Identity> createIdentity({String? privateKey}) async {
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
      IdentityDTO? dto =
          await _storageIdentityDataSource.getIdentity(identifier: identifier);

      if (dto == null) {
        // If not found, store the new one
        return _libIdentityDataSource
            .getAuthclaim(pubX: wallet.publicKey[0], pubY: wallet.publicKey[1])
            .then((authClaim) => _storageIdentityDataSource
                .storeIdentity(
                    identifier: identifier,
                    identity: IdentityDTO(
                        privateKey: _hexMapper.mapFrom(wallet.privateKey),
                        identifier: identifier,
                        authClaim: authClaim))
                //.then((_) => identifier));
                .then((_) => Identity(
                    privateKey: _hexMapper.mapFrom(wallet.privateKey),
                    identifier: identifier,
                    authClaim: authClaim)));
      } else {
        return _libIdentityDataSource
            .getAuthclaim(pubX: wallet.publicKey[0], pubY: wallet.publicKey[1])
            .then((authClaim) => Identity(
                privateKey: _hexMapper.mapFrom(wallet.privateKey),
                identifier: identifier,
                authClaim: authClaim));
        // Otherwise, just return the identifier
        // return Future.value(identifier);
      }
    } catch (error) {
      throw IdentityException(error);
    }
  }

  /// Sign a message with a private key
  /// @param [privateKey] must be in the same format as [Identity.privateKey]
  ///
  /// Return a signature in hexadecimal format
  @override
  Future<String> signMessage(
      {required String privateKey, required String message}) {
    return Future.value(_hexMapper.mapTo(privateKey))
        .then((key) => _libIdentityDataSource.signMessage(
            privateKey: key, message: message))
        .catchError((error) => throw IdentityException(error));
  }
}
