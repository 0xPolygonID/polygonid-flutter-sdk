import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/data/identity/local_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/domain/repositories/identity_repository.dart';

import '../../../domain/exceptions/identity_exceptions.dart';

class IdentityRepositoryImpl extends IdentityRepository {
  final LocalIdentityDataSource _localIdentityDataSource;

  IdentityRepositoryImpl(this._localIdentityDataSource);

  /// Get a private key and an identity from a String
  @override
  Future<Map<String, dynamic>> createIdentity({Uint8List? privateKey}) async {
    return _localIdentityDataSource
        .createIdentity(privateKey: privateKey)
        .then((map) => map)
        .catchError((error) => throw IdentityException(error));
  }
}
