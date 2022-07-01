import 'dart:typed_data';

import 'package:injectable/injectable.dart';

import '../../privadoid_sdk.dart';

// TODO: move all static code here
@injectable
class LibWrapper {
  Future<Map<String, dynamic>> createIdentity({Uint8List? privateKey}) {
    return PrivadoIdSdk.createIdentity(privateKey: privateKey);
  }
}

class LocalIdentityDataSource {
  final LibWrapper _libWrapper;

  LocalIdentityDataSource(this._libWrapper);

  Future<Map<String, dynamic>> createIdentity({Uint8List? privateKey}) {
    return _libWrapper.createIdentity(privateKey: privateKey);
  }
}
