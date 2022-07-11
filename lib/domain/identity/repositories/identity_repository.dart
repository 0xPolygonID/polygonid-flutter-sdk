import '../entities/identity.dart';

abstract class IdentityRepository {
  Future<Identity> createIdentity({String? privateKey});

  Future<String> signMessage(
      {required String privateKey, required String message});
}
