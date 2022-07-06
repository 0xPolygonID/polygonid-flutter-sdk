import '../entities/identity.dart';

abstract class IdentityRepository {
  Future<Identity> createIdentity({String? privateKey});
}
