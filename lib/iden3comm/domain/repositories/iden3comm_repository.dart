import '../entities/proof_entity.dart';
import '../entities/request/auth/auth_iden3_message_entity.dart';

abstract class Iden3commRepository {
  Future<void> authenticate({
    required AuthIden3MessageEntity request,
    required String authToken,
  });

  Future<String> getAuthResponse({
    required String identifier,
    required AuthIden3MessageEntity request,
    required List<ProofEntity> scope,
    String? pushUrl,
    String? pushToken,
    String? didIdentifier,
    String? packageName,
  });
}
