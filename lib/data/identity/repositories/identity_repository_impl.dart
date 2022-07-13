import 'package:polygonid_flutter_sdk/domain/identity/entities/identity.dart';
import 'package:polygonid_flutter_sdk/domain/identity/exceptions/identity_exceptions.dart';

import '../../../domain/identity/repositories/identity_repository.dart';
import '../data_sources/local_identity_data_source.dart';
import '../mappers/hex_mapper.dart';
import '../mappers/private_key_mapper.dart';

class IdentityRepositoryImpl extends IdentityRepository {
  final LocalIdentityDataSource _localIdentityDataSource;
  final HexMapper _hexMapper;
  final PrivateKeyMapper _privateKeyMapper;

  IdentityRepositoryImpl(
      this._localIdentityDataSource, this._hexMapper, this._privateKeyMapper);

  /// Get an [Identity] from a String
  @override
  Future<Identity> createIdentity({String? privateKey}) {
    return Future.value(_privateKeyMapper.mapFrom(privateKey)).then((key) =>
        _localIdentityDataSource
            .createWallet(privateKey: key)
            .then((wallet) => Future.wait([
                  _localIdentityDataSource.getIdentifier(
                      pubX: wallet.publicKey[0], pubY: wallet.publicKey[1]),
                  _localIdentityDataSource.getAuthclaim(
                      pubX: wallet.publicKey[0], pubY: wallet.publicKey[1])
                ]).then((values) => Identity(
                    privateKey: _hexMapper.mapFrom(wallet.privateKey),
                    identifier: values[0],
                    authClaim: values[1])))
            .catchError((error) => throw IdentityException(error)));
  }

  /// Sign a message with a private key
  /// @param [privateKey] must be in the same format as [Identity.privateKey]
  ///
  /// Return a signature in hexadecimal format
  @override
  Future<String> signMessage(
      {required String privateKey, required String message}) {
    return Future.value(_hexMapper.mapTo(privateKey))
        .then((key) => _localIdentityDataSource.signMessage(
            privateKey: key, message: message))
        .catchError((error) => throw IdentityException(error));
  }
}
