import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';

import '../../../common/domain/tuples.dart';
import '../../../proof_generation/domain/entities/circuit_data_entity.dart';
import '../../data/dtos/request/auth/auth_request.dart';
import '../../data/dtos/request/auth/proof_scope_request.dart';

abstract class Iden3commRepository {
  Future<bool> authenticate(
      {required AuthRequest authRequest,
      required IdentityEntity identityEntity,
      required CircuitDataEntity authData,
      required List<Pair<ProofScopeRequest, Map<String, dynamic>>> proofList,
      String? pushToken});

  Future<String> getAuthToken(
      {required IdentityEntity identityEntity,
      required String message,
      required CircuitDataEntity authData});

  /// VOCABS
  /// get the vocabulary json-ld files to translate the values of the schemas
  /// to show them to end users in a natural language format in the apps
  //Future<List<Map<String, dynamic>>> getVocabs(
  //    {required Iden3Message iden3Message});

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
