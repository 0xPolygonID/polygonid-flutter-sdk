import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';

import '../../../common/domain/tuples.dart';
import '../../../proof_generation/domain/entities/circuit_data_entity.dart';
import '../../data/dtos/request/auth/auth_request.dart';
import '../../data/dtos/request/auth/proof_scope_request.dart';
import '../../data/dtos/response/auth/proof_response.dart';

abstract class Iden3commRepository {
  Future<bool> authenticate({
    required String url,
    required String authToken,
  });

  Future<String> getAuthToken(
      {required IdentityEntity identityEntity,
      required String message,
      required CircuitDataEntity authData});

  Future<String> getAuthResponse({
    required String identifier,
    required AuthRequest authRequest,
    required List<ProofResponse> scope,
    String? pushToken,
  });

  Future<List<ProofResponse>> getProofResponseList({
    required List<Pair<ProofScopeRequest, Map<String, dynamic>>> proofs,
  });
}
