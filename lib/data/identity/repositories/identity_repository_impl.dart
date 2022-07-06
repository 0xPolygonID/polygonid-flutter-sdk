import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/domain/identity/entities/identity.dart';
import 'package:polygonid_flutter_sdk/domain/identity/exceptions/identity_exceptions.dart';

import '../../../domain/identity/repositories/identity_repository.dart';
import '../data_sources/local_identity_data_source.dart';

class IdentityRepositoryImpl extends IdentityRepository {
  final LocalIdentityDataSource _localIdentityDataSource;

  IdentityRepositoryImpl(this._localIdentityDataSource);

  /// Get an [Identity] from a String
  @override
  Future<Identity> createIdentity({String? privateKey}) {
    return _getPrivateKey(privateKey).then((key) => _localIdentityDataSource
        .createWallet(privateKey: key)
        .then((wallet) => Future.wait([
              _localIdentityDataSource.getIdentifier(
                  pubX: wallet.publicKey[0], pubY: wallet.publicKey[1]),
              _localIdentityDataSource.getAuthclaim(
                  pubX: wallet.publicKey[0], pubY: wallet.publicKey[1])
            ]).then((values) => Identity(
                privateKey: wallet.privateKey,
                identifier: values[0],
                authClaim: values[1])))
        .catchError((error) => throw IdentityException(error)));
  }

  // TODO: this part should go on a mapper, so we can test it separately
  Future<Uint8List?> _getPrivateKey(String? privateKey) {
    Uint8List? key;

    if (privateKey != null) {
      var private = privateKey.codeUnits;

      if (private.length > 32) {
        return Future.error(TooLongPrivateKeyException());
      }

      key = Uint8List(32);
      key.setAll(0, Uint8List.fromList(private));
      key.fillRange(private.length, 32, 0);
    }

    return Future.value(key);
  }
}
