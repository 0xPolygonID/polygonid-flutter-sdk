import '../common/tuples.dart';

abstract class IdentityRepository {
  Future<Pair<String, String>> getIdentity({String? key});
}
