import 'dart:typed_data';

abstract class IdentityRepository {
  Future<Map<String, dynamic>> createIdentity({Uint8List? privateKey});
}
