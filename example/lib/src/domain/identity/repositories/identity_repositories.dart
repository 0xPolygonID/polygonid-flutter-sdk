abstract class IdentityRepository{
  Future<String> createIdentity();

  Future<String?> getCurrentIdentifier();

}