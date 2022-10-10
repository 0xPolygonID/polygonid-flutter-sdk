abstract class Iden3CommRepository {
  Future<void> authenticate({
    required String issuerMessage,
    required String identifier,
  });
}
