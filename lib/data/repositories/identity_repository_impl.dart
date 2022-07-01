import 'dart:typed_data';

import 'package:polygonid_flutter_sdk/data/data_sources/local_identity_data_source.dart';
import 'package:polygonid_flutter_sdk/domain/repositories/identity_repository.dart';

import '../../domain/common/tuples.dart';
import '../../domain/exceptions/identity_exceptions.dart';

class IdentityRepositoryImpl extends IdentityRepository {
  final LocalIdentityDataSource _localIdentityDataSource;

  IdentityRepositoryImpl(this._localIdentityDataSource);

  /// Get a private key and an identity from a String
  @override
  Future<Pair<String, String>> getIdentity({String? key}) async {
    return _localIdentityDataSource
        .generatePrivateKey(
          privateKey: key != null ? Uint8List.fromList(key.codeUnits) : null,
        )
        .then((privateKey) => _localIdentityDataSource
            .generateIdentifier(privateKey: privateKey)
            .then((identifier) => Pair(privateKey, identifier)))
        .catchError((error) => throw IdentityException(error));
  }
}
