import '../../../identity/domain/entities/private_identity_entity.dart';
import '../../../proof/domain/entities/circuit_data_entity.dart';
import '../../../proof/domain/entities/gist_proof_entity.dart';
import '../../../proof/domain/entities/proof_entity.dart';
import '../entities/jwz_proof_entity.dart';
import '../entities/request/auth/auth_iden3_message_entity.dart';

abstract class Iden3commRepository {
  Future<void> authenticate({
    required AuthIden3MessageEntity request,
    required String authToken,
  });

  Future<String> getAuthToken({
    required PrivateIdentityEntity identity,
    required int profileNonce,
    required List<String> authClaim,
    required CircuitDataEntity authData,
    required ProofEntity incProof,
    required ProofEntity nonRevProof,
    required GistProofEntity gistProof,
    required Map<String, dynamic> treeState,
    required String message,
  });

  Future<String> getAuthResponse({
    required String identifier,
    required AuthIden3MessageEntity request,
    required List<JWZProofEntity> scope,
    String? pushUrl,
    String? pushToken,
    String? didIdentifier,
    String? packageName,
  });
}
