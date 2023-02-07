import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/jwz/jwz_proof.dart';
import 'package:polygonid_flutter_sdk/proof/domain/use_cases/generate_proof_use_case.dart';

import '../iden3comm/domain/entities/request/auth/proof_scope_request.dart';
import '../proof/domain/entities/circuit_data_entity.dart';

abstract class PolygonIdSdkProof {
  Future<JWZProof> prove(
      {required String did,
      int? profileNonce,
        required ClaimEntity claim,
        required CircuitDataEntity circuitData,
        required ProofScopeRequest request,
        String? privateKey,
        String? challenge});
}

@injectable
class Proof implements PolygonIdSdkProof {
  final GenerateProofUseCase _proveUseCase;

  Proof(
    this._proveUseCase,
  );

  @override
  Future<JWZProof> prove(
      {required String did,
      int? profileNonce,
      required ClaimEntity claim,
      required CircuitDataEntity circuitData,
      required ProofScopeRequest request,
      String? privateKey,
      String? challenge}) {
    return _proveUseCase.execute(
        param: GenerateProofParam(
            did, profileNonce ?? 0, 0, claim, request, circuitData, privateKey, challenge));
  }
}
