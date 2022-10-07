import 'package:polygonid_flutter_sdk/iden3comm/data/dtos/iden3_message.dart';

import '../entities/iden3_message_entity.dart';

abstract class Iden3commRepository {
  Future<bool> authenticate(
      {required Iden3MessageEntity iden3message,
      required String identifier,
      String? pushToken});

  Future<String> getAuthToken(
      {required String identifier, required String message});

  /// VOCABS
  /// get the vocabulary json-ld files to translate the values of the schemas
  /// to show them to end users in a natural language format in the apps
  Future<List<Map<String, dynamic>>> getVocabs(
      {required Iden3Message iden3Message});

/*Future<List<ProofResponse>> getProofResponses(
      {required Iden3Message iden3message, String? challenge});

Future<List<ProofResponse>> getProofResponseList({
    List<ProofScopeRequest>? scope,
    required String privateKey,
  });

  Future<ProofResponse> getProofResponse(ProofScopeRequest proofRequest,
      String privateKey, CircuitDataEntity circuit, ClaimEntity authClaim);

  Future<String> getAuthToken(
      {required String identifier, required String message});*/
}
