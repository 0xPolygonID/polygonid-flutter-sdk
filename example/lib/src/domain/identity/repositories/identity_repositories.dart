abstract class IdentityRepository{
  Future<String> createIdentity({String? privateKey});

  Future<String?> getCurrentIdentifier({String? privateKey});

}